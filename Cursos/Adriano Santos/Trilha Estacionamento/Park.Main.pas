unit Park.Main;

interface

uses
  FMX.VirtualKeyboard,

  FMX.DialogService,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.Platform,
  System.Rtti,
  FMX.Grid.Style,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Grid,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  FMX.Bind.Grid,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  Data.Bind.Components,
  Data.Bind.Grid,
  Data.Bind.DBScope,
  FMX.StdCtrls,
  FMX.ComboEdit,
  FMX.Edit,
  FMX.ListBox,
  System.Permissions
  {$IFDEF ANDROID}
  ,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.Helpers,
  Posix.Unistd
  {$ENDIF}
  ;

type
  TViewMain = class(TForm)
    LytMain: TLayout;
    LytNavegacao: TLayout;
    LytToolTop: TLayout;
    LytBottom: TLayout;
    LytGeralLogo: TLayout;
    recBackground: TRectangle;
    gridCarros: TStringGrid;
    LytLogo: TLayout;
    recLogo: TRectangle;
    recBackLogo: TRectangle;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    tmHora: TTimer;
    LblHora: TLabel;
    Label2: TLabel;
    lytSair: TLayout;
    pthSair: TPath;
    speSair: TSpeedButton;
    edtPlaca: TEdit;
    lytBtnPagamento: TLayout;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Rectangle8: TRectangle;
    spePagamento: TSpeedButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbxMarca: TComboBox;
    cbxModelo: TComboBox;
    LytEdicaoVeiculo: TLayout;
    Rectangle1: TRectangle;
    recBackDetalhe: TRectangle;
    Rectangle2: TRectangle;
    Label6: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout4: TLayout;
    Rectangle6: TRectangle;
    Label8: TLabel;
    Rectangle7: TRectangle;
    SpeedButton2: TSpeedButton;
    Layout5: TLayout;
    Rectangle9: TRectangle;
    Label9: TLabel;
    Rectangle10: TRectangle;
    SpeedButton3: TSpeedButton;
    Layout3: TLayout;
    Label7: TLabel;
    lblTotalGeral: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    gridTempo: TGridLayout;
    lytTempo: TLayout;
    Rectangle4: TRectangle;
    Label10: TLabel;
    lblTempoTotal: TLabel;
    LytTotal: TLayout;
    Rectangle5: TRectangle;
    Label11: TLabel;
    lblTotal: TLabel;
    lblDescricaoFechamento: TLabel;
    Layout8: TLayout;
    cbxMarcaEdicao: TComboBox;
    Label12: TLabel;
    cbxModeloEdicao: TComboBox;
    Label13: TLabel;
    edtPlacaEdicao: TEdit;
    Label14: TLabel;
    procedure tmHoraTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spePagamentoClick(Sender: TObject);
    procedure gridCarrosCellClick(const Column: TColumn; const Row: Integer);
    procedure recBackDetalheTap(Sender: TObject; const Point: TPointF);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure PedirPermissoes;
    procedure LimparControles;
    procedure MostrarBack;
    procedure OcultarBack;
    procedure MostrarPopupEditarVeiculo;
    procedure OcultarPopupEditarVeiculo;
    procedure HideKeyboard(AComponentToFocus: TControl = nil);
    procedure ShowKeyboard(AComponentToFocus: TControl);
  public
    { Public declarations }

  end;

var
  ViewMain: TViewMain;

implementation

{$R *.fmx}


uses Service.Dados;

procedure TViewMain.FormActivate(Sender: TObject);
begin
  HideKeyboard;
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
  HideKeyboard;
  ServiceDados.AbrirCarros;
  PedirPermissoes;
  LimparControles;
  OcultarBack;
  OcultarPopupEditarVeiculo;
end;

procedure TViewMain.FormShow(Sender: TObject);
begin
  HideKeyboard;
end;

procedure TViewMain.gridCarrosCellClick(const Column: TColumn;
  const Row: Integer);
begin
  //ShowMessage(Format('Placa: %s', [ServiceDados.QryCarrosPLACA.AsString]));
  ServiceDados.QryCarros.Edit;
  MostrarPopupEditarVeiculo;
end;

procedure TViewMain.HideKeyboard(AComponentToFocus: TControl);
var
  FService: IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
    FService.HideVirtualKeyboard;
