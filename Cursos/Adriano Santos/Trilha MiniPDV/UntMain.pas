//Cores padrão
//Laraja escuro: #FFDC521F
//Amarelo: #FFFFD503

//Azul Seleciton : #7F2A96FF
//Azul Focus : #FF2A96FF

unit UntMain;

interface

uses
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.EngExt,
  Data.Bind.Grid,


  System.IOUtils,

  FMX.Clipboard,
  FMX.Ani,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.DialogService,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Forms,
  FMX.Graphics,
  FMX.Grid,
  FMX.Grid.Style,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Media,
  FMX.Objects,
  FMX.Platform,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.Types,
  FMX.VirtualKeyboard,

  Fmx.Bind.DBEngExt,
  Fmx.Bind.Editors,
  Fmx.Bind.Grid,

  MobilePermissions.Component,
  MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Signature,
  MobilePermissions.Model.Standard,

  System.Bindings.Outputs,
  System.Classes,
  System.Rtti,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TMainForm = class(TForm)
    lytMain: TLayout;
    lytTop: TLayout;
    recTopMain: TRectangle;
    lblTituloMain: TLabel;
    lytContainer: TLayout;
    recBackMesas: TRectangle;
    lytLeftContainer: TLayout;
    recBackMenu: TRectangle;
    lytMenu: TLayout;
    Layout1: TLayout;
    lytItens: TLayout;
    lytOperador: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    lblValorTotal: TLabel;
    Label9: TLabel;
    lytLateral: TLayout;
    lytLateralControle: TLayout;
    Label11: TLabel;
    lblComanda: TLabel;
    Label13: TLabel;
    lblNomeCliente: TLabel;
    Label15: TLabel;
    lblCodNomeUsuario: TLabel;
    Rectangle5: TRectangle;
    gridItens: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    lytOperadorBottom: TLayout;
    lytTopoGrid: TLayout;
    lblTitProduto: TLabel;
    lblTitValorUnitario: TLabel;
    lblTitQuantidade: TLabel;
    lblTitTotalItem: TLabel;
    ShadowEffect1: TShadowEffect;
    recGeral: TRectangle;
    edtCodBarra: TEdit;
    lblTitComandaNumero: TLabel;
    lytBotoes: TLayout;
    lytBotoesGrupo: TLayout;
    lytBtnTrocar: TLayout;
    Rectangle2: TRectangle;
    Label2: TLabel;
    speTrocar: TSpeedButton;
    lytBtnPagamento: TLayout;
    Rectangle3: TRectangle;
    Label3: TLabel;
    spePagamento: TSpeedButton;
    lytCancelar: TLayout;
    Rectangle4: TRectangle;
    Label4: TLabel;
    speCancelar: TSpeedButton;
    lytBtnAjuda: TLayout;
    Rectangle6: TRectangle;
    Label5: TLabel;
    speAjuda: TSpeedButton;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    Rectangle10: TRectangle;
    lytBtnInicio: TLayout;
    recBtnInicioRealce: TRectangle;
    pthBtnInicio: TPath;
    speBtnInicio: TSpeedButton;
    lytSair: TLayout;
    recBtnPortalRealce: TRectangle;
    Path4: TPath;
    speSair: TSpeedButton;
    lytConfig: TLayout;
    recBtnConfigRealce: TRectangle;
    Path5: TPath;
    speConfig: TSpeedButton;
    lytBtnAddItem: TLayout;
    Rectangle1: TRectangle;
    Label6: TLabel;
    Rectangle11: TRectangle;
    SpeedButton1: TSpeedButton;
    lytGeralAddItem: TLayout;
    edtCodBarrasProduto: TEdit;
    Label7: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Label8: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    edtQtde: TEdit;
    edtVlrUnitario: TEdit;
    edtVlrTotal: TEdit;
    lytSwitche: TLayout;
    chkCodBarras: TCheckBox;
    lblNomeProduto: TLabel;
    MobilePermissions1: TMobilePermissions;
    Image1: TImage;
    StyleBook1: TStyleBook;
    lytSettings: TLayout;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Layout11: TLayout;
    Path1: TPath;
    speFecharDialogo: TSpeedButton;
    Label1: TLabel;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    Layout15: TLayout;
    lytBtnFecharDialog: TLayout;
    Rectangle14: TRectangle;
    Label14: TLabel;
    speHome: TSpeedButton;
    Rectangle15: TRectangle;
    btnBtnFecharDialog: TLayout;
    Rectangle16: TRectangle;
    Label16: TLabel;
    SpeedButton2: TSpeedButton;
    Rectangle17: TRectangle;
    recBlackGround: TRectangle;
    Label17: TLabel;
    Layout10: TLayout;
    Edit1: TEdit;
    Layout16: TLayout;
    Label18: TLabel;
    Edit2: TEdit;
    Layout17: TLayout;
    Button1: TButton;
    lytTeclado: TLayout;
    edtNumSearchTeclado: TEdit;
    GridLayout1: TGridLayout;
    Layout18: TLayout;
    Button2: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button3: TButton;
    Button4: TButton;
    Rectangle18: TRectangle;
    Layout19: TLayout;
    Button5: TButton;
    Layout20: TLayout;
    Button14: TButton;
    ClearEditButton1: TClearEditButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AtivarBotaoMenu(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ClearEditButton1Click(Sender: TObject);
    procedure edtCodBarraKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure speCancelarClick(Sender: TObject);
    procedure edtCodBarrasProdutoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtQtdeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure recBlackGroundClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure speTrocarClick(Sender: TObject);
    procedure SelfIdle(Sender: TObject; var ADone: Boolean);
    procedure SpeedButton2Click(Sender: TObject);
    procedure speFecharDialogoClick(Sender: TObject);
    procedure speHomeClick(Sender: TObject);
    procedure Digitar(Sender: TObject);
  private
    { Private declarations }
    procedure HideKeyboard(AComponentToFocus: TControl = nil);
    procedure ShowKeyboard(AComponentToFocus: TControl);
    procedure AjustarGridItens;
    procedure BuscarComanda(const AComanda: Integer);
    procedure BuscarProduto(const AProduto: string; ACodBarras: Boolean = false);
    procedure ResetControls;
    procedure FocarEditCodigoDeBarras;
    procedure ResetControlsProduto;
    procedure Bipar;
    procedure HideSettings;
    procedure ShowSettings;
    procedure HideBlackGround;
    procedure ShowBlackGround;
    procedure ShowMiniKeyBoard;
    procedure HideMiniKeyBoard;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

//UUID para impressoras Bluetooth
const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

implementation

uses
  Service.Geral;

{$R *.fmx}

procedure TMainForm.HideKeyboard(AComponentToFocus: TControl = nil);
var
  FService : IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
    FService.HideVirtualKeyboard;
end;

procedure TMainForm.HideMiniKeyBoard;
begin
  TAnimator.AnimateFloat(lytTeclado, 'Opacity', 0);
  lytTeclado.Visible := False;
  HideBlackGround;
end;

procedure TMainForm.SelfIdle(Sender: TObject; var ADone: Boolean);
begin
  HideKeyboard();
end;

procedure TMainForm.ShowKeyboard(AComponentToFocus: TControl);
var
  FService : IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

  if (FService <> nil) then
  begin
    FService.ShowVirtualKeyboard(AComponentToFocus);
    if (AComponentToFocus <> nil) and (AComponentToFocus.CanFocus) then
      AComponentToFocus.SetFocus;
  end;
end;

procedure TMainForm.ShowMiniKeyBoard;
begin
  edtNumSearchTeclado.Text := EmptyStr;
  ShowBlackGround;
  lytTeclado.Visible := True;
  lytTeclado.BringToFront;
  TAnimator.AnimateFloat(lytTeclado, 'Opacity', 1);
end;

procedure TMainForm.AtivarBotaoMenu(Sender: TObject);
  procedure Realcar(AControl: TControl; AVisible: Boolean);
  var
    I : Integer;
  begin
    for I := 0 to Pred(AControl.ControlsCount) do
    begin
      if (AControl.Controls[I] is TRectangle) and not
         (UpperCase(TRectangle(AControl.Controls[I]).Name) = 'RECBACKMENU') then
        TRectangle(AControl.Controls[I]).Visible := AVisible;
      Realcar(AControl.Controls[I], AVisible);
    end;
  end;
begin
  Realcar(lytMenu, False);
  Realcar(TLayout(TSpeedButton(Sender).Parent), True);

  ShowSettings;
end;

procedure TMainForm.ResetControls;
begin
  lblValorTotal.Text        := FormatFloat('R$ ###,##0.00', 0);
  lblNomeCliente.Text       := EmptyStr;
  lblComanda.Text           := EmptyStr;
  edtCodBarra.Text          := EmptyStr;
  edtCodBarrasProduto.Text  := EmptyStr;
  edtQtde.Text              := '1';
  edtVlrUnitario.Text       := '0,0';
  edtVlrTotal.Text          := '0,00';
  FocarEditCodigoDeBarras;
end;

procedure TMainForm.speCancelarClick(Sender: TObject);
begin
  ResetControls;
  ServiceGeral.ResetToDefaults;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  ServiceGeral.AddItem(
    ServiceGeral.memPedidosID.AsInteger,
    ServiceGeral.MemProdutosID.AsInteger,
    lblComanda.Text.ToInteger,
    edtQtde.Text.ToInteger
  );
  ResetControlsProduto;
  BuscarComanda(lblComanda.Text.ToInteger);
end;

procedure TMainForm.speTrocarClick(Sender: TObject);
begin
  if ServiceGeral.memItensPedidoID.AsInteger > 0 then
  begin
    TDialogService.MessageDialog(
      Format('Confirma exclusão do item %s da comanda?', [ServiceGeral.memItensPedidoNOME.AsString]),
      TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
      TMsgDlgBtn.mbNo,
      0,
      procedure (const AModalResult: TModalResult)
      begin
        if AModalResult = mrYes then
        begin
          ServiceGeral.RemoveItem(
            ServiceGeral.memItensPedidoID_PEDIDO.AsInteger,
            ServiceGeral.memItensPedidoID.AsInteger
          );
          BuscarComanda(lblComanda.Text.ToInteger)
        end;
      end
    );
  end;
end;

procedure TMainForm.FocarEditCodigoDeBarras;
begin
  edtCodBarra.Text    := EmptyStr;
  edtCodBarra.SetFocus;
  HideKeyboard(edtCodBarra);
end;

procedure TMainForm.BuscarComanda(const AComanda: Integer);
begin
  ServiceGeral.BuscarComanda(AComanda);
  if not ServiceGeral.memPedidos.IsEmpty then
  begin
    lblValorTotal.Text  := FormatFloat('R$ ###,##0.00', ServiceGeral.memPedidos.FieldByName('TOTAL_PEDIDO').AsFloat);
    lblNomeCliente.Text := ServiceGeral.memPedidos.FieldByName('NOME_CLIENTE').AsString;
    lblComanda.Text     := Format('%3.3d' ,[AComanda]);
    AjustarGridItens;
  end
  else
    ResetControls;

  FocarEditCodigoDeBarras;
end;

procedure TMainForm.BuscarProduto(const AProduto: string; ACodBarras: Boolean = false);
begin
  ServiceGeral.BuscarProduto(AProduto, ACodBarras);
  if not ServiceGeral.MemProdutos.IsEmpty then
  begin
    edtQtde.Text        := '1';
    edtVlrUnitario.Text := FormatFloat('###,##0.00', ServiceGeral.MemProdutos.FieldByName('VLR_UNITARIO').AsFloat);
    edtVlrTotal.Text    := FormatFloat('###,##0.00', ServiceGeral.MemProdutos.FieldByName('VLR_UNITARIO').AsFloat);
    lblNomeProduto.Text := ServiceGeral.MemProdutos.FieldByName('NOME').AsString;
  end
  else
  begin
    ShowMessage('Produto não encontrado!');
    ResetControlsProduto;
  end;
end;

procedure TMainForm.edtCodBarrasProdutoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkReturn) and not (edtCodBarrasProduto.Text.Equals(EmptyStr)) then
  begin
    BuscarProduto(edtCodBarrasProduto.Text, chkCodBarras.IsChecked);
    edtCodBarrasProduto.Text := EmptyStr;
    Bipar;
  end;
