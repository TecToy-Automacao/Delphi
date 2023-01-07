unit UntPrincipal;

interface

uses
  Loading,
  RESTRequest4D,

  FMX.Platform,

  Comanda.Config.Perfil,

  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.EngExt,
  Data.DB,

  DataSet.Serialize,
  DataSet.Serialize.Config,

  FMX.ActnList,
  FMX.Ani,
  FMX.Bind.DBEngExt,
  FMX.Bind.Editors,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Controls3D,
  FMX.DialogService,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Forms,
  FMX.Gestures,
  FMX.Graphics,
  FMX.Layers3D,
  FMX.Layouts,
  FMX.ListBox,
  FMX.ListView,
  FMX.ListView.Adapters.Base,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.Media,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.Objects,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,

  REST.Json,

  System.Actions,
  System.Bindings.Outputs,
  System.Classes,
  System.IOUtils,
  System.Json,
  System.Math.Vectors,
  System.Rtti,
  System.SysUtils,
  System.Types,
  System.UIConsts,
  System.UITypes,
  System.Variants,
  System.Permissions
<<<<<<< HEAD
  {$IFDEF ANDROID}
=======

//  MobilePermissions.Model.Signature,
//  MobilePermissions.Model.Dangerous,
//  MobilePermissions.Model.Standard,
//  MobilePermissions.Component

{$IFDEF ANDROID}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
    ,
  ZXing.BarcodeFormat,
  ZXing.ReadResult,
  ZXing.ScanManager,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.Helpers,
  Posix.Unistd
<<<<<<< HEAD

  {$ENDIF}
  ;
=======
//  MobilePermissions.Model.Signature,
//  MobilePermissions.Model.Dangerous,
//  MobilePermissions.Model.Standard,
//  MobilePermissions.Component

{$ENDIF}
    ;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9

type
  TProcedureExcept = reference to procedure(const AExcpetion: string);

  TNavegacao = (tnLogin, tnMesas, tnPedidos, tnItens, tnProdutos);

  TfrmPrincipal = class(TForm)
    tbcPrincipal: TTabControl;
    tbiLogin: TTabItem;
    tbiPrincipal: TTabItem;
    lytIconEmpresa: TLayout;
    imgIconEmpresa: TImage;
    lytGeralConfig: TLayout;
    edtLogin: TEdit;
    recFundoOpaco: TRectangle;
    actAcoes: TActionList;
    actMudarAba: TChangeTabAction;
    tbiProdutos: TTabItem;
    lytAddProduto: TLayout;
    recBackDialogoQtde: TRectangle;
    lblTitQtde: TLabel;
    edtQtde: TEdit;
    lytBoxQtde: TLayout;
    btnMenos: TButton;
    btnMais: TButton;
    gstManager: TGestureManager;
    recBtnLogin: TRectangle;
    lblLogin: TLabel;
    tbcOperacao: TTabControl;
    tbiPedidos: TTabItem;
    tbiItens: TTabItem;
    lsvPedidos: TListView;
    tbiMesas: TTabItem;
    lytGeral: TLayout;
    lytToolBar: TLayout;
    lytGeralMnuMesas: TLayout;
    recGeralMnuMesas: TRectangle;
    grdMnuMesas: TGridLayout;
    lytBtnBackToLogin: TLayout;
    btnLogoff: TSpeedButton;
    lblMnuMesas: TLabel;
    lytPrincipal: TLayout;
    lytNavegador: TLayout;
    recNavegador: TRectangle;
    lytBtnMesas: TLayout;
    speBtnMesas: TSpeedButton;
    lytBtnPedidos: TLayout;
    lblMnuPedidos: TLabel;
    spePedidos: TSpeedButton;
    recBasePedidos: TRectangle;
    lytBasePedidos: TLayout;
    lytAcessBasePedidos: TLayout;
    lytGeralBasePedidos: TLayout;
    lytAccessPedido: TLayout;
    speAccessPedido: TSpeedButton;
    lblValor: TLabel;
    lblMesa: TLabel;
    vertPedidos: TVertScrollBox;
    lblTitMesasOcupadas: TLabel;
    lblTitMesasLivres: TLabel;
    lytMesasOcupadas: TLayout;
    lytMesasLivres: TLayout;
    recMesa: TRectangle;
    lblNumMesa: TLabel;
    speNumMesa: TSpeedButton;
    lytTitMesaOcupada: TLayout;
    lblLotacao: TLabel;
    lstMesasOcupadas: TListBox;
    lsitemBaseMesa: TListBoxItem;
    lstMesasLivres: TListBox;
    lytTitMesasLivres: TLayout;
    speLogin: TSpeedButton;
    lytLegenda: TLayout;
    recLegOcupadas: TRectangle;
    recLegLivres: TRectangle;
    lblMesasLivres: TLabel;
    lblMesasOcupadas: TLabel;
    Line1: TLine;
    lytApoioLegenda: TLayout;
    lytRefresh: TLayout;
    speRefresh: TSpeedButton;
    lytGeralPedidos: TLayout;
    lytBtnLogin: TLayout;
    lytToolPedidos: TLayout;
    lblTitToolsPedidos: TLabel;
    lytGeralItens: TLayout;
    vertItensPedido: TVertScrollBox;
    lytToolItensPedido: TLayout;
    lblToolsItensPedido: TLabel;
    lytBtnAddItem: TLayout;
    speAddItem: TSpeedButton;
    recBaseItens: TRectangle;
    lytBaseItens: TLayout;
    lytAccessoryItem: TLayout;
    lytDeleteItem: TLayout;
    speDeleteItem: TSpeedButton;
    lytInternoBaseItens: TLayout;
    lblProduto: TLabel;
    lblQtdeItem: TLabel;
    lblDescricao: TLabel;
    lytQtdeValor: TLayout;
    lblValorItem: TLabel;
    lytBtnDialogoQtde: TLayout;
    recBtnDialogoQtde: TRectangle;
    lblBtnDialogoQtde: TLabel;
    speBtnDialogoQtde: TSpeedButton;
    lytToolProdutos: TLayout;
    lytBtnProdutos: TLayout;
    recBackMenuProdutos: TRectangle;
    grdMenuProdutos: TGridLayout;
    lytMenuProdutos: TLayout;
    lblMenuProdutos: TLabel;
    speProdutos: TSpeedButton;
    lytNavegadorProdutos: TLayout;
    recNavegadorProdutos: TRectangle;
    lytBtnBackProToItens: TLayout;
    speBtnBackProToItens: TSpeedButton;
    lytGeralProdutos: TLayout;
    vertProdutos: TVertScrollBox;
    recBaseProdutos: TRectangle;
    lytGeralProdutoBase: TLayout;
    lytGeralAccessProduto: TLayout;
    lytAccessProduto: TLayout;
    speAccessProduto: TSpeedButton;
    lytLabelsProdutos: TLayout;
    lblNomeProduto: TLabel;
    lblDescProduto: TLabel;
    lytBottomProduto: TLayout;
    lblValorUnitario: TLabel;
    lytIconProd: TLayout;
    imgIconProd: TImage;
    lytBtnFecharPedido: TLayout;
    recBtnFecharPedido: TRectangle;
    lblTitBtnFecharPedido: TLabel;
    speFecharPedido: TSpeedButton;
    StyleBook1: TStyleBook;
    edtSenha: TEdit;
    lytGeralFundoApp: TLayout;
    recImgFundo: TRectangle;
    gbfEfeito: TGaussianBlurEffect;
    recTopImagem: TRectangle;
    lytComanda: TLayout;
    recBackComandaDlg: TRectangle;
    lytBottomBtnConfComanda: TLayout;
    lytBtnConfComanda: TLayout;
    recBtnConfComanda: TRectangle;
    lblBtnConfComanda: TLabel;
    speBtnConfComanda: TSpeedButton;
    lytCamera: TLayout;
    lblCodComanda: TLabel;
    camComanda: TCameraComponent;
    imgCamera: TImage;
    edtNumComanda: TEdit;
    lytBtnCancComanda: TLayout;
    recBtnCancComanda: TRectangle;
    lblBtnCancComanda: TLabel;
    speBtnCancComanda: TSpeedButton;
    pgStatusScan: TProgressBar;
    lblComandaItem: TLabel;
    recMaskFecharPedido: TRectangle;
    recMaskLegenda: TRectangle;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure recFundoOpacoClick(Sender: TObject);
    procedure btnMaisClick(Sender: TObject);
    procedure btnMenosClick(Sender: TObject);
    procedure camComandaSampleBufferReady(Sender: TObject; const ATime:
      TMediaTime);
    procedure edtNumComandaTyping(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift:
      TShiftState);
    procedure speAccessPedidoClick(Sender: TObject);
    procedure speAddItemClick(Sender: TObject);
    procedure speBtnDialogoQtdeClick(Sender: TObject);
    procedure speLoginClick(Sender: TObject);
    procedure spePedidosClick(Sender: TObject);
    procedure speRefreshClick(Sender: TObject);
    // Navegacao Geral
    procedure ExecutarNavegacao(Sender: TObject);
    procedure speBtnCancComandaClick(Sender: TObject);
    procedure speBtnConfComandaClick(Sender: TObject);
    procedure speFecharPedidoClick(Sender: TObject);
    procedure speSairConfigClick(Sender: TObject);
