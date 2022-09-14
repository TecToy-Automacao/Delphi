// Original em:  http://blong.com/Articles/Delphi10NFC/NFC.htm

{
  Para fazer com que sua aplicação seja abera com a leitura de qualquer NFC, adicione no seu Manifest

  <intent-filter>
  <action android:name="android.nfc.action.NDEF_DISCOVERED"/>
  <category android:name="android.intent.category.DEFAULT"/>
  <data android:mimeType="text/plain" />
  </intent-filter>

  Saiba mais em: http://blong.com/Articles/Delphi10NFC/NFC.htm#ACTION_NDEF_DISCOVERED
}

unit MainFormU;

interface

uses
  Androidapi.JNI.Nfc,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App,
  System.Messaging,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Platform,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, NFCHelper,
  FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  System.ImageList, FMX.ImgList;

ResourceString
  CERROR_NO_NFC_ADAPTER = 'Nenhum Adaptador NFC encontrado';
  CINFO_NFC_SETTINGS = 'NFC está desabilitada' + sLineBreak +
                  'Abrindo configurações de NFC';
  CINFO_NFC_DISABLED = 'Funcionalidade de NFC desabilitda no sistema';

type
  TMainForm = class(TForm)
    StyleBook1: TStyleBook;
    Memo1: TMemo;
    tbLista: TToolBar;
    lbAvisoNFC: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    btAlternarNFC: TButton;
    btLimpar: TButton;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btAlternarNFCClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FNfcAdapter: JNfcAdapter;
    FNFCSettingsChecked: Boolean;
    FPendingIntent: JPendingIntent;

    FAppEvents: IFMXApplicationEventService;

    procedure ChangeNFCStatus(NFCEnable: Boolean);
    procedure EnableForegroundDispatch;
    procedure DisableForegroundDispatch;

    function ApplicationEventHandler(AAppEvent: TApplicationEvent;
      AContext: TObject): Boolean;

    function AskPermissions: Boolean;
    function IsNFCEnabledByUser: Boolean;
  public
    { Public declarations }
    procedure HandleIntentMessage(const Sender: TObject; const M: TMessage);
    procedure OnNewNfcIntent(Intent: JIntent);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  System.TypInfo,
  System.Permissions,
  FMX.Platform.Android,
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Widget;

{ TMainForm }

procedure Toast(const AMsg: string; ShortDuration: Boolean = True);
var
  ToastLength: Integer;
begin
{$IFNDEF ANDROID}
  TDialogServiceAsync.ShowMessage(AMsg);
{$ELSE}
  if ShortDuration then
    ToastLength := TJToast.JavaClass.LENGTH_SHORT
  else
    ToastLength := TJToast.JavaClass.LENGTH_LONG;

  TJToast.JavaClass.makeText(SharedActivityContext, StrToJCharSequence(AMsg),
    ToastLength).show;
  Application.ProcessMessages;
{$ENDIF}
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ChangeNFCStatus(False);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  ClassIntent: JIntent;
begin
  Log.d('OnCreate');
  FNFCSettingsChecked := False;
  // Set up event that triggers when app is brought back to foreground
  if TPlatformServices.Current.SupportsPlatformService
    (IFMXApplicationEventService, IInterface(FAppEvents)) then
  begin
    FAppEvents.SetApplicationEventHandler(ApplicationEventHandler);
  end;

  // Subscribe to the FMX message that is sent when onNewIntent is called
  // with an intent containing any of these 3 intent actions.
  // Support for this was added in Delphi 10 Seattle.
  MainActivity.registerIntentAction(TJNfcAdapter.JavaClass.ACTION_NDEF_DISCOVERED);
  MainActivity.registerIntentAction(TJNfcAdapter.JavaClass.ACTION_TECH_DISCOVERED);
  MainActivity.registerIntentAction(TJNfcAdapter.JavaClass.ACTION_TAG_DISCOVERED);

  TMessageManager.DefaultManager.SubscribeToMessage(TMessageReceivedNotification, HandleIntentMessage);
  FNfcAdapter := TJNfcAdapter.JavaClass.getDefaultAdapter(TAndroidHelper.Context);
  if (FNfcAdapter = nil) then
  begin
    lbAvisoNFC.Text := CERROR_NO_NFC_ADAPTER;
    Exit;
  end;

  // Set up the pending intent needed for enabling NFC foreground dispatch
  ClassIntent := TJIntent.JavaClass.init(TAndroidHelper.Context, TAndroidHelper.Activity.getClass);
  ClassIntent.addFlags(TJIntent.JavaClass.FLAG_ACTIVITY_SINGLE_TOP);
  FPendingIntent := TJPendingIntent.JavaClass.getActivity(TAndroidHelper.Context, 0, ClassIntent, 0);
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  Intent: JIntent;
begin
  Log.d('OnActivate');
  Intent := TAndroidHelper.Activity.getIntent;

  // Verificando se a aplicação foi Ativada, por Intent relacionado ao NFC
  if not TJIntent.JavaClass.ACTION_MAIN.equals(Intent.getAction) then
  begin
    Log.d('Passing along received intent');
    // Chama o Evento que cuida da leitura da Tag de NFC do Intent
    OnNewNfcIntent(Intent);
  end;
