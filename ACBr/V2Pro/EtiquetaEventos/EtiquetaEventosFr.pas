{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit EtiquetaEventosFr;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Gestures, System.Actions, FMX.ActnList,
  ACBrBase, ACBrPosPrinter,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ListBox, FMX.Layouts, FMX.Edit, FMX.EditBox, FMX.SpinBox,
  FMX.ScrollBox, FMX.Memo, System.ImageList, FMX.ImgList, FMX.VirtualKeyboard,
  FMX.Memo.Types, Data.Bind.Components, Data.Bind.ObjectScope, Data.Bind.GenData,
  Fmx.Bind.GenData, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, 
  ACBrUtil.FilesIO, FMX.Media, FMX.Objects, FMX.SearchBox;

const
  CURL_LISTA_EXEMPLO = 'https://raw.githubusercontent.com/TecToy-Automacao/Delphi/main/ACBr/V2Pro/EtiquetaEventos/csv/exemplo_lista.csv';

type
  TEtiquetaEventosForm = class(TForm)
    GestureManager1: TGestureManager;
    tabsPrincipal: TTabControl;
    tabConfig: TTabItem;
    tbconfig: TToolBar;
    lblTituloConfig: TLabel;
    tabLista: TTabItem;
    tbLista: TToolBar;
    lblInscritos: TLabel;
    ACBrPosPrinter1: TACBrPosPrinter;
    StyleBook1: TStyleBook;
    tabImpressao: TTabItem;
    tbImpressao: TToolBar;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    ListBox1: TListBox;
    SpeedButton2: TSpeedButton;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    ListBoxGroupHeader6: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    edtLinha1: TEdit;
    ListBoxItem2: TListBoxItem;
    edtLinha2: TEdit;
    ListBoxItem3: TListBoxItem;
    edtLinha3: TEdit;
    ListBoxItem4: TListBoxItem;
    edtLinha4: TEdit;
    ListBoxItem5: TListBoxItem;
    FDMemTable1: TFDMemTable;
    LinkFillControlToField1: TLinkFillControlToField;
    BindSourceDB1: TBindSourceDB;
    btQRCode: TButton;
    CameraComponent1: TCameraComponent;
    tabCamera: TTabItem;
    SpeedButton3: TSpeedButton;
    ToolBar1: TToolBar;
    Label6: TLabel;
    SpeedButton4: TSpeedButton;
    lblScanStatus: TLabel;
    GridPanelLayout3: TGridPanelLayout;
    btImprimir: TButton;
    Button2: TButton;
    tabsConfig: TTabControl;
    tabConfImpressora: TTabItem;
    tabConfLista: TTabItem;
    tabEtiqueta: TTabItem;
    lbConfImpressora: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    lbModelos: TListBoxItem;
    cbxModelo: TComboBox;
    cbControlePorta: TCheckBox;
    cbxPagCodigo: TComboBox;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    lbImpressoras: TListBoxItem;
    cbxImpressorasBth: TComboBox;
    btnProcurarBth: TCornerButton;
    chbTodasBth: TCheckBox;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    lbLarguraEspacejamento: TListBoxItem;
    GridPanelLayout1: TGridPanelLayout;
    Label2: TLabel;
    Label3: TLabel;
    seColunas: TSpinBox;
    seEspLinhas: TSpinBox;
    ListBoxGroupHeader4: TListBoxGroupHeader;
    lbCodBarras: TListBoxItem;
    GridPanelLayout5: TGridPanelLayout;
    Label1: TLabel;
    Label4: TLabel;
    cbHRI: TCheckBox;
    seBarrasLargura: TSpinBox;
    seBarrasAltura: TSpinBox;
    cbSuportaBMP: TCheckBox;
    lbConfLista: TListBox;
    ListBoxGroupHeader7: TListBoxGroupHeader;
    lbDownload: TListBoxItem;
    gplConfBotoes: TGridPanelLayout;
    btLerConfig: TCornerButton;
    btSalvarConfig: TCornerButton;
    mURLDownload: TMemo;
    recURLDownload: TRectangle;
    lbEtiqueta: TListBox;
    ListBoxGroupHeader5: TListBoxGroupHeader;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    seCaracteresLinha: TSpinBox;
    Label8: TLabel;
    ListBoxItem8: TListBoxItem;
    seLinhasPular: TSpinBox;
    Label9: TLabel;
    GridPanelLayout2: TGridPanelLayout;
    btLimparLista: TButton;
    btBaixarLista: TButton;
    imgCamera: TImage;
    ListBoxGroupHeader8: TListBoxGroupHeader;
    cbImpCodBarras: TCheckBox;
    ListBoxItem9: TListBoxItem;
    cbLeitorIntegrado: TCheckBox;
    tiStart: TTimer;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackClick(Sender: TObject);
    procedure btnProcurarBthClick(Sender: TObject);
    procedure btLerConfigClick(Sender: TObject);
    procedure btSalvarConfigClick(Sender: TObject);
    procedure btImprimirClick(Sender: TObject);
    procedure tabsPrincipalChange(Sender: TObject);
    procedure btBaixarListaClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure CameraComponent1SampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btQRCodeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btLimparListaClick(Sender: TObject);
    procedure tiStartTimer(Sender: TObject);
  private
    FVKService: IFMXVirtualKeyboardService;
    FScanInProgress: Boolean;
    FFrameTake: Integer;
    FScanBitmap: TBitmap;
    FSearchBox: TSearchBox;
    FSairClick: TDateTime;
    FLinhasNome: Integer;

    function CalcularNomeArqINI: String;
    function CalcularNomeArquivoLista: String;
    function ColunasTextoImpressao: Integer;

    procedure CarregarModelosInternos;
    procedure LerConfiguracao;
    procedure GravarConfiguracao;
    procedure ConfigurarACBrPosPrinter;
    function PedirPermissoes: Boolean;

    procedure IniciarCamera;
    procedure PararCamera;
    procedure ParseImage;
    procedure LimparEditsImpressao;

    procedure VoltarParaLista;
    procedure IrParaImpressao;
    procedure IrParaCamera;
    procedure IrParaConfig;

    procedure BaixarLista(AURL: String);
    procedure LerArquivoCSV;
    procedure PrepararTextoParaImpressao(ATexto: string; ALines: TStringList; MaxLinhas: Integer);
  public
    { Public declarations }
  end;

var
  EtiquetaEventosForm: TEtiquetaEventosForm;

implementation

uses
  System.typinfo, System.IniFiles, System.StrUtils, System.Math,
  System.DateUtils,
  System.Permissions,
  {$IfDef ANDROID}
  Androidapi.Helpers, Androidapi.JNI.Os, Androidapi.JNI.JavaTypes,
  Androidapi.IOUtils, Androidapi.JNI.Widget, FMX.Helpers.Android,
  {$EndIf}
  FMX.DialogService.Async,
  FMX.Platform,
  ACBrUtil.Strings,
  ACBrConsts, 
  httpsend, ssl_openssl,
  ZXing.ReadResult,
  ZXing.ScanManager,
  ZXing.BarcodeFormat;

{$R *.fmx}

procedure Toast(const AMsg: string; ShortDuration: Boolean = True);
var
  ToastLength: Integer;
begin
  {$IfNDef ANDROID}
   TDialogServiceAsync.ShowMessage(AMsg);
  {$Else}
   if ShortDuration then
     ToastLength := TJToast.JavaClass.LENGTH_SHORT
   else
     ToastLength := TJToast.JavaClass.LENGTH_LONG;

   TJToast.JavaClass.makeText(SharedActivityContext, StrToJCharSequence(AMsg), ToastLength).show;
   Application.ProcessMessages;
  {$EndIf}
end;

procedure TEtiquetaEventosForm.FormCreate(Sender: TObject);
var
  p: TACBrPosPaginaCodigo;
  i: Integer;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FVKService));
  FScanInProgress := False;
  FScanBitmap := Nil;
  FFrameTake := 0;
  FLinhasNome:= 0;
  FSairClick := 0;

  tabsPrincipal.TabPosition := TTabPosition.None;
  tabsPrincipal.First;
  tabsConfig.First;

  CarregarModelosInternos;
  btnProcurarBthClick(Sender);
  cbxPagCodigo.Items.Clear ;
  For p := Low(TACBrPosPaginaCodigo) to High(TACBrPosPaginaCodigo) do
    cbxPagCodigo.Items.Add( GetEnumName(TypeInfo(TACBrPosPaginaCodigo), integer(p) ) ) ;

  for i := 0 to ListView1.Controls.Count-1 do
  begin
    if ListView1.Controls[I] is TSearchBox then
    begin
      FSearchBox := TSearchBox(ListView1.Controls[I]);
      Break;
    End;
  end;

  LerConfiguracao;
  LerArquivoCSV;
  tiStart.Enabled := True;