<<<<<<< HEAD
=======
    procedure tbcPrincipalChange(Sender: TObject);
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  private
    { Private declarations }
    FComanda:        Integer;
    fScanInProgress: Boolean;
    fFrameTake:      Integer;
    fScanBitmap:     TBitmap;

    procedure ParseImage();

    procedure CustomThread(
      AOnStart,           // Procedimento de entrada      = nil
      AOnProcess,         // Procedimento principal       = nil
      AOnComplete: TProc; // Procedimento de finalização  = nil
      AOnError: TProcedureExcept = nil;
      const ADoCompleteWithError: Boolean = True
      );

    procedure LimparMesas(AListBox: TListBox);
    procedure MostrarFundoEscuro;
    procedure OcultarFundoEscuro;
    procedure MostrarQtde;
    procedure OcultarQtde;

    procedure MostrarScan;
    procedure OcultarScan;

    procedure MudarAba(ATabItem: TTabItem; Sender: TObject);

    procedure AplicarCores;
    procedure Inicializar;

    procedure Config;

    procedure Navegar(ADestino: TNavegacao);
    procedure LimparLista(Sender: TObject; AVertScroll: TVertScrollBox; ARectBase: string);

    // Métodos auxiliares para criação de frames de Pedidos, Itens e Produtos
    procedure SetFrameClone(ARectBase: TRectangle; var AClone: TRectangle;
      AScroll: TVertScrollBox; var APosition: Single); overload;
    procedure SetFrameClone(ARectBase: TRectangle; var AClone: TRectangle; AScroll: TVertScrollBox;
      var APosition: Single; AFim: Boolean); overload;

    // Inserção de eventos nos controles
    procedure InsertOnClickEvent(AObject: TControl; AEvent: TNotifyEvent; AllControls: Boolean = True); overload;
    procedure InsertGestureLongTapEvent(AObject: TRectangle; AEvent: TGestureEvent);

    procedure Login(AUsuario, ASenha: string; Sender: TObject);
    procedure Logoff(Sender: TObject);
<<<<<<< HEAD
    {$IFDEF ANDROID}
    procedure Bipar;
    {$ENDIF}
=======
{$IFDEF ANDROID}
    procedure Bipar;
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
    function AppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    function ExtrairTexto(AValue: string; ACaractere: Char): string;
    procedure PedirPermissoes;
  public
    { Public declarations }
    procedure CarregarMesas;
    procedure OnClickMesa(Sender: TObject);
    procedure AbrirMesa(Sender: TObject);

    procedure CarregarProdutos(Sender: TObject);
    procedure OnAddProduto(Sender: TObject);

    procedure CarregarPedidos(Sender: TObject);
    procedure OnClickPedido(Sender: TObject);

    procedure CarregarItensPedido(Sender: TObject; AIdPedido: Integer);
    procedure OnGestureTapHoldItem(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure OnExcluirItemClick(Sender: TObject);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Comanda.Lib,

  Service.Base,
  Service.Mesas,
  Service.Pedidos,
  Service.Produtos,
  Service.Usuarios;

{$R *.fmx}

<<<<<<< HEAD

{$HINTS OFF}
procedure TfrmPrincipal.PedirPermissoes;
Var
  Ok: Boolean;
begin
  Ok := True;
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions(
    [JStringToString(TJManifest_permission.JavaClass.BLUETOOTH),
     JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_ADMIN),
     JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_PRIVILEGED),
     JStringToString(TJManifest_permission.JavaClass.INTERNET),
     JStringToString(TJManifest_permission.JavaClass.CAMERA)],
    {$IFDEF DELPHI28_UP}
    procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
    {$ELSE}
    procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
    {$ENDIF}
    var
      GR: TPermissionStatus;
    begin
      for GR in AGrantResults do
        if (GR <> TPermissionStatus.Granted) then
        begin
          Ok := False;
          Break;
        end;
    end
  );

  if not Ok then
    raise EPermissionException.Create('Sem permissões para acesso a Internet');
  {$ENDIF}
=======
{$HINTS OFF}

procedure TfrmPrincipal.PedirPermissoes;
Var
  Ok: Boolean;

begin
  Ok := True;
  {$IfDef ANDROID}
  PermissionsService.RequestPermissions( [JStringToString(TJManifest_permission.JavaClass.BLUETOOTH),
                                          JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_ADMIN),
                                          JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_PRIVILEGED),
                                          JStringToString(TJManifest_permission.JavaClass.INTERNET),
                                          JStringToString(TJManifest_permission.JavaClass.CAMERA)],
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
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
end;
{$HINTS ON}

function TfrmPrincipal.ExtrairTexto(AValue: string; ACaractere: Char): string;
begin
  Result := AValue;
  while (Pos(ACaractere, Result) = 1) do
    Result := Copy(Result, 2, Length(Result));
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(fScanBitmap) then
    FreeAndNil(fScanBitmap);
end;

procedure TfrmPrincipal.btnMaisClick(Sender: TObject);
begin
  edtQtde.Text := (edtQtde.Text.ToInteger + 1).ToString;
end;

procedure TfrmPrincipal.btnMenosClick(Sender: TObject);
begin
  if edtQtde.Text.Equals('1')
  then
    edtQtde.Text := '1'
  else
    edtQtde.Text := (edtQtde.Text.ToInteger - 1).ToString;
end;

procedure TfrmPrincipal.AplicarCores;
begin
  CustomThread(
    procedure()
    begin
      TLoading.Show('Aplicando padrões...');
      TPerfil.InicializarCores;
    end,
    procedure()
    begin
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
          procedure ClonarFundoGeralPadrao(AControl: TComponent);
<<<<<<< HEAD
          var
            LFundoGeralPadrao : TLayout;
          begin
            for var I := 0 to Pred(AControl.ComponentCount) do
            begin
              if (AControl.Components[I] is TTabItem) then
              begin
                LFundoGeralPadrao := TLayout(lytGeralFundoApp.Clone(AControl.Components[I]));

                TTabItem(AControl.Components[I]).AddObject(LFundoGeralPadrao);
                LFundoGeralPadrao.SendToBack;
                ClonarFundoGeralPadrao(AControl.Components[I]);
              end;
            end;
          end;
=======
        var
          LFundoGeralPadrao: TLayout;
        begin
          for var I := 0 to Pred(AControl.ComponentCount) do
          begin
            if (AControl.Components[I] is TTabItem) then
            begin
              LFundoGeralPadrao := TLayout(lytGeralFundoApp.Clone(AControl.Components[I]));

              TTabItem(AControl.Components[I]).AddObject(LFundoGeralPadrao);
              LFundoGeralPadrao.SendToBack;
              ClonarFundoGeralPadrao(AControl.Components[I]);
            end;
          end;
        end;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
        begin
          // Dialogo de adição de qtde
          lblTitQtde.TextSettings.FontColor := TPerfil.COR_PRINCIPAL;
          recBackDialogoQtde.Fill.Color := TAlphaColorRec.White;

          lblBtnDialogoQtde.TextSettings.FontColor := TAlphaColorRec.White;
          recBtnDialogoQtde.Fill.Color := TPerfil.COR_PRINCIPAL;

          // Botão fechar pedido
          lblTitBtnFecharPedido.TextSettings.FontColor := TPerfil.COR_PRINCIPAL;
          recBtnFecharPedido.Fill.Color := TAlphaColorRec.White;

          lblLogin.TextSettings.FontColor := TAlphaColorRec.White;
          recBtnLogin.Fill.Color := TPerfil.COR_OCUPADA;

          recNavegador.Fill.Color := TPerfil.COR_PRINCIPAL;
          recNavegadorProdutos.Fill.Color := TPerfil.COR_PRINCIPAL;

          lblMesa.TextSettings.FontColor := TPerfil.COR_PRINCIPAL;
          lblProduto.TextSettings.FontColor := TPerfil.COR_PRINCIPAL;
          lblNomeProduto.TextSettings.FontColor := TPerfil.COR_PRINCIPAL;

          recTopImagem.Fill.Color := TPerfil.COR_PRINCIPAL;

          ClonarFundoGeralPadrao(Self);
        end
        );
    end,
    procedure()
    begin
      TLoading.Hide;
    end,
    procedure(const AException: string)
    begin

    end,
    True
    )
