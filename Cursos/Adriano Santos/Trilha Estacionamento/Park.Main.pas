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
  System.Permissions,
  System.DateUtils, FMX.DateTimeCtrls
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
    speGravar: TSpeedButton;
    Layout5: TLayout;
    Rectangle9: TRectangle;
    Label9: TLabel;
    Rectangle10: TRectangle;
    speSaida: TSpeedButton;
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
    cbxModeloEdicao: TComboBox;
    Label12: TLabel;
    cbxMarcaEdicao: TComboBox;
    Label13: TLabel;
    edtPlacaEdicao: TEdit;
    Label14: TLabel;
    Layout9: TLayout;
    Label15: TLabel;
    Rectangle11: TRectangle;
    speCor: TSpeedButton;
    lytCor: TLayout;
    Rectangle12: TRectangle;
    Label16: TLabel;
    cbxCor: TComboBox;
    Layout10: TLayout;
    Layout11: TLayout;
    Rectangle13: TRectangle;
    Label17: TLabel;
    Rectangle14: TRectangle;
    SpeedButton1: TSpeedButton;
    Layout12: TLayout;
    Rectangle15: TRectangle;
    Label18: TLabel;
    Rectangle16: TRectangle;
    SpeedButton4: TSpeedButton;
    Rectangle17: TRectangle;
    Layout13: TLayout;
    Rectangle18: TRectangle;
    Label19: TLabel;
    speCorEdicao: TSpeedButton;
    recBackPopAleracao: TRectangle;
    Layout14: TLayout;
    Label20: TLabel;
    Layout15: TLayout;
    pthFiltro: TPath;
    speFiltro: TSpeedButton;
    LytFiltro: TLayout;
    Rectangle19: TRectangle;
    Label21: TLabel;
    Rectangle20: TRectangle;
    Layout17: TLayout;
    LytBtnCancelaTelaFiltro: TLayout;
    Rectangle21: TRectangle;
    Label22: TLabel;
    Rectangle22: TRectangle;
    speCancelaTelaFiltro: TSpeedButton;
    LytBtnFiltrar: TLayout;
    Rectangle23: TRectangle;
    Label23: TLabel;
    Rectangle24: TRectangle;
    speFiltrar: TSpeedButton;
    Layout20: TLayout;
    Layout21: TLayout;
    Layout22: TLayout;
    Label24: TLabel;
    Label25: TLabel;
    Layout23: TLayout;
    Label26: TLabel;
    swtSaida: TSwitch;
    Layout24: TLayout;
    Label27: TLabel;
    swtBaixados: TSwitch;
    dtFiltroIni: TDateEdit;
    dtFiltroFim: TDateEdit;
    lblAlertaFiltro: TLabel;
    LytBtnLimparFiltro: TLayout;
    Rectangle25: TRectangle;
    Label28: TLabel;
    Rectangle26: TRectangle;
    speLimparFiltro: TSpeedButton;
    procedure tmHoraTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spePagamentoClick(Sender: TObject);
    procedure gridCarrosCellClick(const Column: TColumn; const Row: Integer);
    procedure recBackDetalheTap(Sender: TObject; const Point: TPointF);
    procedure speGravarClick(Sender: TObject);
    procedure speCorClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure speCorEdicaoClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure speSaidaClick(Sender: TObject);
    procedure recBackDetalheClick(Sender: TObject);
    procedure speCancelaTelaFiltroClick(Sender: TObject);
    procedure speFiltroClick(Sender: TObject);
    procedure swtSaidaSwitch(Sender: TObject);
    procedure speFiltrarClick(Sender: TObject);
    procedure speLimparFiltroClick(Sender: TObject);
  private
    { Private declarations }
    FCor : string;
    function CalcularValorTotal(ATempo: string): Double;
    function CalcularTempo(ADataIni: TDateTime; AHoraIni: TTime): string;

    procedure PedirPermissoes;
    procedure LimparControles;
    procedure MostrarBack;
    procedure OcultarBack;
    procedure MostrarPopupEditarVeiculo;
    procedure OcultarPopupEditarVeiculo;
    procedure MostrarCor;
    procedure OcultarCor;
    procedure HideKeyboard(AComponentToFocus: TControl = nil);
    procedure ShowKeyboard(AComponentToFocus: TControl);
    procedure MostrarFiltro;
    procedure OcultarFiltro;
    procedure MostrarAlertaFiltro;
    procedure OcultarAlertaFiltro;
  public
    { Public declarations }
  end;