end;

function TEtiquetaEventosForm.PedirPermissoes: Boolean;
Var
  Ok: Boolean;
begin
  Ok := True;
  {$IfDef ANDROID}
  PermissionsService.RequestPermissions( [JStringToString(TJManifest_permission.JavaClass.BLUETOOTH),
                                          JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_ADMIN),
                                          JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_PRIVILEGED),
                                          JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE),
                                          JStringToString(TJManifest_permission.JavaClass.LOCATION_HARDWARE),
                                          JStringToString(TJManifest_permission.JavaClass.CAMERA)],
      {$IfDef DELPHI28_UP}
      procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
      {$Else}
      procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
      {$EndIf}
      var
        GR: TPermissionStatus;
      begin
        Ok := (Length(AGrantResults) = 6);

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
    Toast('Erro ao obter permissões');
  {$EndIf}

  Result := Ok;
end;

procedure TEtiquetaEventosForm.PrepararTextoParaImpressao(ATexto: string; ALines: TStringList; MaxLinhas: Integer);
var
  s, sl: string;
begin
  ALines.Clear;
  if (MaxLinhas < 1) then
    Exit;

  s := UpperCase(TiraAcentos(ATexto));
  ALines.Text := QuebraLinhas(s, ColunasTextoImpressao);
  if (ALines.Count > MaxLinhas) then
  begin
    ALines.Clear;
    ALines.Text := AjustaLinhas(s, ColunasTextoImpressao, MaxLinhas);
  end;

  if (ALines.Count > MaxLinhas) then
    ALines.Capacity := MaxLinhas;