end;

procedure TfrmPrincipal.InsertGestureLongTapEvent(AObject: TRectangle; AEvent: TGestureEvent);
begin
  for var I: Integer := 0 to Pred(AObject.ComponentCount) do
  begin
    if (AObject.Components[I] is TLabel) then
    begin
      TLabel(AObject.Components[I]).Touch.GestureManager      := gstManager;
      TLabel(AObject.Components[I]).Touch.InteractiveGestures := [TInteractiveGesture.LongTap];
      TLabel(AObject.Components[I]).OnGesture                 := AEvent
    end
    else if AObject.Components[I] is TRectangle then
    begin
      TLabel(AObject.Components[I]).Touch.GestureManager      := gstManager;
      TLabel(AObject.Components[I]).Touch.InteractiveGestures := [TInteractiveGesture.LongTap];
      TRectangle(AObject.Components[I]).OnGesture             := AEvent
    end
    else if AObject.Components[I] is TLayout then
    begin
      TLayout(AObject.Components[I]).Touch.GestureManager      := gstManager;
      TLayout(AObject.Components[I]).Touch.InteractiveGestures := [TInteractiveGesture.LongTap];
      TLayout(AObject.Components[I]).OnGesture                 := AEvent
    end;
  end;
end;

procedure TfrmPrincipal.InsertOnClickEvent(AObject: TControl; AEvent: TNotifyEvent; AllControls: Boolean = True);
<<<<<<< HEAD
  procedure AddEvent(AControl: TControl; AEvent: TNotifyEvent);
  var
    I: Integer;
  begin
    for I := 0 to Pred(AControl.ControlsCount) do
    begin
      if AllControls then
      begin
        AControl.Controls[I].HitTest := True;
        AControl.Controls[I].OnClick := AEvent;
      end
      else
      begin
        if (AControl.Controls[I] is TSpeedButton) then
        begin
          TSpeedButton(AControl.Controls[I]).OnClick := AEvent;
          Break;
        end;
      end;
      AddEvent(AControl.Controls[I], AEvent);
    end;
  end;
=======
procedure AddEvent(AControl: TControl; AEvent: TNotifyEvent);
var
  I: Integer;
begin
  for I := 0 to Pred(AControl.ControlsCount) do
  begin
    if AllControls then
    begin
      AControl.Controls[I].HitTest := True;
      AControl.Controls[I].OnClick := AEvent;
    end
    else
    begin
      if (AControl.Controls[I] is TSpeedButton) then
      begin
        TSpeedButton(AControl.Controls[I]).OnClick := AEvent;
        Break;
      end;
    end;
    AddEvent(AControl.Controls[I], AEvent);
  end;
end;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9

begin
  AObject.BeginUpdate;
  AddEvent(AObject, AEvent);
  AObject.EndUpdate;
end;

procedure TfrmPrincipal.CarregarItensPedido(Sender: TObject; AIdPedido: Integer);
begin
  CustomThread(
    procedure()
    begin
      TLoading.Show('Carregando Itens de Pedido...');

      Self.vertItensPedido.Visible := False;
      Self.vertItensPedido.BeginUpdate;

      Self.LimparLista(Sender, vertItensPedido, recBaseItens.Name);

      ServicePedidos.memItensPedido.DisableControls;
    end,
    procedure()
    var
      LFrame: TRectangle;
      LPosicao: Single;
    begin
      recBaseItens.Visible := False;
      LPosicao := 8;

      ServicePedidos.AbrirItensPedido(ServicePedidos.PedidoSelecionadoID);
      ServicePedidos.memItensPedido.First;
      if not ServicePedidos.memItensPedido.IsEmpty then
      begin
        ServicePedidos.memItensPedido.First;
        while not ServicePedidos.memItensPedido.Eof do
        begin
          lblProduto.Text := ServicePedidos.memItensPedido.FieldByName('NOME').AsString;
          lblDescricao.Text := ServicePedidos.memItensPedido.FieldByName('DESCRICAO').AsString;
          lblQtdeItem.Text := Format('Qtde: %2.2d', [ServicePedidos.memItensPedido.FieldByName('QTDE').AsInteger]);
          lblValorItem.Text := FormatFloat('R$ ###,###,##0.00',
            ServicePedidos.memItensPedido.FieldByName('VALOR_TOTAL').AsFloat);
          lblComandaItem.Text := Format('Cmd: %3.3d', [ServicePedidos.memItensPedido.FieldByName('ID_COMANDA').AsInteger]);

          recBaseItens.Tag := ServicePedidos.memItensPedido.FieldByName('ID').AsInteger;

          TThread.Synchronize(
            TThread.CurrentThread,
            procedure()
            begin
              SetFrameClone(recBaseItens, LFrame, vertItensPedido, LPosicao);
            end
            );

          InsertOnClickEvent(LFrame, OnExcluirItemClick, False);
          InsertGestureLongTapEvent(LFrame, OnGestureTapHoldItem);

          ServicePedidos.memItensPedido.Next;
        end;

        TThread.Queue(
          TThread.CurrentThread,
          procedure()
          begin
            SetFrameClone(recBaseItens, LFrame, vertItensPedido, LPosicao, True);
          end
          );
      end;
    end,
    procedure()
    begin
      TLoading.Hide;

      Self.vertItensPedido.EndUpdate;
      Self.vertItensPedido.ScrollBy(0, 0);
      Self.vertItensPedido.Visible := True;

      ServicePedidos.memItensPedido.EnableControls;
    end,
    procedure(const AException: string)
    begin

    end,
    True
    )
end;

procedure TfrmPrincipal.CarregarMesas;
begin
  CustomThread(
    procedure()
    begin
      TLoading.Show('Carregando mesas...');

      LimparMesas(lstMesasOcupadas);
      LimparMesas(lstMesasLivres);

      ServiceMesas.memMesas.DisableControls;

      lstMesasOcupadas.BeginUpdate;
      lstMesasLivres.BeginUpdate;
    end,
    procedure()
    const
      // Recomendado entre 5 e 7 - Recomendável gravar isso em uma
      // tabela CONFIG no mobile pra ficar pré-configurável
      NumMesasPorLinha = 6; // Pegar de configurações do sistema
    var
      SizeTableW: Double;

      Occuped: Integer;
      LItem: TListBoxItem;
    begin
      lsitemBaseMesa.Visible := False;

      ServiceMesas.ListarMesas;

      var
        LMesasTotal: Integer := ServiceMesas.Total;
      var
        LMesasOcupadas: Integer := ServiceMesas.Ocupadas;
      var
        LMesasLivres: Integer := ServiceMesas.Livres;

      SizeTableW := (lstMesasOcupadas.ClientWidth / NumMesasPorLinha) - 2; // 6 pontos de cada lado nas margens

      lblLotacao.Text := Format('Lotação: %2.2d', [LMesasTotal]);
      lblMesasOcupadas.Text := Format('%2.2d', [LMesasOcupadas]);
      lblMesasLivres.Text := Format('%2.2d', [LMesasLivres]);
      recLegOcupadas.Fill.Color := TPerfil.COR_OCUPADA;
      recLegLivres.Fill.Color := TPerfil.COR_LIVRE;

      lstMesasOcupadas.ItemHeight := SizeTableW;
      lstMesasOcupadas.ItemWidth := SizeTableW;

      lstMesasLivres.ItemHeight := SizeTableW;
      lstMesasLivres.ItemWidth := SizeTableW;

      ServiceMesas.memMesas.First;
      while not ServiceMesas.memMesas.Eof do
      begin
        Occuped := ServiceMesas.memMesas.FieldByName('OCUPADA').AsInteger;

        TThread.Synchronize(
          TThread.Current,
          procedure()
          begin
            lblNumMesa.Text := Format('%2.2d', [ServiceMesas.memMesas.FieldByName('ID').AsInteger]);

            if Occuped = 1 then
            begin
              recMesa.Fill.Color := TPerfil.COR_OCUPADA;
              lblNumMesa.TextSettings.FontColor := TPerfil.COR_LABEL_OCUPADA;

              LItem := TListBoxItem(lsitemBaseMesa.Clone(lstMesasOcupadas));
              LItem.Parent := lstMesasOcupadas;
            end
            else
            begin
              recMesa.Fill.Color := TPerfil.COR_LIVRE;
              lblNumMesa.TextSettings.FontColor := TPerfil.COR_LABEL_LIVRE;

              LItem := TListBoxItem(lsitemBaseMesa.Clone(lstMesasLivres));
              LItem.Parent := lstMesasLivres;
            end;

            LItem.Name := Format('mesa%6.6d', [ServiceMesas.memMesas.FieldByName('ID').AsInteger]);
            LItem.ItemData.Text := EmptyStr;
            LItem.Text := EmptyStr;

            InsertOnClickEvent(LItem, OnClickMesa, True);

            LItem.Tag := Occuped;
            LItem.TagString := ServiceMesas.memMesas.FieldByName('ID').AsInteger.ToString;
            LItem.Visible := True;
          end
          );
        ServiceMesas.memMesas.Next;
      end;

      // Adiciona mais alguns frames invisíveis apenas para criar uma margem
      // de segurança, evitando que as últimas mesas fiquem cortadas.
      TThread.Queue(
        TThread.CurrentThread,
        procedure()
        begin
          for var I := 1 to NumMesasPorLinha do
          begin
            LItem := TListBoxItem(lsitemBaseMesa.Clone(lstMesasLivres));
            LItem.Parent := lstMesasLivres;
            LItem.Opacity := 0;
            LItem.Visible := True;
          end;
        end
        );
    end,
    procedure()
    begin
      ServiceMesas.memMesas.EnableControls;

      lstMesasOcupadas.EndUpdate;
      lstMesasOcupadas.ScrollBy(0, 0);

      lstMesasLivres.EndUpdate;
      lstMesasLivres.ScrollBy(0, 0);

      TLoading.Hide;
    end,
    procedure(const AExcpetion: string)
    begin
      ShowMessage(AExcpetion)
    end,
    True
    );