end;

procedure TMainForm.edtQtdeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkReturn) and not (edtQtde.Text.Equals(EmptyStr)) then
  begin
    if (edtQtde.Text.Equals('0')) or (edtQtde.Text.ToInteger < 0) then
      edtQtde.Text := '1';
    edtVlrTotal.Text := FormatFloat('###,##0.00', StrToFloat(edtVlrUnitario.Text) * (edtQtde.Text.ToInteger));
  end;
end;

procedure TMainForm.AjustarGridItens;
begin
  gridItens.Columns[0].Width := ((lytItens.Width / 100) * 69);
  gridItens.Columns[1].Width := ((lytItens.Width / 100) * 10);
  gridItens.Columns[2].Width := ((lytItens.Width / 100) * 10);
  gridItens.Columns[3].Width := ((lytItens.Width / 100) * 10);
  lblTitProduto.Width        := ((lytItens.Width / 100) * 69);
  lblTitQuantidade.Width     := ((lytItens.Width / 100) * 10);
  lblTitValorUnitario.Width  := ((lytItens.Width / 100) * 10);
  lblTitTotalItem.Width      := ((lytItens.Width / 100) * 10);
end;

procedure TMainForm.edtCodBarraKeyDown(Sender: TObject; var Key: Word; var
    KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkReturn) and not (edtCodBarra.Text.Equals(EmptyStr)) then
  begin
    BuscarComanda(edtCodBarra.Text.ToInteger);
    edtCodBarra.Text := EmptyStr;
    Bipar;
  end;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  VKAutoShowMode   := TVKAutoShowMode.Never;
  HideKeyboard;
  if not (edtCodBarrasProduto.IsFocused) then
    FocarEditCodigoDeBarras;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnIdle := SelfIdle;

  HideBlackGround;
  HideSettings;
  HideMiniKeyBoard;

  VKAutoShowMode   := TVKAutoShowMode.Never;
  HideKeyboard;
  ResetControls;
  MobilePermissions1.Dangerous.ReadExternalStorage := True;
  MobilePermissions1.Dangerous.WriteExternalStorage := True;
  MobilePermissions1.Standard.Internet := True;

  MobilePermissions1.Apply;
  {$IFDEF RELEASE}
    lblTitComandaNumero.Visible := False;
    edtCodBarra.Visible := False;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
    MainForm.WindowState          := TWindowState.wsNormal;
    MainForm.Width                := 1450;
    MainForm.Left                 := 10;
    MainForm.Top                  := 10;

    edtCodBarra.FontColor         := $FF252525;
    edtCodBarrasProduto.FontColor := $FF252525;
    edtQtde.FontColor             := $FF252525;
    edtVlrUnitario.FontColor      := $FF252525;
    edtVlrTotal.FontColor         := $FF252525;
  {$ELSE}
    edtCodBarra.FontColor         := TAlphaColorRec.White;
    edtCodBarrasProduto.FontColor := TAlphaColorRec.White;
    edtQtde.FontColor             := TAlphaColorRec.White;
    edtVlrUnitario.FontColor      := TAlphaColorRec.White;
    edtVlrTotal.FontColor         := TAlphaColorRec.White;
  {$ENDIF}
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  VKAutoShowMode := TVKAutoShowMode.Always;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  //Procura por Comanda
  if (edtCodBarra.IsFocused) and not (edtCodBarra.Text.Equals(EmptyStr)) then
  begin
    edtCodBarra.SetFocus;
    HideKeyboard();
    if (Key = vkReturn) then
     begin
      BuscarComanda(edtCodBarra.Text.ToInteger);
      edtCodBarra.Text := EmptyStr;
     end;
  end;
  //Procura por produto
  if (edtCodBarrasProduto.IsFocused) and not (edtCodBarrasProduto.Text.Equals(EmptyStr)) then
  begin
    edtCodBarrasProduto.SetFocus;
    HideKeyboard();
    if (Key = vkReturn) and not (edtCodBarrasProduto.Text.Equals(EmptyStr)) then
    begin
      BuscarProduto(edtCodBarrasProduto.Text, chkCodBarras.IsChecked);
      edtCodBarrasProduto.Text := EmptyStr;
    end;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  VKAutoShowMode   := TVKAutoShowMode.Never;
  HideKeyboard;