end;

procedure TEtiquetaEventosForm.SpeedButton3Click(Sender: TObject);
begin
  IrParaConfig;
end;

procedure TEtiquetaEventosForm.tabsPrincipalChange(Sender: TObject);
begin
  ACBrPosPrinter1.Desativar;
end;

procedure TEtiquetaEventosForm.tiStartTimer(Sender: TObject);
begin
  tiStart.Enabled := False;
  VoltarParaLista;
end;

procedure TEtiquetaEventosForm.VoltarParaLista;
begin
  PararCamera;
  FLinhasNome := 0;
  if Assigned(FSearchBox) then
    FSearchBox.Text := '';

  ACBrPosPrinter1.Desativar;
  tabsPrincipal.SetActiveTabWithTransition(tabLista, TTabTransition.Slide);
  FSearchBox.SetFocus;
end;

procedure TEtiquetaEventosForm.BaixarLista(AURL: String);
var
  NomeArq: string;
  MS: TMemoryStream;
begin
  NomeArq := CalcularNomeArquivoLista;
  if FileExists(NomeArq) then
    DeleteFile(NomeArq);

  MS := TMemoryStream.Create;
  try
    if HttpGetBinary(AURL, MS) then
      MS.SaveToFile(NomeArq)
    else
      Toast('Erro ao baixar arquivo de: ' + sLineBreak + AURL);
  finally
    MS.Free;
  end;
end;

procedure TEtiquetaEventosForm.btImprimirClick(Sender: TObject);
var
  s: String;
  SL: TStringList;
  i: Integer;