end;

procedure TViewMain.LimparControles;
begin
  edtPlaca.Text := EmptyStr;
  cbxMarca.ItemIndex := -1;
  cbxModelo.ItemIndex := -1;
end;

procedure TViewMain.MostrarBack;
begin
  recBackDetalhe.Align := TAlignLayout.Contents;
  recBackDetalhe.Visible := True;
  recBackDetalhe.BringToFront;
end;

procedure TViewMain.MostrarPopupEditarVeiculo;
begin
  MostrarBack;

  lblDescricaoFechamento.Text :=
    Format('DIÁRIA/PERÍODO: das %s até %s - VEÍCULO PLACA %s',
      [FormatDateTime('DD/MM/YYYY hh:mm', ServiceDados.QryCarrosDATA_ENTRADA.AsDateTime),
      FormatDateTime('DD/MM/YYYY hh:mm', Now),
       ServiceDados.QryCarrosPLACA.AsString
      ]);
  lblTempoTotal.Text := '00:13';
  lblTotal.Text := FormatFloat('R$ ###,###.#0', 27.49);
  lblTotalGeral.Text := FormatFloat('R$ ###,###.#0', 30.45);
  edtPlacaEdicao.Text := ServiceDados.QryCarrosPLACA.AsString;
  cbxMarcaEdicao.ItemIndex := cbxMarcaEdicao.Items.IndexOf(ServiceDados.QryCarrosMARCA.AsString);
  cbxModeloEdicao.ItemIndex := cbxModeloEdicao.Items.IndexOf(ServiceDados.QryCarrosMODELO.AsString);


  LytEdicaoVeiculo.Align := TAlignLayout.Center;
  LytEdicaoVeiculo.Visible := True;
  LytEdicaoVeiculo.BringToFront;
end;

procedure TViewMain.OcultarBack;
begin
  recBackDetalhe.Visible := False;
end;

procedure TViewMain.OcultarPopupEditarVeiculo;
begin
  LytEdicaoVeiculo.Visible := False;
  OcultarBack;
end;

procedure TViewMain.PedirPermissoes;
var
  Ok: Boolean;
begin
  Ok := True;
  {$IfDef ANDROID}
  PermissionsService.RequestPermissions( [
                       JStringToString(TJManifest_permission.JavaClass.INTERNET),
                       JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE),
                       JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE)],
      {$IfDef DELPHI28_UP}
      procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
      {$Else}
      procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
      {$EndIf}
      var
        GR: TPermissionStatus;
      begin
        for GR in AGrantResults do
          if (GR <> TPermissionStatus.Granted) then
          begin
            Ok := False;
            Break;
          end;
      end );

  if not OK then
    raise EPermissionException.Create( 'Sem permissões para acesso a Internet');
  {$EndIf}
end;

procedure TViewMain.recBackDetalheTap(Sender: TObject; const Point: TPointF);
begin
  OcultarBack;
  OcultarPopupEditarVeiculo;
end;

procedure TViewMain.ShowKeyboard(AComponentToFocus: TControl);
var
  FService: IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

  if (FService <> nil) then
  begin
    FService.ShowVirtualKeyboard(AComponentToFocus);
    if (AComponentToFocus <> nil) and (AComponentToFocus.CanFocus) then
      AComponentToFocus.SetFocus;
  end;
end;

procedure TViewMain.SpeedButton2Click(Sender: TObject);
begin
  ServiceDados.QryCarros.Post;
  OcultarPopupEditarVeiculo;
end;

procedure TViewMain.spePagamentoClick(Sender: TObject);
begin
  TDialogService.MessageDialog(
    'Confirma entrada de veículo?',
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbYes,
    0,
    procedure (const AModalResult: TModalResult)
    begin
      if AModalResult = mrYes then
      begin
        //Adiciona no banco de dados
        ServiceDados.Entrada(
          edtPlaca.Text,
          cbxMarca.Items[cbxMarca.ItemIndex],
          cbxModelo.Items[cbxMarca.ItemIndex]
        );
        LimparControles;
      end;
    end
  );
end;

procedure TViewMain.tmHoraTimer(Sender: TObject);
begin
  LblHora.Text := FormatDateTime('HH:MM:SS', Now);
end;

end.
