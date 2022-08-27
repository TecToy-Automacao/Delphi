unit UntMain;

interface

uses
  ACBrBase,
  ACBrPosPrinter,
  Router4D,

  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.EngExt,
  Data.Bind.Grid,

  DataSet.Serialize,
  DataSet.Serialize.Config,

  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.DialogService,
  FMX.Dialogs,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Forms,
  FMX.Graphics,
  FMX.Grid,
  FMX.Grid.Style,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Objects,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.Types,

  FMX.Bind.DBEngExt,
  FMX.Bind.Editors,
  FMX.Bind.Grid,

  Router4D.Interfaces,
  Router4D.Props,

  Service.Pedidos,

  System.Bindings.Outputs,
  System.Classes,
  System.JSON,
  System.Rtti,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
  MobilePermissions.Model.Signature,
  MobilePermissions.Model.Dangerous,
  MobilePermissions.Model.Standard,
  MobilePermissions.Component;

type
  TViewMonitorProducao = class(TForm)
    ACBrPosPrinter: TACBrPosPrinter;
    lytMain: TLayout;
    lytTop: TLayout;
    recTopMain: TRectangle;
    lblTituloMain: TLabel;
    imgLogo: TImage;
    lytContainer: TLayout;
    lytLeftContainer: TLayout;
    recBackMenu: TRectangle;
    lytLeftMenu: TLayout;
    recBackMesas: TRectangle;
    flwMesas: TFlowLayout;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    vertMesas: TVertScrollBox;
    tmUpdate: TTimer;
    lytTodasLegendas: TLayout;
    lytEntregue: TLayout;
    Rectangle3: TRectangle;
    Label6: TLabel;
    lytAguardando: TLayout;
    Rectangle4: TRectangle;
    Label7: TLabel;
    lytPreparo: TLayout;
    Rectangle5: TRectangle;
    Label8: TLabel;
    Layout9: TLayout;
    lytStatusItem: TLayout;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Rectangle2: TRectangle;
    recFundoBlack: TRectangle;
    Line1: TLine;
    Layout3: TLayout;
    Layout4: TLayout;
    lytBtnProducao: TLayout;
    recBtnPronto: TRectangle;
    lblBtnPronto: TLabel;
    speProducao: TSpeedButton;
    lytBtnEntregue: TLayout;
    Rectangle7: TRectangle;
    lblBtnEntregue: TLabel;
    speEntregue: TSpeedButton;
    lytBtnPronto: TLayout;
    Rectangle8: TRectangle;
    Label2: TLabel;
    spePronto: TSpeedButton;
    lytLeftLegenda: TLayout;
    lytRightLegenda: TLayout;
    Layout2: TLayout;
    Rectangle6: TRectangle;
    Label3: TLabel;
    gridMesas: TGridLayout;
    Button1: TButton;
    Button2: TButton;
    MobilePermissions1: TMobilePermissions;
    procedure FormCreate(Sender: TObject);
    procedure tmUpdateTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure recFundoBlackClick(Sender: TObject);
    procedure speProducaoClick(Sender: TObject);
    procedure speProntoClick(Sender: TObject);
    procedure speEntregueClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    private
      { Private declarations }
      FPedidoSelecionado: Integer;
      FItemSelecionado:   Integer;
      FItem:              Integer;

      procedure LimparPainel;
      procedure AtualizarMonitor;
      procedure MostrarFundoBlack;
      procedure OcultarFundoBlack;
      procedure MostrarPopupStatus;
      procedure OcultarPopupStatus;
    public
      { Public declarations }
      procedure OnPedidoPronto(Sender: TObject);
      procedure OnPedidoEntregue(Sender: TObject);
      procedure OnAtualizarItem(Sender: TObject);

      property PedidoSelecionado: Integer read FPedidoSelecionado write FPedidoSelecionado;
      property ItemSelecionado: Integer read FItemSelecionado write FItemSelecionado;
  end;

var
  ViewMonitorProducao: TViewMonitorProducao;

implementation