begin
  if edtLinha1.Text.IsEmpty and
     edtLinha2.Text.IsEmpty and
     edtLinha3.Text.IsEmpty and
     edtLinha4.Text.IsEmpty then
     Exit;

  if not ACBrPosPrinter1.Ativo then
    ConfigurarACBrPosPrinter;

  SL := TStringList.Create;
  try
    SL.Add(PadCenter(edtLinha1.Text.Trim, ColunasTextoImpressao));
    SL.Add(PadCenter(edtLinha2.Text.Trim, ColunasTextoImpressao));
    SL.Add(PadCenter(edtLinha3.Text.Trim, ColunasTextoImpressao));
    if not cbImpCodBarras.IsChecked then
      SL.Add(PadCenter(edtLinha4.Text.Trim, ColunasTextoImpressao))
    else
      SL.Add('</ce><code93>'+edtLinha4.Text.Trim+'</code93>');

    FLinhasNome := max(min(FLinhasNome, 2), 1);
    SL[0] := '<in>'+SL[0];
    SL[FLinhasNome] := '</in>'+ SL[FLinhasNome];

    SL[0] := '</zera><n><e><a>'+SL[0]; // Zera, Liga Negrito, Expandido, Altura Dupla

    for i := 1 to Trunc(seLinhasPular.Value) do
      SL.Add('');

    ACBrPosPrinter1.Ativar;
    ACBrPosPrinter1.Imprimir(SL.Text);
  finally
    SL.Free;
  end;
end;

procedure TEtiquetaEventosForm.btLerConfigClick(Sender: TObject);
begin
  LerConfiguracao;
end;

procedure TEtiquetaEventosForm.btLimparListaClick(Sender: TObject);
begin
  mURLDownload.Lines.Clear;
end;

procedure TEtiquetaEventosForm.btnBackClick(Sender: TObject);
begin
  VoltarParaLista;
end;

procedure TEtiquetaEventosForm.btnProcurarBthClick(Sender: TObject);
var
  SL: TStringList;
begin
  if not PedirPermissoes then
    exit;

  cbxImpressorasBth.Items.Clear;
  try
    ACBrPosPrinter1.Device.AcharPortasBlueTooth( cbxImpressorasBth.Items, chbTodasBth.IsChecked );
    cbxImpressorasBth.Items.Add('NULL');
  except
  end;

  ACBrPosPrinter1.Device.AcharPortasSeriais( cbxImpressorasBth.Items );

  SL := TStringList.Create;
  try
    FindFiles('/dev/ttyS?', SL, True, fstFileName, fsdAscending);
    cbxImpressorasBth.Items.AddStrings(SL);
    FindFiles('/dev/ttyUSB?', SL, True, fstFileName, fsdAscending);
    cbxImpressorasBth.Items.AddStrings(SL);
    FindFiles('/dev/ttyACM?', SL, True, fstFileName, fsdAscending);
    cbxImpressorasBth.Items.AddStrings(SL);
  finally
    SL.Free;
  end;
end;

procedure TEtiquetaEventosForm.btQRCodeClick(Sender: TObject);
begin
  IrParaCamera;
  IniciarCamera;
end;

procedure TEtiquetaEventosForm.btSalvarConfigClick(Sender: TObject);
begin
  GravarConfiguracao;
end;

procedure TEtiquetaEventosForm.btBaixarListaClick(Sender: TObject);
begin
  if mURLDownload.Text.Trim.IsEmpty then
    mURLDownload.Text := CURL_LISTA_EXEMPLO;

  BaixarLista(mURLDownload.Text);
  LerArquivoCSV;
  VoltarParaLista;
end;

procedure TEtiquetaEventosForm.Button2Click(Sender: TObject);
begin
  LimparEditsImpressao;
  FLinhasNome := 0;
end;

function TEtiquetaEventosForm.CalcularNomeArqINI: String;
begin
  Result := ApplicationPath + 'ACBrPosPrinter.ini';
end;

function TEtiquetaEventosForm.CalcularNomeArquivoLista: String;
begin
  Result := ApplicationPath+'lista.csv';
end;