const
  C_Valor_Meia_Hora = 7.50;
  C_Valor_Hora = 15.00;

var
  ViewMain: TViewMain;

implementation

{$R *.fmx}

uses
  Service.Dados;

function TViewMain.CalcularTempo(ADataIni: TDateTime; AHoraIni: TTime): string;
  function Calcular(ADTIni: TDateTime; AHrIni: TTime;
                    ADtFim: TDateTime; AHrFim: TTime): string;
  var
    Dias : Integer;
    Total, Horas : Real;
    LResult : string;
    H, M, S, SS : Word;

    function CalcularDiferencaHoras(DataF, DataI : TDate; HoraF, HoraI : TTime) : TDateTime;
    var
      DataHoraF, DataHoraI : TDateTime;
    begin
      DataHoraF := DataF + HoraF;
      DataHorai := DataI + HoraI;
      if DataHoraI > DataHoraF then
        Result := DataHoraI - DataHoraF
      else
        Result := DataHoraF - DataHoraI;
    end;
  begin
    Total := CalcularDiferencaHoras(ADtFim, ADtIni, AHrFim, AHrIni);
    Dias  := Trunc(Total);
    Horas := Total - Trunc(Total);
    Decodetime(Horas, H, M, S, SS);
    H := H + 24 * Trunc(Dias);

    LResult := FormatFloat('#00', H) + ':' + FormatFloat('00', M);

    Result := LResult;
  end;
begin
  Result := Calcular(ADataIni, AHoraIni, Date, Time);
end;

function TViewMain.CalcularValorTotal(ATempo: string): Double;
var
  LHoras: Integer;
  LMinutos: Integer;
  LValor: Double;
begin
  LHoras := StrToInt(Copy(ATempo, 1, 2));
  LMinutos := StrToInt(Copy(ATempo, 4, 2));
  LValor := 0.0;
  case LMinutos of
    0..30  : LValor := C_Valor_Meia_Hora;
    31..59 : LValor := C_Valor_Hora;
  end;
  LValor := LValor + (LHoras * C_Valor_Hora);
  Result := LValor;
end;

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
  OcultarCor;
  OcultarFiltro;
  OcultarAlertaFiltro;

  FCor := EmptyStr;
  {$IFDEF ANDROID}
    edtPlaca.FilterChar := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    edtPlacaEdicao.FilterChar := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  {$ELSE}
    edtPlaca.FilterChar := EmptyStr;
    edtPlacaEdicao.FilterChar := EmptyStr;
  {$ENDIF}
end;

procedure TViewMain.FormShow(Sender: TObject);
begin
  HideKeyboard;
end;

procedure TViewMain.gridCarrosCellClick(const Column: TColumn;
  const Row: Integer);
begin
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
  FCor := EmptyStr;
end;

procedure TViewMain.MostrarAlertaFiltro;
begin
  lblAlertaFiltro.Visible := True;
end;

procedure TViewMain.MostrarBack;
begin
  recBackDetalhe.Align := TAlignLayout.Contents;
  recBackDetalhe.Visible := True;
  recBackDetalhe.BringToFront;
end;

procedure TViewMain.MostrarCor;
begin
  if not recBackDetalhe.Visible then
    MostrarBack;
  lytCor.Align := TAlignLayout.Center;
  lytCor.BringToFront;
  cbxCor.ItemIndex := -1;
  lytCor.Visible := True;
end;

procedure TViewMain.MostrarFiltro;
begin
  MostrarBack;
  dtFiltroIni.Date := Now;
  dtFiltroFim.Date := Now;
  LytFiltro.Align := TAlignLayout.Center;
  LytFiltro.BringToFront;
  LytFiltro.Visible := True;