end;

procedure TfrmPrincipal.LimparMesas(AListBox: TListBox);
var
  I: Integer;
begin
  for I := Pred(AListBox.ComponentCount) downto 0 do
  begin
    if (AListBox.Components[I] is TListBoxItem) then
      (AListBox.Components[I] as TListBoxItem).DisposeOf;
  end;
end;

procedure TfrmPrincipal.OnExcluirItemClick(Sender: TObject);
var
  LID_ITEM: Integer;
begin
  if ServicePedidos.memPedidos.FieldByName('STATUS').AsString.Equals('A') then
  begin
    // Pega o ID do item para exclusão e pontera sobre o item que será excluído
    LID_ITEM := TSpeedButton(Sender).Owner.Tag;
    ServicePedidos.memItensPedido.Locate('ID', LID_ITEM, []);

    TDialogService.MessageDialog(
      'Confirma a exclusão do item selecionado?',
      System.UITypes.TMsgDlgType.mtConfirmation,
      [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
      System.UITypes.TMsgDlgBtn.mbNo, 0,
      procedure(const AResult: TModalResult)
      begin
        case AResult of
          mrYes:
            begin
              ServicePedidos.DeleteItemPedido(
                ServicePedidos.PedidoSelecionadoID,
                ServicePedidos.memItensPedido.FieldByName('ID').AsInteger);
              ServicePedidos.memItensPedido.Delete;
              CarregarItensPedido(Sender, ServicePedidos.PedidoSelecionadoID);
              // ToDo: Atualizar Valor Total Pedido
              // AtualizarValorTotalPedido(DM.QryDWPedidoID.AsInteger);
            end;
        end;
      end
      );
  end;
end;

procedure TfrmPrincipal.OnGestureTapHoldItem(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
<<<<<<< HEAD
  {$IFNDEF MSWINDOWS}
  ServicePedidos.memItensPedido.Locate('ID', TLabel(Sender).Owner.Tag, []);
  ServicePedidos.memItensPedido.Edit;
  MostrarQtde;
  {$ENDIF}
=======
{$IFNDEF MSWINDOWS}
  ServicePedidos.memItensPedido.Locate('ID', TLabel(Sender).Owner.Tag, []);
  ServicePedidos.memItensPedido.Edit;
  MostrarQtde;
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
end;

procedure TfrmPrincipal.ParseImage;
begin
<<<<<<< HEAD
  {$IFDEF ANDROID}
=======
{$IFDEF ANDROID}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  TThread.CreateAnonymousThread(
    procedure
    var
      ReadResult: TReadResult;
      ScanManager: TScanManager;

    begin
      fScanInProgress := True;
      ScanManager := TScanManager.Create(TBarcodeFormat.CODE_39, nil);
      try
        try
          ReadResult := ScanManager.Scan(fScanBitmap);
        except
          on E: Exception do
          begin
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
<<<<<<< HEAD
                //lblScanStatus.Text := 'Erro de leitura';
=======
                // lblScanStatus.Text := 'Erro de leitura';
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
              end);
            // exit;
          end;
        end;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            if pgStatusScan.Value = 100 then
              pgStatusScan.Value := 0;

            pgStatusScan.Value := pgStatusScan.Value + 10;

            if (ReadResult <> nil) then
            begin
              lblCodComanda.Text := ReadResult.Text;
              edtNumComanda.Text := ReadResult.Text;
              Bipar;
            end;
          end);
      finally
        if ReadResult <> nil then
          FreeAndNil(ReadResult);

        ScanManager.Free;
        fScanInProgress := False;
      end;
    end).Start();
<<<<<<< HEAD
  {$ENDIF}
=======
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
end;

procedure TfrmPrincipal.OnClickPedido(Sender: TObject);
var
  LID_Pedido: Integer;
begin
  LID_Pedido := TSpeedButton(Sender).Owner.Tag;
  ServicePedidos.memPedidos.Locate('ID', LID_Pedido, []);
  ServicePedidos.PedidoSelecionadoID := LID_Pedido;
  CarregarItensPedido(Sender, LID_Pedido);
  MudarAba(tbiItens, Sender);
end;

procedure TfrmPrincipal.MostrarFundoEscuro;
begin
  recFundoOpaco.Visible := True;
  recFundoOpaco.Align   := TAlignLayout.Contents;
  recFundoOpaco.BringToFront;
  TAnimator.AnimateFloat(recFundoOpaco, 'Opacity', 0.6);
end;

procedure TfrmPrincipal.MostrarQtde;
begin
  if ServicePedidos.memItensPedido.State in [dsEdit] then
    edtQtde.Text := ServicePedidos.memItensPedido.FieldByName('QTDE').AsInteger.ToString;

  MostrarFundoEscuro;

  lytAddProduto.Position.X := (Self.ClientWidth / 2) - (lytAddProduto.Width / 2);
  lytAddProduto.Position.Y := 100;
  lytAddProduto.Visible    := True;
  lytAddProduto.BringToFront;
  TAnimator.AnimateFloat(lytAddProduto, 'Opacity', 1)
end;

procedure TfrmPrincipal.MostrarScan;
begin
  CustomThread(
    procedure()
    begin
      TLoading.Show('Carregando câmera...');
    end,
    procedure()
    begin
      MostrarFundoEscuro;
      lytComanda.BringToFront;

<<<<<<< HEAD
      {$IFDEF ANDROID}
=======
{$IFDEF ANDROID}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
      camComanda.Active := False;
      camComanda.Quality := FMX.Media.TVideoCaptureQuality.MediumQuality;
      camComanda.Kind := FMX.Media.TCameraKind.BackCamera;
      camComanda.FocusMode := FMX.Media.TFocusMode.ContinuousAutoFocus;
      camComanda.Active := True;
<<<<<<< HEAD
      {$ENDIF}
=======
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
      lblCodComanda.Text := EmptyStr;
      lytComanda.Width := Self.ClientWidth - 40;
      lytComanda.Position.X := (Self.ClientWidth / 2) - (lytComanda.Width / 2);
      lytComanda.Position.Y := 20;

      lytComanda.Visible := True;
      TAnimator.AnimateFloat(lytComanda, 'Opacity', 1);
    end,
    procedure()
    begin
      TLoading.Hide;
    end,
    procedure(const AException: string)
    begin

    end,
    True
    );