procedure TEtiquetaEventosForm.CameraComponent1SampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    CameraComponent1.SampleBufferToBitmap(imgCamera.Bitmap, True);
    if (FScanInProgress) then
      Exit;

    inc(FFrameTake);
    if (FFrameTake mod 4 <> 0) then
      Exit;

    if Assigned(FScanBitmap) then
      FreeAndNil(FScanBitmap);
    FScanBitmap := TBitmap.Create();
    FScanBitmap.Assign(imgCamera.Bitmap);

    ParseImage();
  end);
end;

procedure TEtiquetaEventosForm.CarregarModelosInternos;
var
  m: TACBrPosPrinterModelo;
begin
  cbxModelo.Items.Clear;
  For m := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
     cbxModelo.Items.Add( GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(m) ) );

  lbImpressoras.Enabled := True;
end;

function TEtiquetaEventosForm.ColunasTextoImpressao: Integer;
begin
  Result := Trunc(seCaracteresLinha.Value);
end;

procedure TEtiquetaEventosForm.ConfigurarACBrPosPrinter;
begin
  if not PedirPermissoes then
    exit;

  if Assigned(cbxModelo.Selected) then
    ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo(cbxModelo.ItemIndex)
  else
    ACBrPosPrinter1.Modelo := ppTexto;

  if Assigned(cbxImpressorasBth.Selected) then
    ACBrPosPrinter1.Porta := cbxImpressorasBth.Selected.Text
  else if cbxImpressorasBth.ItemIndex = cbxImpressorasBth.Items.IndexOf('NULL') then
    cbxImpressorasBth.ItemIndex := -1;

  if Assigned(cbxPagCodigo.Selected) then
    ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo(cbxPagCodigo.ItemIndex);

  ACBrPosPrinter1.ColunasFonteNormal := Trunc(seColunas.Value);
  ACBrPosPrinter1.EspacoEntreLinhas := Trunc(seEspLinhas.Value);
  ACBrPosPrinter1.LinhasEntreCupons := Trunc(seLinhasPular.Value);
  ACBrPosPrinter1.ConfigLogo.KeyCode1 := 1;
  ACBrPosPrinter1.ConfigLogo.KeyCode2 := 0;
  ACBrPosPrinter1.ControlePorta := cbControlePorta.IsChecked;
end;

procedure TEtiquetaEventosForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  t: Int64;
begin
  if Key = vkHardwareBack then
  begin
    if (FVKService <> nil) then
    begin
      if TVirtualKeyboardState.Visible in FVKService.VirtualKeyboardState then
      begin
        FVKService.HideVirtualKeyboard;
        Key := 0;
        Exit
      end;
    end;

    if (tabsPrincipal.ActiveTab = tabConfig) then
    begin
      GravarConfiguracao;
      tabsPrincipal.First;
      Key := 0;
      Exit;
    end;

    if (tabsPrincipal.ActiveTab = tabCamera) then
    begin
      PararCamera;
      VoltarParaLista;
      Key := 0;
      Exit;
    end;

    if (tabsPrincipal.ActiveTab = tabImpressao) then
    begin
      VoltarParaLista;
      Key := 0;
      Exit;
    end;

    if Assigned(FSearchBox) and (not FSearchBox.Text.IsEmpty) then
    begin
      VoltarParaLista;
      Key := 0;
      Exit;
    end;

    t := MilliSecondsBetween(FSairClick, now);
    if (t > 2000) then
    begin
      FSairClick := Now;
      Toast('Clicar novamente para Sair');
      Key := 0;
      Exit;
    end;
  end;
end;

procedure TEtiquetaEventosForm.GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if tabsPrincipal.ActiveTab <> tabsPrincipal.Tabs[tabsPrincipal.TabCount - 1] then
          tabsPrincipal.Next;
        Handled := True;
      end;

    sgiRight:
      begin
        if tabsPrincipal.ActiveTab <> tabsPrincipal.Tabs[0] then
          tabsPrincipal.Previous;
        Handled := True;
      end;
  end;
end;

procedure TEtiquetaEventosForm.GravarConfiguracao;
Var
  ArqINI : String ;
  INI : TIniFile ;