end;

procedure TViewMain.MostrarPopupEditarVeiculo;
  function GetItemIndex(ATexto: string; ACombo: TComboBox): Integer;
  begin
    for var I: Integer := 0 to Pred(ACombo.Items.Count) do
    begin
      if ACombo.Items[I].Equals(ATexto) then
      begin
        Result := I;
        exit;
      end;
    end;
  end;
begin
  MostrarBack;

  lblDescricaoFechamento.Text :=
    Format('DIÁRIA/PERÍODO: de %s das %s - %s as %s - VEÍCULO PLACA %s',
      [FormatDateTime('DD/MM/YYYY', ServiceDados.QryCarrosDATA_ENTRADA.AsDateTime),
       FormatDateTime('hh:mm', ServiceDados.QryCarrosHORA_ENTRADA.AsDateTime),
       FormatDateTime('DD/MM/YYYY', Now),
       FormatDateTime('HH:MM', Now),
       ServiceDados.QryCarrosPLACA.AsString
      ]);

  lblTempoTotal.Text :=
    CalcularTempo(ServiceDados.QryCarrosDATA_ENTRADA.AsDateTime,
                  ServiceDados.QryCarrosHORA_ENTRADA.AsDateTime);



  lblTotal.Text := FormatFloat('R$ ###,###.#0', CalcularValorTotal(lblTempoTotal.Text));
  lblTotalGeral.Text := FormatFloat('R$ ###,###.#0', CalcularValorTotal(lblTempoTotal.Text));

  edtPlacaEdicao.Text := ServiceDados.QryCarrosPLACA.AsString;
  cbxMarcaEdicao.ItemIndex := GetItemIndex(ServiceDados.QryCarrosMARCA.AsString, cbxMarcaEdicao);
  cbxModeloEdicao.ItemIndex := GetItemIndex(ServiceDados.QryCarrosMODELO.AsString, cbxModeloEdicao);

  LytEdicaoVeiculo.Align := TAlignLayout.Center;
  LytEdicaoVeiculo.Visible := True;
  LytEdicaoVeiculo.BringToFront;
end;

procedure TViewMain.OcultarAlertaFiltro;
begin
  lblAlertaFiltro.Visible := False;
end;

procedure TViewMain.OcultarBack;
begin
  recBackDetalhe.Visible := False;
end;

procedure TViewMain.OcultarCor;
begin
  lytCor.Visible := False;
  if not LytEdicaoVeiculo.Visible then
    OcultarBack;
  if recBackPopAleracao.Visible then
    recBackPopAleracao.Visible := False;
end;

procedure TViewMain.OcultarFiltro;
begin
  LytFiltro.Visible := False;
  OcultarBack;
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

procedure TViewMain.recBackDetalheClick(Sender: TObject);
begin
  OcultarBack;
  OcultarPopupEditarVeiculo;
  OcultarCor;
  OcultarFiltro;
end;

procedure TViewMain.recBackDetalheTap(Sender: TObject; const Point: TPointF);
begin
  OcultarBack;
  OcultarPopupEditarVeiculo;
  OcultarCor;
  OcultarFiltro;
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

procedure TViewMain.speCorClick(Sender: TObject);
begin
  if not (edtPlaca.Text.Equals(EmptyStr)) and
     not (cbxMarca.ItemIndex = -1)        and
     not (cbxModelo.ItemIndex = -1)       then
  begin
    MostrarCor;
  end;
end;

procedure TViewMain.SpeedButton1Click(Sender: TObject);
begin
  OcultarCor;
end;

procedure TViewMain.speCancelaTelaFiltroClick(Sender: TObject);
begin
  OcultarFiltro;
end;