uses
  Cozinha.Components.Item001;

{$R *.fmx}


procedure TViewMonitorProducao.Button1Click(Sender: TObject);
begin
  AtualizarMonitor;
end;

procedure TViewMonitorProducao.Button2Click(Sender: TObject);
var
  LComps: TStringList;
  I:      Integer;
begin
  try
    LComps := TStringList.Create;
    for I  := 0 to Pred(ViewMonitorProducao.ComponentCount) do
      LComps.Add(ViewMonitorProducao.Components[I].Name);
  finally
    LComps.Free;
  end;
end;

procedure TViewMonitorProducao.FormCreate(Sender: TObject);
begin
  // Configura o DataSet Serialize para pegar o padrão do banco
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndNone;
  OcultarFundoBlack;
  OcultarPopupStatus;

  MobilePermissions1.Dangerous.ReadExternalStorage  := True;
  MobilePermissions1.Dangerous.WriteExternalStorage := True;
  MobilePermissions1.Standard.Internet              := True;

  MobilePermissions1.Apply;
end;

procedure TViewMonitorProducao.FormResize(Sender: TObject);
var
  LHeight: Single;
  LWidth:  Single;
  LCard:   Single;
begin
  //
  LHeight := Self.ClientHeight - lytTop.Height;
  LWidth  := (Self.ClientWidth - lytLeftContainer.Width - 10) / 5;

  gridMesas.Height := LHeight * 2;
  gridMesas.Width  := LWidth * 5 + 45;

  gridMesas.ItemHeight := LHeight / 2;
  gridMesas.ItemWidth  := LWidth;

  gridMesas.Position.X := 0;
  gridMesas.Position.Y := 0;
end;

procedure TViewMonitorProducao.FormShow(Sender: TObject);
begin
  tmUpdate.Enabled := True;
end;

procedure TViewMonitorProducao.LimparPainel;
var
  I:      Integer;
  LOwner: TComponent;
begin
  for I := Pred(gridMesas.ControlsCount) downto 0 do
  begin
    var
      LForm: TComponent := Self.FindComponent(gridMesas.Controls[I].Owner.Name);
    LOwner              := gridMesas.Controls[I].Owner;
    gridMesas.Controls[I].DisposeOf;
    LOwner.Free;
    LOwner := nil;
  end;
end;

procedure TViewMonitorProducao.MostrarFundoBlack;
begin
  recFundoBlack.Visible := True;
  recFundoBlack.BringToFront;
  recFundoBlack.AnimateFloat('OPACITY', 0.6);
end;

procedure TViewMonitorProducao.MostrarPopupStatus;
begin
  MostrarFundoBlack;
  lytStatusItem.Visible := True;
  lytStatusItem.BringToFront;
  lytStatusItem.AnimateFloat('OPACITY', 1);
end;

procedure TViewMonitorProducao.OcultarFundoBlack;
begin
  recFundoBlack.AnimateFloat('OPACITY', 0.0);
  recFundoBlack.Visible := False;
end;

procedure TViewMonitorProducao.OcultarPopupStatus;
begin
  lytStatusItem.AnimateFloat('OPACITY', 0);
  lytStatusItem.Visible := False;
  OcultarFundoBlack;
  tmUpdate.Enabled := True;
end;

procedure TViewMonitorProducao.OnAtualizarItem(Sender: TObject);
begin
  tmUpdate.Enabled   := False;
  FPedidoSelecionado := TComponentItem001(TSpeedButton(Sender).Parent.Owner.Owner.Owner).NumPedido;
  FItemSelecionado := TListBoxItem(TSpeedButton(Sender).Owner).Tag;
  MostrarPopupStatus;
  ServicePedidos.AbrirPedidosEItensPedido;
end;