begin
  ArqINI := CalcularNomeArqINI;

  INI := TIniFile.Create(ArqINI);
  try
    INI.WriteString('Lista','URL',mURLDownload.Text);
    INI.WriteInteger('PosPrinter','Modelo', cbxModelo.ItemIndex);
    INI.WriteInteger('PosPrinter','PaginaDeCodigo',cbxPagCodigo.ItemIndex);
    INI.WriteBool('PosPrinter','BMP',cbSuportaBMP.IsChecked);
    if Assigned(cbxImpressorasBth.Selected) then
      INI.WriteString('PosPrinter','Porta', cbxImpressorasBth.Selected.Text);

    INI.WriteInteger('PosPrinter','Colunas', Trunc(seColunas.Value) );
    INI.WriteInteger('PosPrinter','EspacoEntreLinhas', Trunc(seEspLinhas.Value) );
    INI.WriteBool('PosPrinter','ControlePorta',cbControlePorta.IsChecked);
    INI.WriteInteger('PosPrinter.Barras','Largura',Trunc(seBarrasLargura.Value));
    INI.WriteInteger('PosPrinter.Barras','Altura',Trunc(seBarrasAltura.Value));
    INI.WriteBool('PosPrinter.Barras','HRI',cbHRI.IsChecked);

    INI.WriteBool('Etiqueta','CodBarras', cbImpCodBarras.IsChecked);
    INI.WriteBool('Etiqueta','LeitorIntegrado', cbLeitorIntegrado.IsChecked);
    INI.WriteInteger('Etiqueta','Caracteres', ColunasTextoImpressao);
    INI.WriteInteger('Etiqueta','LinhasPular', Trunc(seLinhasPular.Value) );
  finally
    INI.Free ;
  end ;
end;

procedure TEtiquetaEventosForm.PararCamera;
begin
  CameraComponent1.Active := false;
end;

procedure TEtiquetaEventosForm.ParseImage;
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      ReadResult: TReadResult;
      ScanManager: TScanManager;
    begin
      FScanInProgress := True;
      ScanManager := TScanManager.Create(TBarcodeFormat.QR_CODE, nil);
      try
        try
          ReadResult := ScanManager.Scan(FScanBitmap);
        except
          on E: Exception do
          begin
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                lblScanStatus.Text := E.Message;
              end);
            exit;
          end;
        end;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          var
            i: Integer;
          begin
            if (Length(lblScanStatus.Text) > 10) then
              lblScanStatus.Text := 'Lendo';

            lblScanStatus.Text := lblScanStatus.Text + '.';
            if (ReadResult <> nil) then
            begin
              lblScanStatus.Text := ReadResult.Text;
              i := StrToIntDef(ReadResult.Text, 0);
              if (i > 0) then
              begin
                VoltarParaLista;
                FSearchBox.Text := IntToStr(i);
              end;
            end;
          end);
      finally
        if ReadResult <> nil then
          FreeAndNil(ReadResult);

        ScanManager.Free;
        FScanInProgress := False;
      end;

    end).Start();
end;

procedure TEtiquetaEventosForm.IniciarCamera;
begin
  if not PedirPermissoes then
    Exit;

  PararCamera;
  CameraComponent1.Quality := TVideoCaptureQuality.MediumQuality;
  CameraComponent1.Kind := TCameraKind.BackCamera;
  CameraComponent1.FocusMode := TFocusMode.ContinuousAutoFocus;
  CameraComponent1.Active := True;
  lblScanStatus.Text := 'Lendo';
end;

procedure TEtiquetaEventosForm.IrParaCamera;
begin
  tabsPrincipal.SetActiveTabWithTransition(tabCamera, TTabTransition.Slide);
end;

procedure TEtiquetaEventosForm.IrParaConfig;
begin
  tabsPrincipal.SetActiveTabWithTransition(tabConfig, TTabTransition.Slide);
end;

procedure TEtiquetaEventosForm.IrParaImpressao;
begin
  tabsPrincipal.SetActiveTabWithTransition(tabImpressao, TTabTransition.Slide);
end;