end;

procedure TMainForm.ResetControlsProduto;
begin
  edtQtde.Text        := '1';
  edtVlrUnitario.Text := '0,00';
  edtVlrTotal.Text    := '0,00';
  lblNomeProduto.Text := EmptyStr;
end;

procedure TMainForm.Bipar;
var
  ResStream : TResourceStream;
  tmpFile   : string;
  AMedia    : TMediaPlayer;
begin
  exit;
  ResStream := TResourceStream.Create(HInstance, 'beep', RT_RCDATA);
  try
    AMedia    := TMediaPlayer.Create(nil);
    TmpFile := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetTempPath, 'beep.wav');
    ResStream.Position := 0;
    ResStream.SaveToFile(TmpFile);
    AMedia.FileName := TmpFile;
    AMedia.Play;
    Sleep(500);
  finally
    if FileExists(tmpFile) then
      DeleteFile(tmpFile);

    ResStream.DisposeOf;
    ResStream := nil;

    AMedia.DisposeOf;
    AMedia := nil;
  end;

end;

procedure TMainForm.Button14Click(Sender: TObject);
begin
  if not edtNumSearchTeclado.Text.Equals(EmptyStr) then
  begin
    edtCodBarrasProduto.Text := edtNumSearchTeclado.Text;
    Button1Click(Sender);
    HideMiniKeyBoard;
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if not (edtCodBarrasProduto.Text.Equals(EmptyStr)) then
  begin
    BuscarProduto(edtCodBarrasProduto.Text, chkCodBarras.IsChecked);
    edtCodBarrasProduto.Text := EmptyStr;
    Bipar;
  end;
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  ShowMiniKeyBoard;
end;