procedure TViewMonitorProducao.OnPedidoEntregue(Sender: TObject);
begin
  tmUpdate.Enabled := False;
  TDialogService.MessageDialog(
    'Confirma mudança de "Status" do pedido para "Entregue"?' + #13#10 +
    'Obs. O pedido será removido desta janela.',
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    var
      LPedido: Integer;
    begin
      if AResult = mrYes then
      begin
        LPedido := TComponentItem001(TSpeedButton(Sender).Owner).NumPedido;
        ServicePedidos.AlterarStatusPedido(LPedido, 'E');
        ServicePedidos.AbrirPedidosEItensPedido;
        TComponentItem001(TSpeedButton(Sender).Owner).RemoveItem;
      end;

      tmUpdate.Enabled := True;
    end
    )
end;

procedure TViewMonitorProducao.OnPedidoPronto(Sender: TObject);
begin
  tmUpdate.Enabled := False;
  TDialogService.MessageDialog(
  'Confirma mudança de "Status" do pedido para "Pronto"?',
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo,
    0,
    procedure(const AResult: TModalResult)
    var
      LPedido: Integer;
    begin
      if AResult = mrYes then
      begin
        LPedido := TComponentItem001(TSpeedButton(Sender).Owner).NumPedido;
        ServicePedidos.AlterarStatusPedido(LPedido, 'C');
        ServicePedidos.AbrirPedidosEItensPedido;
      end;
      tmUpdate.Enabled := True;
    end
    )
end;

procedure TViewMonitorProducao.recFundoBlackClick(Sender: TObject);
begin
  OcultarFundoBlack;
  OcultarPopupStatus;
end;

procedure TViewMonitorProducao.speEntregueClick(Sender: TObject);
begin
  ServicePedidos.AlterarStatusItem(FPedidoSelecionado, FItemSelecionado, 'E');
  OcultarPopupStatus;
end;

procedure TViewMonitorProducao.speProducaoClick(Sender: TObject);
begin
  ServicePedidos.AlterarStatusItem(FPedidoSelecionado, FItemSelecionado, 'P');
  OcultarPopupStatus;
end;

procedure TViewMonitorProducao.speProntoClick(Sender: TObject);
begin
  ServicePedidos.AlterarStatusItem(FPedidoSelecionado, FItemSelecionado, 'C');
  OcultarPopupStatus;
end;

procedure TViewMonitorProducao.tmUpdateTimer(Sender: TObject);
begin
  if not (lytStatusItem.Visible) then
    AtualizarMonitor;
end;

procedure TViewMonitorProducao.AtualizarMonitor;
var
  LOrdem: Integer;
begin
  LimparPainel;
  LOrdem := 0;
  ServicePedidos.AbrirPedidosEItensPedido;
  ServicePedidos.memPedidos.First;

  ServicePedidos.memPedidos.DisableControls;
  ServicePedidos.memItensPedido.DisableControls;
  while not ServicePedidos.memPedidos.EOF do
  begin
    ServicePedidos.memItensPedido.Filtered := False;
    ServicePedidos.memItensPedido.Filter   :=
      Format('ID_PEDIDO=%d', [ServicePedidos.memPedidosID.AsInteger]);
    ServicePedidos.memItensPedido.Filtered := True;

    if (ServicePedidos.memItensPedido.IsEmpty) then
    begin
      ServicePedidos.memPedidos.Next;
      continue
    end
    else
    begin
      Inc(LOrdem);
      TThread.Synchronize(
      TThread.CurrentThread,
        procedure()
        begin
          gridMesas
            .AddObject(
            TComponentItem001
              .Create(Self)
              .Mesa(ServicePedidos.memPedidosID_MESA.AsInteger)
              .Pedido(ServicePedidos.memPedidosID.AsInteger)
              .Ordem(LOrdem)
              .Itens(ServicePedidos.memItensPedido.ToJSONArray, OnAtualizarItem)
              .OnPedidoPronto(OnPedidoPronto)
              .OnPedidoEntregue(OnPedidoEntregue)
              .VertScrollBox(gridMesas)
              .Component
            );
        end
        );
      ServicePedidos.memPedidos.Next;
    end;
  end;
  ServicePedidos.memPedidos.EnableControls;
  ServicePedidos.memItensPedido.EnableControls;
end;

end.