end;

procedure TfrmPrincipal.MudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  actMudarAba.Tab        := ATabItem;
  actMudarAba.Transition := TTabTransition.None;
  actMudarAba.ExecuteTarget(Sender);
end;

procedure TfrmPrincipal.OcultarFundoEscuro;
begin
  TAnimator.AnimateFloat(recFundoOpaco, 'Opacity', 0);
  recFundoOpaco.Visible := False;
end;

<<<<<<< HEAD

=======
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
procedure TfrmPrincipal.OcultarQtde;
begin
  TAnimator.AnimateFloat(lytAddProduto, 'Opacity', 0);
  lytAddProduto.Visible := False;
  edtQtde.Text          := '1';
  OcultarFundoEscuro;
end;

procedure TfrmPrincipal.OcultarScan;
begin
  OcultarFundoEscuro;
  TAnimator.AnimateFloat(lytComanda, 'Opacity', 0);
  lytComanda.Visible := False;
  camComanda.Active  := False;
  edtNumComanda.Text := EmptyStr;
  lblCodComanda.Text := EmptyStr;
end;

procedure TfrmPrincipal.recFundoOpacoClick(Sender: TObject);
begin
  edtNumComanda.Text := EmptyStr;
  camComanda.Active  := False;
  OcultarQtde;
  OcultarScan;
  OcultarFundoEscuro;
end;

procedure TfrmPrincipal.CarregarPedidos(Sender: TObject);
begin
  CustomThread(
    procedure()
    begin
      TLoading.Show('Carregando Pedidos...');

      Self.vertPedidos.Visible := False;
      Self.vertPedidos.BeginUpdate;

      Self.LimparLista(Sender, vertPedidos, recBasePedidos.Name);

      ServicePedidos.memPedidos.DisableControls;
    end,
    procedure()
    var
      LFrame: TRectangle;
      LPosicao: Single;
    begin
      if not ServicePedidos.memPedidos.IsEmpty then
      begin
        recBasePedidos.Visible := False;
        LPosicao := 8;

        ServicePedidos.memPedidos.First;
        while not ServicePedidos.memPedidos.Eof do
        begin
          lblValor.Text := FormatFloat('R$ ###,###,##0.00',
            ServicePedidos.memPedidos.FieldByName('VALOR_TOTAL').AsFloat);
          lblMesa.Text := Format('Mesa: %2.2d', [ServicePedidos.memPedidos.FieldByName('ID_MESA').AsInteger]);

          recBasePedidos.Tag := ServicePedidos.memPedidos.FieldByName('ID').AsInteger;

          TThread.Synchronize(
            TThread.CurrentThread,
            procedure()
            begin
              SetFrameClone(recBasePedidos, LFrame, vertPedidos, LPosicao);
            end
            );

          InsertOnClickEvent(LFrame, OnClickPedido, True);

          ServicePedidos.memPedidos.Next;
        end;
      end;
    end,
    procedure()
    begin
      TLoading.Hide;

      Self.vertPedidos.EndUpdate;
      Self.vertPedidos.ScrollBy(0, 0);
      Self.vertPedidos.Visible := True;

      ServicePedidos.memPedidos.EnableControls;
    end,
    procedure(const AException: string)
    begin

    end,
    True
    )
end;

procedure TfrmPrincipal.CarregarProdutos(Sender: TObject);
begin
  CustomThread(
    procedure()
    begin
      TLoading.Show('Carregando Produtos...');

      Self.vertProdutos.Visible := False;
      Self.vertProdutos.BeginUpdate;

      Self.LimparLista(Sender, vertProdutos, recBaseProdutos.Name);

      ServiceProdutos.memProdutos.DisableControls;
    end,
    procedure()
    var
      LFrame: TRectangle;
      LPosicao: Single;
    begin
      recBaseProdutos.Visible := False;
      LPosicao := 8;

      ServiceProdutos.AbrirProdutos;

      if not ServiceProdutos.memProdutos.IsEmpty then
      begin
        ServiceProdutos.memProdutos.First;
        while not ServiceProdutos.memProdutos.Eof do
        begin
          lblNomeProduto.Text := ServiceProdutos.memProdutos.FieldByName('NOME').AsString;
          lblDescProduto.Text := ServiceProdutos.memProdutos.FieldByName('DESCRICAO').AsString;
          lblValorUnitario.Text := FormatFloat('R$ ###,###,##0.00',
            ServiceProdutos.memProdutos.FieldByName('VLR_UNITARIO').AsFloat);

          recBaseProdutos.Tag := ServiceProdutos.memProdutos.FieldByName('ID').AsInteger;

          TThread.Synchronize(
            TThread.CurrentThread,
            procedure()
            begin
              SetFrameClone(recBaseProdutos, LFrame, vertProdutos, LPosicao);
            end
            );

          // Adiciona OnClick no botão da direita
          InsertOnClickEvent(LFrame, OnAddProduto, True);
          ServiceProdutos.memProdutos.Next;
        end;

        TThread.Synchronize(
          TThread.CurrentThread,
          procedure()
          begin
            SetFrameClone(recBaseProdutos, LFrame, vertProdutos, LPosicao, True);
          end
          );

      end;
    end,
    procedure()
    begin
      TLoading.Hide;

      Self.vertProdutos.EndUpdate;
      Self.vertProdutos.ScrollBy(0, 0);
      Self.vertProdutos.Visible := True;

      ServiceProdutos.memProdutos.EnableControls;
    end,
    procedure(const AException: string)
    begin

    end,
    True
    )
end;

procedure TfrmPrincipal.CustomThread(AOnStart, AOnProcess, AOnComplete: TProc; AOnError: TProcedureExcept;
const ADoCompleteWithError: Boolean);
var
  LThread: TThread;
begin
  LThread :=
    TThread.CreateAnonymousThread(
    procedure()
<<<<<<< HEAD
    //ToDo: Revisar
    //var
    //  LDoComplete: Boolean;
    begin
      try
        {$REGION 'Processo completo'}
        {$REGION 'Start'}
        try
          //ToDo: Revisar
          //LDoComplete := True;
=======
    // ToDo: Revisar
    // var
    // LDoComplete: Boolean;
    begin
      try
{$REGION 'Processo completo'}
{$REGION 'Start'}
        try
          // ToDo: Revisar
          // LDoComplete := True;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
          // Processo Inicial
          if (Assigned(AOnStart)) then
          begin
            TThread.Synchronize(
              TThread.CurrentThread,
              procedure()
              begin
                AOnStart;
              end
              );
          end;
<<<<<<< HEAD
          {$ENDREGION}
          {$REGION 'Process'}
          // Processo Principal
          if Assigned(AOnProcess) then
            AOnProcess;
          {$ENDREGION}
        except
          on E: Exception do
          begin
            //ToDo: Revisar
            //LDoComplete := ADoCompleteWithError;
=======
{$ENDREGION}
{$REGION 'Process'}
          // Processo Principal
          if Assigned(AOnProcess) then
            AOnProcess;
{$ENDREGION}
        except
          on E: Exception do
          begin
            // ToDo: Revisar
            // LDoComplete := ADoCompleteWithError;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
            // Processo de Erro
            if Assigned(AOnError) then
            begin
              TThread.Synchronize(
                TThread.CurrentThread,
                procedure()
                begin
                  AOnError(E.Message);
                end
                );
            end;
          end;
        end;
      finally
<<<<<<< HEAD
        {$REGION 'Complete'}
=======
{$REGION 'Complete'}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
        // Processo de Finalização
        if Assigned(AOnComplete) then
        begin
          TThread.Synchronize(
            TThread.CurrentThread,
            procedure()
            begin
              AOnComplete;
            end
            );
        end;
<<<<<<< HEAD
        {$ENDREGION}
        {$ENDREGION}
=======
{$ENDREGION}
{$ENDREGION}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
      end;
    end
    );
  LThread.FreeOnTerminate := True;
  LThread.Start;
end;

procedure TfrmPrincipal.OnAddProduto(Sender: TObject);
var
  LID_Produto: Integer;
begin
  LID_Produto := TSpeedButton(Sender).Owner.Tag;
  ServiceProdutos.memProdutos.Locate('ID', LID_Produto, []);
  MostrarQtde;
end;

procedure TfrmPrincipal.OnClickMesa(Sender: TObject);
var
  Occuped:  Integer;
  LID_Mesa: Integer;