procedure TViewMain.speFiltrarClick(Sender: TObject);
begin
  if dtFiltroFim.Date < dtFiltroIni.Date then
  begin
    ShowMessage('Data Final não pode ser inferior a Data Inicial.');
    exit;
  end;

  if swtSaida.IsChecked
  then ServiceDados.FiltrarPorSaida(dtFiltroIni.Date, dtFiltroFim.Date)
  else ServiceDados.FiltrarPorEntrada(dtFiltroIni.Date, dtFiltroFim.Date, swtBaixados.IsChecked);

  if not ServiceDados.QryCarros.IsEmpty then
  begin
    OcultarFiltro;
    MostrarAlertaFiltro;
  end
  else
  begin
    ShowMessage('Nada encontrado com esses parâmetros de filtro.');
  end;
end;

procedure TViewMain.speFiltroClick(Sender: TObject);
begin
  MostrarFiltro;
end;

procedure TViewMain.speGravarClick(Sender: TObject);
begin
  if cbxMarcaEdicao.ItemIndex = -1  then
  begin
    ShowMessage('Preencha a Marca do Veículo.');
    exit;
  end;

  if cbxModeloEdicao.ItemIndex = -1  then
  begin
    ShowMessage('Preencha o Modelo do Veículo.');
    exit;
  end;

  ServiceDados.QryCarrosPLACA.AsString  := edtPlacaEdicao.Text;
  ServiceDados.QryCarrosMARCA.AsString  := cbxMarcaEdicao.Items[cbxMarcaEdicao.ItemIndex];
  ServiceDados.QryCarrosMODELO.AsString := cbxModeloEdicao.Items[cbxModeloEdicao.ItemIndex];
  if cbxCor.ItemIndex > -1 then
    ServiceDados.QryCarrosCOR.AsString    := cbxCor.Items[cbxCor.ItemIndex];
  ServiceDados.QryCarros.Post;
  OcultarPopupEditarVeiculo;
end;

procedure TViewMain.speLimparFiltroClick(Sender: TObject);
begin
  if lblAlertaFiltro.Visible then
  begin
    ServiceDados.LimparFiltro;
    OcultarFiltro;
    OcultarAlertaFiltro;
  end;
end;

procedure TViewMain.SpeedButton4Click(Sender: TObject);
begin
  FCor := cbxCor.Items[cbxCor.ItemIndex];
  OcultarCor;
end;

procedure TViewMain.speCorEdicaoClick(Sender: TObject);
begin
  MostrarCor;
  recBackPopAleracao.Visible := True;
  for var I: Integer := 0 to Pred(cbxCor.Items.Count) do
  begin
    if cbxCor.Items[I].Equals(ServiceDados.QryCarrosCOR.AsString) then
    begin
      cbxCor.ItemIndex := I;
      break;
    end;
  end;
end;

procedure TViewMain.spePagamentoClick(Sender: TObject);
begin
  if cbxMarca.ItemIndex = -1  then
  begin
    ShowMessage('Preencha a Marca do Veículo.');
    exit;
  end;

  if cbxModelo.ItemIndex = -1  then
  begin
    ShowMessage('Preencha o Modelo do Veículo.');
    exit;
  end;

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
          cbxModelo.Items[cbxModelo.ItemIndex],
          FCor
        );
        LimparControles;
      end;
    end
  );
end;

procedure TViewMain.speSaidaClick(Sender: TObject);
begin
  TDialogService
    .MessageDialog(
      'Confirma Saída de Veículo?',
      TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
      TMsgDlgBtn.mbNo,
      0,
      procedure (const AModalResult: TModalResult)
      var
        LValorTotal : Double;
      begin
        if AModalResult = mrYes then
        begin
          LValorTotal := Self.CalcularValorTotal(lblTempoTotal.Text);
          ServiceDados.Saida(ServiceDados.QryCarrosPLACA.AsString, LValorTotal);
          OcultarPopupEditarVeiculo;
        end;
      end
    );
end;

procedure TViewMain.swtSaidaSwitch(Sender: TObject);
begin
  if swtSaida.IsChecked then
    swtBaixados.IsChecked := True;
end;

procedure TViewMain.tmHoraTimer(Sender: TObject);
begin
  LblHora.Text := FormatDateTime('HH:MM:SS', Now);
end;


end.