procedure TEtiquetaEventosForm.LerArquivoCSV;
var
  NomeArq, Lin: string;
  SL: TStringList;
  i, Erros: Integer;
  Sep: Char;
  Campos: TSplitResult;
begin
  NomeArq := CalcularNomeArquivoLista;
  if not FileExists(NomeArq) then
  begin
    Toast('Arquivo com Lista não encontrado');
    Exit;
  end;

  Sep := ' ';
  Erros := 0;

  FDMemTable1.Close;
  FDMemTable1.CreateDataSet;
  FDMemTable1.Open;

  BindSourceDB1.DataSource.Enabled := False;
  SL := TStringList.Create;
  try
    SL.LoadFromFile(NomeArq);
    for i := 0 to SL.Count-1 do
    begin
      Lin := SL[i];
      if (Sep = ' ') then
      begin
        Sep := ',';
        Campos := Split(Sep, Lin);
        if (Length(Campos) = 0) then
        begin
          Sep := ';';
          Campos := Split(Sep, Lin);
        end;
        if (Length(Campos) = 0) then
        begin
          Sep := '|';
          Campos := Split(Sep, Lin);
        end;
      end
      else
        Campos := Split(Sep, Lin);

      if (Length(Campos) >= 3) then
      begin
        FDMemTable1.Append;
        FDMemTable1.FieldByName('fdIncricao').AsString := Campos[0];
        FDMemTable1.FieldByName('fdNome').AsString := Campos[1];
        if Length(Campos) > 2 then
          FDMemTable1.FieldByName('fdEmpresa').AsString := Campos[2];
        if Length(Campos) > 3 then
          FDMemTable1.FieldByName('fdCargo').AsString := Campos[3];

        FDMemTable1.Post;
      end
      else
        Inc(Erros);
    end;
  finally
    SL.Free;
    BindSourceDB1.DataSource.Enabled := True;
  end;
  
  Toast(IntToStr(FDMemTable1.RecordCount)+' registros incluidos');
  if (Erros > 0) then
    Toast(IntToStr(erros)+' erros encontrados');
end;

procedure TEtiquetaEventosForm.LerConfiguracao;
Var
  ArqINI: String;
  INI: TIniFile;
  i: Integer;
begin
  ArqINI := CalcularNomeArqINI;

  INI := TIniFile.Create(ArqINI);
  try
    mURLDownload.Text := INI.ReadString('Lista','URL', '');

    cbxModelo.ItemIndex := INI.ReadInteger('PosPrinter','Modelo', -1);
    cbSuportaBMP.IsChecked := INI.ReadBool('Modelo','BMP', True);
    cbxPagCodigo.ItemIndex := Ini.ReadInteger('PosPrinter','PaginaDeCodigo', -1);
    cbxImpressorasBth.ItemIndex := cbxImpressorasBth.Items.IndexOf(INI.ReadString('PosPrinter','Porta',''));
    seColunas.Value := INI.ReadInteger('PosPrinter','Colunas', 32);
    seEspLinhas.Value := INI.ReadInteger('PosPrinter','EspacoEntreLinhas', 0);
    cbControlePorta.IsChecked := INI.ReadBool('PosPrinter','ControlePorta', True);
    seBarrasLargura.Value := INI.ReadInteger('Barras','Largura', ACBrPosPrinter1.ConfigBarras.LarguraLinha);
    seBarrasAltura.Value := INI.ReadInteger('Barras','Altura', ACBrPosPrinter1.ConfigBarras.Altura);
    cbHRI.IsChecked := INI.ReadBool('Barras','HRI', ACBrPosPrinter1.ConfigBarras.MostrarCodigo);

    cbImpCodBarras.IsChecked := INI.ReadBool('Etiqueta','CodBarras', True);
    cbLeitorIntegrado.IsChecked := INI.ReadBool('Etiqueta','LeitorIntegrado', True);
    seCaracteresLinha.Value := INI.ReadInteger('Etiqueta','Caracteres', 16);
    seLinhasPular.Value := INI.ReadInteger('Etiqueta','LinhasPular', 2);
  finally
    INI.Free ;
  end;

  if (cbxImpressorasBth.ItemIndex < 0) then
    if cbxImpressorasBth.Items.Count > 0 then
      cbxImpressorasBth.ItemIndex := 0;

  if (cbxPagCodigo.ItemIndex < 0) then
    if cbxPagCodigo.Items.Count > 0 then
      cbxPagCodigo.ItemIndex := 0;

  if (cbxModelo.ItemIndex < 0) then
  begin
    for i := 0 to cbxModelo.Count-1 do
    begin
      if (cbxModelo.Items[i] = 'ppEscSunmi') then
      begin
        cbxModelo.ItemIndex := i;
        break;
      end;
    end;
  end;

  btQRCode.Visible := not cbLeitorIntegrado.IsChecked;
  if (tabsPrincipal.ActiveTab = tabLista) then
    FSearchBox.SetFocus;