begin
  LID_Mesa := TListBoxItem(TSpeedButton(Sender).Owner).TagString.ToInteger;
  Occuped  := TListBoxItem(TSpeedButton(Sender).Owner).Tag;
  ServiceMesas.memMesas.Locate('ID', LID_Mesa, []);
  case Occuped of
    1:
      begin
        Navegar(tnPedidos);
        MudarAba(tbiPedidos, Sender);
        ServicePedidos.AbrirPedidos(LID_Mesa);
        CarregarPedidos(Sender);

        if not(ServicePedidos.memPedidos.IsEmpty) then
        begin
          ServicePedidos.PedidoSelecionadoID := ServicePedidos.memPedidos.FieldByName('ID').AsInteger;
          ServicePedidos.memPedidos.Filter   := Format('ID=%d', [ServicePedidos.PedidoSelecionadoID]);
          ServicePedidos.memPedidos.Filtered := True;
        end
        else
        begin
          ServicePedidos.PedidoSelecionadoID := 0;
          TDialogService.MessageDialog(
            'A mesa está ocupada, mas não possui pedido. Verifique!',
            System.UITypes.TMsgDlgType.mtWarning,
            [System.UITypes.TMsgDlgBtn.mbOK],
            System.UITypes.TMsgDlgBtn.mbOK, 0, nil
            );
        end;
      end;
    0:
      begin
        TDialogService.MessageDialog(
          'Deseja abrir um pedido para essa mesa?',
          System.UITypes.TMsgDlgType.mtConfirmation,
          [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
          System.UITypes.TMsgDlgBtn.mbNo, 0,
          procedure(const AResult: TModalResult)
          begin
            case AResult of
              mrYes:
                begin
                  Self.AbrirMesa(Sender);
                end;
            end;
          end
          );
      end;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  AppEventSvc: IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(AppEventSvc)) then
  begin
    AppEventSvc.SetApplicationEventHandler(AppEvent);
  end;

<<<<<<< HEAD
  {$IFDEF MSWINDOWS}
    Self.Left := 10;
    Self.Top  := 10;
  {$ENDIF}
=======
{$IFDEF MSWINDOWS}
  Self.Left := 10;
  Self.Top  := 10;
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  try
    Inicializar;
  except
    on E: Exception do
    begin
      raise Exception.Create('Não foi possível encontrar o servidor da comanda.' + #13#10 +
        'Contate o suporte técnico.');
    end;
  end;

  fFrameTake  := 0;
  fScanBitmap := nil;

  OcultarScan;
end;

procedure TfrmPrincipal.Logoff(Sender: TObject);
begin
  ServiceBase.CloseAllTables(ServiceMesas);
  ServiceBase.CloseAllTables(ServiceProdutos);
  ServiceBase.CloseAllTables(ServicePedidos);
  ServiceBase.CloseAllTables(ServiceUsuarios);

  // ToDo: Ajustar pós migração
  // DM.GarcomID                := 0;
  ServicePedidos.PedidoSelecionadoID := 0;

  LimparMesas(lstMesasOcupadas);
  LimparLista(Sender, vertProdutos, recBaseProdutos.Name);
  LimparLista(Sender, vertItensPedido, recBaseItens.Name);
  LimparLista(Sender, vertPedidos, recBasePedidos.Name);

  OcultarQtde;

  MudarAba(tbiLogin, Sender);
end;

procedure TfrmPrincipal.Login(AUsuario, ASenha: string; Sender: TObject);
begin
  Navegar(tnMesas);
  if ServiceUsuarios.Login(AUsuario, ASenha) then
  begin
    MudarAba(tbiPrincipal, Sender);
    CarregarMesas;
  end;
end;

procedure TfrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar:
  Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if not(tbcPrincipal.ActiveTab = tbiLogin) then
    begin
      ExecutarNavegacao(Sender);
      Key := 0;
    end;
  end;
end;

procedure TfrmPrincipal.ExecutarNavegacao(Sender: TObject);
begin
  if (tbcPrincipal.ActiveTab = tbiProdutos) then
  begin
    if lytAddProduto.Visible
    then
      OcultarQtde
    else
<<<<<<< HEAD
      MudarAba(tbiPrincipal, Sender);