end;

function TMainForm.AskPermissions: Boolean;
Var
  Ok: Boolean;
begin
  Ok := True;
  {$IfDef ANDROID}
  PermissionsService.RequestPermissions( [JStringToString(TJManifest_permission.JavaClass.NFC)],
      {$IfDef DELPHI28_UP}
      procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
      {$Else}
      procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
      {$EndIf}
      var
        GR: TPermissionStatus;
      begin
        Ok := (Length(AGrantResults) = 1);

        if Ok then
        begin
          for GR in AGrantResults do
            if (GR <> TPermissionStatus.Granted) then
            begin
              Ok := False;
              Break;
            end;
        end;
      end );

  if not OK then
    Toast('Erro ao obter permissões para NFC');
  {$EndIf}

  Result := Ok;
end;

procedure TMainForm.btAlternarNFCClick(Sender: TObject);
begin
  ChangeNFCStatus((btAlternarNFC.Tag = 0));
end;

procedure TMainForm.btLimparClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TMainForm.ChangeNFCStatus(NFCEnable: Boolean);
begin
  if (FNfcAdapter = nil) then
  begin
    Toast(CERROR_NO_NFC_ADAPTER);
    Exit;
  end;

  if NFCEnable then
  begin
    if IsNFCEnabledByUser then
      Exit;
    if not AskPermissions then
      Exit;
    EnableForegroundDispatch;
    lbAvisoNFC.Text := 'Aproxime uma Tag NFC...';
    btAlternarNFC.Text := 'Desativar NFC';
    btAlternarNFC.Tag := 1;
  end
  else
  begin
    if not IsNFCEnabledByUser then
      Exit;
    DisableForegroundDispatch;
    lbAvisoNFC.Text := 'Exemplo de Leitura NFC';
    btAlternarNFC.Text := 'Ativar NFC';
    btAlternarNFC.Tag := 0;
  end;
end;

procedure TMainForm.DisableForegroundDispatch;
begin
  if (FNfcAdapter <> Nil) then
    FNfcAdapter.disableForegroundDispatch(TAndroidHelper.Activity)
end;

procedure TMainForm.EnableForegroundDispatch;
var
  PEnv: PJniEnv;
  AdapterClass: JNIClass;
  NfcAdapterObject, PendingIntentObject: JNIObject;
  MethodID: JNIMethodID;