procedure TMainForm.ClearEditButton1Click(Sender: TObject);
begin
  edtNumSearchTeclado.Text := EmptyStr;
end;

procedure TMainForm.Digitar(Sender: TObject);
var
  LTexto: string;
begin
  LTexto := edtNumSearchTeclado.Text;
  if TButton(Sender).Tag = 1 then
  begin
    LTexto := Copy(LTexto, 1, Length(LTexto)-1);
    edtNumSearchTeclado.Text := LTexto;
  end
  else
  begin
    LTexto := LTexto + TButton(Sender).Text;
    edtNumSearchTeclado.Text := LTexto;
  end;
end;

procedure TMainForm.speFecharDialogoClick(Sender: TObject);
begin
  HideSettings;
end;

procedure TMainForm.ShowSettings;
begin
  ShowBlackGround;
  lytSettings.Visible := True;
  lytSettings.BringToFront;
  TAnimator.AnimateFloat(lytSettings, 'Opacity', 1);
end;

procedure TMainForm.HideSettings;
begin
  TAnimator.AnimateFloat(lytSettings, 'Opacity', 0);
  lytSettings.Visible := False;
  HideBlackGround;
end;

procedure TMainForm.ShowBlackGround;
begin
  recBlackGround.Visible := True;
  recBlackGround.Align := TAlignLayout.Contents;
  recBlackGround.BringToFront;
  TAnimator.AnimateFloat(recBlackGround, 'Opacity', 0.6);
end;

procedure TMainForm.HideBlackGround;
begin
  TAnimator.AnimateFloat(recBlackGround, 'Opacity', 0);
  recBlackGround.Visible := False;
end;

procedure TMainForm.recBlackGroundClick(Sender: TObject);
begin
  HideSettings;
  HideBlackGround;
  HideMiniKeyBoard;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  HideSettings;
end;

procedure TMainForm.speHomeClick(Sender: TObject);
begin
  HideSettings;
end;

end.