=======
    begin
      CarregarItensPedido(Sender, ServicePedidos.PedidoSelecionadoID);
      MudarAba(tbiPrincipal, Sender);
    end;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  end
  else if tbcPrincipal.ActiveTab = tbiPrincipal then
  begin
    if (tbcOperacao.ActiveTab = tbiItens) then
    begin
      if lytComanda.Visible then
      begin
        OcultarScan;
        exit;
      end;

      ServicePedidos.memItensPedido.Filter   := Format('ID_PEDIDO=%d', [ServicePedidos.PedidoSelecionadoID]);
      ServicePedidos.memItensPedido.Filtered := True;
      if not(ServicePedidos.memItensPedido.IsEmpty) then
      begin
        if (TSpeedButton(Sender).Name = 'speBtnMesas') then
        begin
          MudarAba(tbiMesas, Sender);
          Navegar(tnMesas);
          CarregarMesas;
        end
        else
        begin
          CarregarPedidos(Sender);
          MudarAba(tbiPedidos, Sender);
        end;
      end
      else
      begin
        TDialogService.MessageDialog(
          'O pedido não possui itens. Deseja cancelar o pedido?',
          System.UITypes.TMsgDlgType.mtConfirmation,
          [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
          System.UITypes.TMsgDlgBtn.mbNo, 0,
          procedure(const AResult: TModalResult)
          begin
            case AResult of
              mrYes:
                begin
                  ServicePedidos.memPedidos.Filter := EmptyStr;
                  ServicePedidos.memPedidos.Filtered := False;
                  ServicePedidos.memPedidos.Locate('ID', ServicePedidos.PedidoSelecionadoID, []);
                  ServicePedidos.memPedidos.Delete;
                  ServicePedidos.DeletePedido(ServicePedidos.PedidoSelecionadoID);
                  ServicePedidos.PedidoSelecionadoID := 0;
                  ServiceMesas.DesmarcarMesa;
                  MudarAba(tbiMesas, Sender);
                  Navegar(tnMesas);
                  CarregarMesas;
                end;
            end;
          end
          );
      end;
    end
    else if tbcOperacao.ActiveTab = tbiPedidos then
    begin
      Navegar(tnMesas);
      CarregarMesas;
      MudarAba(tbiMesas, Sender);
    end
    else if tbcOperacao.ActiveTab = tbiMesas then
    begin
      Logoff(Sender);
      MudarAba(tbiLogin, Sender);
    end;
  end
end;

procedure TfrmPrincipal.Inicializar;
{$REGION 'Aplicar'}
procedure Aplicar;
begin
  var
    LProporcao: Double := 70;

  lytMesasOcupadas.Height := lytGeral.Height * (LProporcao / 100);
  lytMesasLivres.Height   := (lytGeral.Height * ((100 - LProporcao) / 100)) +
    lytTitMesaOcupada.Height + lytTitMesasLivres.Height - lytLegenda.Height - 25;

  lytMesasOcupadas.Width       := lytGeral.Width;
  lytMesasLivres.Width         := lytGeral.Width;
  lytTitMesaOcupada.Width      := lytGeral.Width;
  lytTitMesasLivres.Width      := lytGeral.Width;
  lytTitMesaOcupada.Position.Y := 0;
  lytTitMesaOcupada.Position.X := 0;
  lytMesasOcupadas.Position.Y  := lytTitMesaOcupada.Height;
  lytMesasOcupadas.Position.X  := 0;

  lytTitMesasLivres.Position.Y := lytMesasOcupadas.Height + lytTitMesaOcupada.Height;
  lytTitMesasLivres.Position.X := 0;
  lytMesasLivres.Position.Y    := lytTitMesasLivres.Position.Y + lytTitMesaOcupada.Height;
  lytMesasLivres.Position.X    := 0;

  lytLegenda.BringToFront;
  lytLegenda.Align := TAlignLayout.Bottom;

<<<<<<< HEAD
  lsitemBaseMesa.Visible             := False;
  lytGeralFundoApp.Align             := TAlignLayout.Contents;
  tbcOperacao.Position.X             := 0;
  tbcOperacao.Position.Y             := 48;
  tbcOperacao.Height                 := Self.ClientHeight - 48;
  tbcOperacao.Width                  := Self.ClientWidth;
  tbcPrincipal.TabPosition           := TTabPosition.None;
  tbcPrincipal.ActiveTab             := tbiLogin;
  tbcOperacao.TabPosition            := TTabPosition.None;
  tbcOperacao.ActiveTab              := tbiMesas;
  grdMnuMesas.ItemWidth              := (grdMnuMesas.Width / 2);
  grdMenuProdutos.ItemWidth          := grdMnuMesas.Width;

  {$IFDEF MSWINDOWS}
  edtLogin.TextSettings.FontColor := TAlphaColorRec.Black;
  edtSenha.TextSettings.FontColor := TAlphaColorRec.Black;
  {$ELSE}
  edtLogin.TextSettings.FontColor := TAlphaColorRec.White;
  edtSenha.TextSettings.FontColor := TAlphaColorRec.White;
  {$ENDIF}
=======
  lsitemBaseMesa.Visible    := False;
  lytGeralFundoApp.Align    := TAlignLayout.Contents;
  tbcOperacao.Position.X    := 0;
  tbcOperacao.Position.Y    := 48;
  tbcOperacao.Height        := Self.ClientHeight - 48;
  tbcOperacao.Width         := Self.ClientWidth;
  tbcPrincipal.TabPosition  := TTabPosition.None;
  tbcPrincipal.ActiveTab    := tbiLogin;
  tbcOperacao.TabPosition   := TTabPosition.None;
  tbcOperacao.ActiveTab     := tbiMesas;
  grdMnuMesas.ItemWidth     := (grdMnuMesas.Width / 2);
  grdMenuProdutos.ItemWidth := grdMnuMesas.Width;

{$IFDEF MSWINDOWS}
  edtLogin.TextSettings.FontColor := TAlphaColorRec.Black;
  edtSenha.TextSettings.FontColor := TAlphaColorRec.Black;
{$ELSE}
  edtLogin.TextSettings.FontColor := TAlphaColorRec.White;
  edtSenha.TextSettings.FontColor := TAlphaColorRec.White;
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  OcultarFundoEscuro;
  OcultarQtde;
end;
{$ENDREGION}

<<<<<<< HEAD
=======

>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
begin
  try
    PedirPermissoes;
    Config;

    TPerfil.InicializarCores;
    AplicarCores;
    Aplicar;

    // Configura o DataSet Serialize para pegar o padrão do banco
    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndNone;
  except
    on E: Exception do
    begin
      raise;
      AplicarCores;
      Aplicar;
    end;
  end;
end;

procedure TfrmPrincipal.spePedidosClick(Sender: TObject);
begin
  Navegar(tnPedidos);
  ServicePedidos.AbrirPedidos;
  CarregarPedidos(Sender);
  MudarAba(tbiPedidos, Sender);
end;

procedure TfrmPrincipal.Navegar(ADestino: TNavegacao);
var
  LNavegadorPosicao: Single;
begin
  case ADestino of
    tnLogin:
      begin

      end;
    tnMesas:
      begin
        LNavegadorPosicao := lytBtnMesas.Position.X + (lytBtnMesas.Width / 2) - (recNavegador.Width / 2);
        TAnimator.AnimateFloat(recNavegador, 'Position.X', LNavegadorPosicao,
          0.2, TAnimationType.InOut, TInterpolationType.Elastic
          );
      end;
    // Executa o mesmo efeito
    tnPedidos, tnItens:
      begin
        LNavegadorPosicao := lytBtnPedidos.Position.X + (lytBtnPedidos.Width / 2) - (recNavegador.Width / 2);
        TThread.Synchronize(
          TThread.CurrentThread,
          procedure()
          begin
            TAnimator.AnimateFloat(recNavegador, 'Position.X', LNavegadorPosicao,
              0.2, TAnimationType.InOut, TInterpolationType.Elastic
              );
          end
          );
      end;
    tnProdutos:
      begin
        recNavegadorProdutos.Width := 10;
        TAnimator.AnimateFloat(
          recNavegadorProdutos, 'Width', lytNavegadorProdutos.Width - 32, 0.5,
          TAnimationType.InOut, TInterpolationType.Elastic
          );
      end;
  end;
end;

procedure TfrmPrincipal.speAccessPedidoClick(Sender: TObject);
begin
  ShowMessage('Itens do Pedido');
end;

procedure TfrmPrincipal.Config;
begin
<<<<<<< HEAD
  TLib.User      := 'ADRIANO';
  TLib.Pass      := '123456';
  TLib.Server    := 'localhost';
  TLib.Port      := 9040;
=======
  TLib.User   := 'ADRIANO';
  TLib.Pass   := '123456';
  TLib.Server := '54.225.21.228';
  TLib.Port   := 9040;

>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
end;

procedure TfrmPrincipal.LimparLista(Sender: TObject;
AVertScroll: TVertScrollBox; ARectBase: string);
var
  I:      Integer;
  LFrame: TRectangle;
begin
  // Pesquisar e deixar isso no formulário padrão de listas.
  AVertScroll.BeginUpdate;
  for I := Pred(AVertScroll.Content.ChildrenCount) downto 0 do
  begin
    if (AVertScroll.Content.Children[I] is TRectangle) then
    begin
      if not(TRectangle(AVertScroll.Content.Children[I]).Name = ARectBase) then
      begin
        LFrame := (AVertScroll.Content.Children[I] as TRectangle);
        FreeAndNil(LFrame);
      end;
    end;
  end;
  AVertScroll.EndUpdate;
end;

procedure TfrmPrincipal.SetFrameClone(ARectBase: TRectangle; var AClone: TRectangle;
AScroll: TVertScrollBox; var APosition: Single);
begin
  AClone            := TRectangle(ARectBase.Clone(AScroll));
  AClone.Parent     := AScroll;
  AClone.Name       := Format('%s%6.6d', [ARectBase.Name, ARectBase.Tag]);
  AClone.Position.Y := APosition; // 10 de Margem esquerda
  AClone.Position.X := 10;
  AClone.Height     := ARectBase.Height;
<<<<<<< HEAD
  {$IFDEF MSWINDOWS}
  AClone.Width := AScroll.Width - 20; // 24 //Barra de rolagem do Windows
  {$ELSE}
  AClone.Width := AScroll.Width - 20; // - 8;
  {$ENDIF}
=======
{$IFDEF MSWINDOWS}
  AClone.Width := AScroll.Width - 20; // 24 //Barra de rolagem do Windows
{$ELSE}
  AClone.Width := AScroll.Width - 20; // - 8;
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  ARectBase.Opacity := 1;
  AClone.Visible    := True;
  APosition         := APosition + ARectBase.Height + 10;
end;

procedure TfrmPrincipal.SetFrameClone(ARectBase: TRectangle; var AClone: TRectangle;
AScroll: TVertScrollBox; var APosition: Single; AFim: Boolean);
begin
  randomize;
  // Retira a linha de contorno do retângulo principal
  AClone            := TRectangle(ARectBase.Clone(AScroll));
  AClone.Parent     := AScroll;
  AClone.Name       := Format('%s%6.6d', [ARectBase.Name, Random(100000) * 2]);
  AClone.Position.Y := APosition;
  AClone.Position.X := 4;
  AClone.Height     := ARectBase.Height / 2;
<<<<<<< HEAD
  {$IFDEF MSWINDOWS}
  AClone.Width := AScroll.Width - 8; // 24 //Barra de rolagem do Windows
  {$ELSE}
  AClone.Width := AScroll.Width - 8;
  {$ENDIF}
=======
{$IFDEF MSWINDOWS}
  AClone.Width := AScroll.Width - 8; // 24 //Barra de rolagem do Windows
{$ELSE}
  AClone.Width := AScroll.Width - 8;
{$ENDIF}
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  AClone.Opacity := 0;
  AClone.Visible := True;

end;

procedure TfrmPrincipal.speAddItemClick(Sender: TObject);
begin
  MostrarScan;
end;

procedure TfrmPrincipal.speBtnDialogoQtdeClick(Sender: TObject);
begin
  // Se estiver em modo Edição, alteramos a quantidade
  if ServicePedidos.memItensPedido.State in [dsEdit] then
    ServicePedidos.memItensPedido.FieldByName('QTDE').AsInteger := edtQtde.Text.ToInteger()
  else
  begin
    if not ServicePedidos.memItensPedido.Active then
      ServicePedidos.memItensPedido.Active := True;

    ServicePedidos.memItensPedido.Append;
    ServicePedidos.memItensPedido.FieldByName('ID').AsInteger         := -1;
    ServicePedidos.memItensPedido.FieldByName('STATUS').AsString      := 'A';
    ServicePedidos.memItensPedido.FieldByName('ID_PEDIDO').AsInteger  := ServicePedidos.PedidoSelecionadoID;
    ServicePedidos.memItensPedido.FieldByName('QTDE').AsInteger       := edtQtde.Text.ToInteger();
    ServicePedidos.memItensPedido.FieldByName('ID_PRODUTO').AsInteger := ServiceProdutos.memProdutos.FieldByName('ID').AsInteger;

    ServicePedidos.memItensPedido.FieldByName('ID_COMANDA').AsInteger := FComanda;
  end;

  ServicePedidos.memItensPedido.Post;
  if ServicePedidos.SyncItensPedido(ServicePedidos.PedidoSelecionadoID) then
    CarregarItensPedido(Sender, ServicePedidos.PedidoSelecionadoID);

  // ToDo: Atualizar Valor Total Pedido
  // AtualizarValorTotalPedido(ServicePedidos.PedidoSelecionadoID);
  OcultarQtde;
end;

procedure TfrmPrincipal.speFecharPedidoClick(Sender: TObject);
begin
<<<<<<< HEAD
  //ToDo: Fechar mesa, alterar o método.
=======
  // ToDo: Fechar mesa, alterar o método.
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  ServicePedidos.memItensPedido.Filter   := Format('ID_PEDIDO=%d', [ServicePedidos.PedidoSelecionadoID]);
  ServicePedidos.memItensPedido.Filtered := True;

  if ServicePedidos.memItensPedido.IsEmpty then
  begin
    ShowMessage('Não é possível fechar o pedido sem adicionar itens.');
  end
  else
  begin
    TDialogService.MessageDialog(
      'Confirma Fechamento de Mesa?',
      System.UITypes.TMsgDlgType.mtConfirmation,
      [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
      System.UITypes.TMsgDlgBtn.mbNo, 0,
      procedure(const AResult: TModalResult)
      begin
        case AResult of
          mrYes:
            begin
              ServicePedidos.memPedidos.Edit;
              ServicePedidos.memPedidos.FieldByName('STATUS').AsString := 'F';
              ServicePedidos.memPedidos.FieldByName('ID_MESA').AsInteger := 0;
              ServicePedidos.memPedidos.Post;
              ServicePedidos.SyncPedido;

              ServiceMesas.memMesas.Locate('ID', ServicePedidos.memPedidos.FieldByName('ID_MESA').AsInteger, []);
              ServiceMesas.DesmarcarMesa;
              MudarAba(tbiMesas, Sender);
              Navegar(tnMesas);
              CarregarMesas;
            end;
        end;
      end
      );
  end;
end;

procedure TfrmPrincipal.speLoginClick(Sender: TObject);
begin
  if edtLogin.Text.Equals(EmptyStr) then
    raise Exception.Create('Campo "LOGIN" é de uso obrigatório.');

  if edtSenha.Text.Equals(EmptyStr) then
    raise Exception.Create('Campo "SENHA" é de uso obrigatório.');

  Login(edtLogin.Text, edtSenha.Text, Sender);
end;

procedure TfrmPrincipal.speRefreshClick(Sender: TObject);
begin
  CarregarMesas;
end;

procedure TfrmPrincipal.speSairConfigClick(Sender: TObject);
begin
  //
end;

<<<<<<< HEAD
{$IFDEF ANDROID}
=======
procedure TfrmPrincipal.tbcPrincipalChange(Sender: TObject);
begin

end;

{$IFDEF ANDROID}

>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
procedure TfrmPrincipal.Bipar;
var
  ResStream: TResourceStream;
  tmpFile:   string;
  AMedia:    TMediaPlayer;
begin
  ResStream := TResourceStream.Create(HInstance, 'beep2', RT_RCDATA);
  try
    AMedia             := TMediaPlayer.Create(nil);
    tmpFile            := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetTempPath, 'beep2.mp3');
    ResStream.Position := 0;
    ResStream.SaveToFile(tmpFile);
    AMedia.FileName := tmpFile;
    AMedia.Play;
    Sleep(500);
  finally
    if FileExists(tmpFile) then
      DeleteFile(tmpFile);

    FreeAndNil(ResStream);
    FreeAndNil(AMedia);
  end;
end;
{$ENDIF}

<<<<<<< HEAD
=======

>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
procedure TfrmPrincipal.camComandaSampleBufferReady(Sender: TObject;
const ATime: TMediaTime);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      camComanda.SampleBufferToBitmap(imgCamera.Bitmap, True);

      if (fScanInProgress) then
        exit;

      inc(fFrameTake);
      if (fFrameTake mod 4 <> 0) then
        exit;

      if Assigned(fScanBitmap) then
        FreeAndNil(fScanBitmap);

      fScanBitmap := TBitmap.Create();
      fScanBitmap.Assign(imgCamera.Bitmap);

      ParseImage();
    end);