begin
  if (FNfcAdapter = Nil) then
    Exit;

  // We can't just call the imported NfcAdapter method enableForegroundDispatch
  // as it will crash due to a shortcoming in the JNI Bridge, which does not
  // support 2D array parameters. So instead we call it via a manual JNI call.
  PEnv := TJNIResolver.GetJNIEnv;
  NfcAdapterObject := (FNfcAdapter as ILocalObject).GetObjectID;
  PendingIntentObject := (FPendingIntent as ILocalObject).GetObjectID;
  AdapterClass := PEnv^.GetObjectClass(PEnv, NfcAdapterObject);

  // Get the signature with:
  // javap -s -classpath <path_to_android_platform_jar> android.nfc.NfcAdapter
  MethodID := PEnv^.GetMethodID(PEnv, AdapterClass, 'enableForegroundDispatch',
    '(Landroid/app/Activity;Landroid/app/PendingIntent;' +
    '[Landroid/content/IntentFilter;[[Ljava/lang/String;)V');

  // Clean up
  PEnv^.DeleteLocalRef(PEnv, AdapterClass);

  // Finally call the target Java method
  PEnv^.CallVoidMethodA(PEnv, NfcAdapterObject, MethodID,
    PJNIValue(ArgsToJNIValues([JavaContext, PendingIntentObject, nil, nil])));
end;

function TMainForm.ApplicationEventHandler(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
  Log.d('', Self, 'ApplicationEventHandler',
    Format('+ %s', [GetEnumName(TypeInfo(TApplicationEvent), Integer(AAppEvent))]));

  Result := True;
  case AAppEvent of
    TApplicationEvent.FinishedLaunching:
      begin
        //
      end;
    TApplicationEvent.BecameActive:
      begin
        if (FNfcAdapter <> nil) then
        begin
          if not FNfcAdapter.isEnabled then
          begin
            if not FNFCSettingsChecked then
            begin
              Toast(CINFO_NFC_SETTINGS);
              TAndroidHelper.Activity.startActivity(TJIntent.JavaClass.init(StringToJString('android.settings.NFC_SETTINGS')));
              FNFCSettingsChecked := True;
            end
            else
            begin
              Toast(CINFO_NFC_DISABLED);
              ChangeNFCStatus(False);
            end;
          end
          else
          begin
            if IsNFCEnabledByUser then
              EnableForegroundDispatch;
          end;
        end
      end;

    TApplicationEvent.WillBecomeInactive:
      begin
//        if IsNFCEnabledByUser then
//          DisableForegroundDispatch;
      end;

    TApplicationEvent.WillTerminate:
      begin
        //
      end;
  end;

  Log.d('', Self, 'ApplicationEventHandler', '-');
end;

procedure TMainForm.HandleIntentMessage(const Sender: TObject; const M: TMessage);
var
  Intent: JIntent;
begin
  if M is TMessageReceivedNotification then
  begin
    Intent := TMessageReceivedNotification(M).Value;
    if (Intent <> Nil) then
    begin
      if TJNfcAdapter.JavaClass.ACTION_NDEF_DISCOVERED.equals(Intent.getAction) or
         TJNfcAdapter.JavaClass.ACTION_TECH_DISCOVERED.equals(Intent.getAction) or
         TJNfcAdapter.JavaClass.ACTION_TAG_DISCOVERED.equals(Intent.getAction) then
      begin
        OnNewNfcIntent(Intent);
      end;
    end;
  end;
end;

function TMainForm.IsNFCEnabledByUser: Boolean;
begin
  Result := (btAlternarNFC.Tag = 1);
end;

procedure TMainForm.OnNewNfcIntent(Intent: JIntent);
var
  TagParcel: JParcelable;
  Tag: JTag;
begin
  Log.d('TMainForm.OnNewIntent');
  TAndroidHelper.Activity.setIntent(Intent);
  Log.d('Intent action = %s', [JStringToString(Intent.getAction)]);

  Log.d('Getting Tag parcel from the received Intent');
  TagParcel := Intent.getParcelableExtra(TJNfcAdapter.JavaClass.EXTRA_TAG);
  if (TagParcel <> nil) then
  begin
    Log.d('Wrapping tag from the parcel');
    Tag := TJTag.Wrap(TagParcel);
  end;

  Memo1.Lines.Clear;
  HandleNfcTag(Tag,
    procedure(const Msg: string)
    begin
      Memo1.Lines.Text := Msg;
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Lido em: '+FormatDateTime('dd/mm - hh:nn:ss.zzz', Now));

    end);
end;

end.