end;

procedure TEtiquetaEventosForm.LimparEditsImpressao;
begin
  edtLinha1.Text := '';
  edtLinha2.Text := '';
  edtLinha3.Text := '';
  edtLinha4.Text := '';
end;

procedure TEtiquetaEventosForm.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  slFinal, slNome, slEmpresa, slCargo: TStringList;
  s: String;
  i, LinBarra, MaxLins: Integer;

  function LinhasTotal: Integer;
  begin
    Result := slNome.Count + slEmpresa.Count + slCargo.Count;
  end;

  procedure SetCount(sl: TStringList; NewCount: Integer);
  begin
    while (sl.Count > 0) and (sl.Count > NewCount) do
      sl.Delete(sl.Count-1);
  end;

begin
  if not Assigned(AItem) then
    Exit;

  FSearchBox.Text := '';
  FLinhasNome := 0;
  LinBarra := IfThen(cbImpCodBarras.IsChecked, 1, 0);
  MaxLins := 4 - LinBarra;
  LimparEditsImpressao;
  slFinal := TStringList.Create;
  slNome := TStringList.Create;
  slEmpresa := TStringList.Create;
  slCargo := TStringList.Create;
  try
    s := (AItem.View.FindDrawable('TextNome') as TListItemText).Text;
    PrepararTextoParaImpressao(s, slNome, 2);

    s := (AItem.View.FindDrawable('TextEmpresa') as TListItemText).Text;
    PrepararTextoParaImpressao(s, slEmpresa, 2);

    s := (AItem.View.FindDrawable('TextCargo') as TListItemText).Text;
    PrepararTextoParaImpressao(s, slCargo, 1);

    if (LinhasTotal > MaxLins) then
      SetCount(slCargo, min(slCargo.Count, 1));
    if (LinhasTotal > MaxLins) then
    begin
      SetCount(slNome, min(slNome.Count, 1));
      i := PosLast(' ',slNome[0]);
      if (i = 0) then
        i := Length(slNome[0]);
      s := copy(slNome[0], 1, i);
      slNome.Text := s;
    end;
    if (LinhasTotal > MaxLins) then
      SetCount(slEmpresa, min(slEmpresa.Count, 1));

    FLinhasNome := slNome.Count;
    slFinal.Clear;
    slFinal.AddStrings(slNome);
    slFinal.AddStrings(slEmpresa);
    slFinal.AddStrings(slCargo);

    if (slFinal.Count > 0) then
      edtLinha1.Text := slFinal[0];
    if (slFinal.Count > 1) then
      edtLinha2.Text := slFinal[1];
    if (slFinal.Count > 2) then
      edtLinha3.Text := slFinal[2];
    if (slFinal.Count > 3) then
      edtLinha4.Text := slFinal[3];

    if cbImpCodBarras.IsChecked then
    begin
      s := (AItem.View.FindDrawable('TextInscricao') as TListItemText).Text;
      edtLinha4.Text := s;
    end;

    if cbImpCodBarras.IsChecked then
      edtLinha4.TextAlign := TTextAlign.Center
    else
      edtLinha4.TextAlign := TTextAlign.Leading;
  finally
    slFinal.Free;
    slNome.Free;
    slEmpresa.Free;
    slCargo.Free;
  end;

  IrParaImpressao;
end;

end.