end;

function TfrmPrincipal.AppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
begin
  Result := True;
  case AAppEvent of
    TApplicationEvent.WillBecomeInactive,
<<<<<<< HEAD
    TApplicationEvent.EnteredBackground,
    TApplicationEvent.WillTerminate: camComanda.Active := False;
=======
      TApplicationEvent.EnteredBackground,
      TApplicationEvent.WillTerminate:
      camComanda.Active := False;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  end;
end;

procedure TfrmPrincipal.edtNumComandaTyping(Sender: TObject);
begin
  lblCodComanda.Text := edtNumComanda.Text;
end;

procedure TfrmPrincipal.speBtnCancComandaClick(Sender: TObject);
begin
  OcultarScan;
end;

procedure TfrmPrincipal.speBtnConfComandaClick(Sender: TObject);
begin
  if not(edtNumComanda.Text.Equals(EmptyStr)) then
  begin
    FComanda := ExtrairTexto(edtNumComanda.Text, '0').ToInteger;
    MudarAba(tbiProdutos, Sender);
    Navegar(tnProdutos);
    CarregarProdutos(Sender);
    OcultarScan;
  end
  else
  begin
    TDialogService.ShowMessage('O número da comanda deve ser digitado!');
    edtNumComanda.SetFocus;
  end;
end;

procedure TfrmPrincipal.AbrirMesa(Sender: TObject);
begin
  Self.vertItensPedido.Visible := False;
  Self.vertItensPedido.BeginUpdate;
  Self.LimparLista(Sender, vertItensPedido, recBaseItens.Name);

  if not ServicePedidos.memPedidos.Active then
    ServicePedidos.AbrirPedidos();

  ServicePedidos.memPedidos.Filter       := EmptyStr;
  ServicePedidos.memPedidos.Filtered     := False;
  ServicePedidos.memItensPedido.Filter   := EmptyStr;
  ServicePedidos.memItensPedido.Filtered := False;

  ServicePedidos.memPedidos.Append;
<<<<<<< HEAD
  ServicePedidos.memPedidos.FieldByName('ID').AsInteger          := -1;       // Servidor Gera o ID_Pedido - GetIDPedido + 1;
  ServicePedidos.memPedidos.FieldByName('STATUS').AsString       := 'A';
=======
  ServicePedidos.memPedidos.FieldByName('ID').AsInteger        := -1; // Servidor Gera o ID_Pedido - GetIDPedido + 1;
  ServicePedidos.memPedidos.FieldByName('STATUS').AsString     := 'A';
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
  ServicePedidos.memPedidos.FieldByName('VALOR_TOTAL').AsFloat := 0;
  ServicePedidos.memPedidos.FieldByName('ID_GARCOM').AsInteger := ServiceUsuarios.memGarcom.FieldByName('ID').AsInteger;
  ServicePedidos.memPedidos.FieldByName('ID_MESA').AsInteger   := ServiceMesas.memMesas.FieldByName('ID').AsInteger;
  ServicePedidos.memPedidos.Post;

  // Aqui chamar o SYNC
  if ServicePedidos.SyncPedido then
    ServicePedidos.AbrirPedidos(ServicePedidos.memPedidos.FieldByName('ID_MESA').AsInteger);

  TThread.Synchronize(
    TThread.CurrentThread,
    procedure()
    begin
      Self.recBaseItens.Visible := False;
    end
    );

  Navegar(tnItens);
  ServicePedidos.PedidoSelecionadoID := ServicePedidos.memPedidos.FieldByName('ID').AsInteger;
  ServicePedidos.memPedidos.Locate('ID', ServicePedidos.PedidoSelecionadoID, []);
  ServiceMesas.MarcarMesa;

  MudarAba(tbiItens, Sender);
end;

end.
