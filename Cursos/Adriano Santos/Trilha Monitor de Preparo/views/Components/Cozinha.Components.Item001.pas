unit Cozinha.Components.Item001;

interface

uses
  CustomThread,

  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Effects,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,

  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TComponentItem001 = class(TForm)
    lytMesa: TLayout;
    recPrincipal: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    lblOrdem: TLabel;
    lblPedNum: TLabel;
    Layout5: TLayout;
    gridBotoes: TGridLayout;
    lytBtnPronto: TLayout;
    recBtnPronto: TRectangle;
    lblBtnPronto: TLabel;
    spePronto: TSpeedButton;
    shwBtnPronto: TShadowEffect;
    Layout6: TLayout;
    Rectangle4: TRectangle;
    lblBtnEntregue: TLabel;
    speEntregue: TSpeedButton;
    ShadowEffect1: TShadowEffect;
    lstListaItens: TListBox;
    lstItemBase: TListBoxItem;
    recBaseItem: TRectangle;
    Layout4: TLayout;
    lytTopProduto: TLayout;
    lytNomeEQtde: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Path2: TPath;
    Rectangle5: TRectangle;
    lblQuantidade: TLabel;
    lblProduto: TLabel;
    lblNome: TLabel;
    lblTitMesa: TLabel;
    ShadowEffect2: TShadowEffect;
    lytObs: TLayout;
    lblObs: TLabel;
    Layout7: TLayout;
    recStatusItem: TRectangle;
    pthEditarItem: TPath;
    speClickItem: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    private
      { Private declarations }
      FNumPedido : Integer;
      FNumMesa   : Integer;
      FIndex     : TComponentItem001;
      FContainer : TGridLayout;
      FItem      : Integer;
      procedure AddEvent(AControl: TControl; AEvent: TNotifyEvent);
      function GetNumMesa: Integer;
      function GetNumPedido: Integer;
    public
      { Public declarations }
      function Component: TFMXObject;
      function Pedido(AValue: Integer): TComponentItem001;
      function Mesa(AValue: Integer): TComponentItem001;
      function Ordem(AValue: Integer): TComponentItem001;
      function Item(AItem: Integer): TComponentItem001;
      function Itens(AValue: TJSONArray; AOnAtualizarItem: TNotifyEvent = nil): TComponentItem001;
      function OnPedidoPronto(AOnPedidoPronto: TNotifyEvent): TComponentItem001;
      function OnPedidoEntregue(AOnPedidoEntregue: TNotifyEvent): TComponentItem001;
      function VertScrollBox(AValue: TGridLayout): TComponentItem001;
      procedure RemoveItem;

      property NumPedido : Integer read GetNumPedido write FNumPedido;
      property NumMesa   : Integer read GetNumMesa   write FNumMesa;
  end;

var
  ComponentItem001: TComponentItem001;

implementation

{$R *.fmx}

procedure TComponentItem001.FormCreate(Sender: TObject);
begin

end;

{ TcompMesa }

procedure TComponentItem001.AddEvent(AControl: TControl; AEvent: TNotifyEvent);
var
   I : Integer;
begin
  for I := 0 to Pred(AControl.ControlsCount) do
  begin
    if AControl.Controls[I] is TSpeedButton
    then TSpeedButton(AControl.Controls[I]).OnClick := AEvent
    else AddEvent(AControl.Controls[I], AEvent);
  end;
end;

function TComponentItem001.Component: TFMXObject;
begin

  Result := lytMesa;
  FIndex := Self;
end;

function TComponentItem001.GetNumMesa: Integer;
begin
  Result := FNumMesa;
end;

function TComponentItem001.GetNumPedido: Integer;
begin
  Result := FNumPedido;
end;

function TComponentItem001.Item(AItem: Integer): TComponentItem001;
begin
  Result := Self;
  FItem := AItem;
end;

function TComponentItem001.Itens(AValue: TJSONArray; AOnAtualizarItem: TNotifyEvent = nil): TComponentItem001;
var
  LThread : TThread;
begin
  Result := Self;

  LThread :=
    TThread.CreateAnonymousThread(
      procedure ()
      var
        LFrame : TListBoxItem;
        LItem  : TJSONValue;
        LCount : Integer;
        LObs   : String;
      begin
        lstListaItens.Visible := False;
        lstItemBase.Visible   := False;
        LCount                := 0;
        lstListaItens.BeginUpdate;
        TThread.Synchronize(
          TThread.CurrentThread,
          procedure ()
          begin
            gridBotoes.ItemWidth := (lytMesa.Width / 2) - 10;
          end
        );

        for LItem in AValue do
        begin
          TThread.Synchronize(
            TThread.CurrentThread,
            procedure ()
            var
              LID_Item: Integer;
            begin
              Randomize;

              LID_Item := LItem.GetValue<integer>('ID');
              lblProduto.Text        := LItem.GetValue<string>('NOME');
              lblQuantidade.Text     := Format('%2.0d', [LItem.GetValue<integer>('QTDE')]);
              LItem.TryGetValue<string>('OBS', LObs);
              lblObs.Text            := LObs;

              if Odd(LCount)
              then recBaseItem.Fill.Color := $FFECF1F2
              else recBaseItem.Fill.Color := $FFDAE7EA;

              if LItem.GetValue<string>('STATUS').Equals('A') then
                recStatusItem.Fill.Color := $FFB10000                           //Vermelho - Aguardando
              else if LItem.GetValue<string>('STATUS').Equals('P') then
                recStatusItem.Fill.Color := $FFFEC83C                           //Laranja - Em produção
              else if LItem.GetValue<string>('STATUS').Equals('C') then
                recStatusItem.Fill.Color := $FF7766BE                           //Roxo - Pronto
              else if LItem.GetValue<string>('STATUS').Equals('E') then
                recStatusItem.Fill.Color := $FF00B147;                          //Verde - Entregue

              LFrame             := TListBoxItem(lstItemBase.Clone(lstListaItens));
              LFrame.Name        := Format('frame%6.6d', [LItem.GetValue<integer>('ID')]);
              LFrame.Parent      := lstListaItens;
              LFrame.Tag         := LID_Item;
              LFrame.BringToFront;
              LFrame.Visible     := True;

              //Se foi passado um evento, atribui ao SpeedButton dentro do Card
              if Assigned(AOnAtualizarItem) then
                AddEvent(LFrame, AOnAtualizarItem);


            end
          );
          Inc(LCount);
        end;
        lstListaItens.EndUpdate;
        lstListaItens.Visible := True;
      end
    );
  LThread.Start;
end;

function TComponentItem001.Mesa(AValue: Integer): TComponentItem001;
begin
  Result := Self;
  lblTitMesa.Text := Format('Mesa %s', [AValue.ToString]);
  FNumMesa := AValue;
end;

function TComponentItem001.OnPedidoEntregue(
  AOnPedidoEntregue: TNotifyEvent): TComponentItem001;
begin
  Result := Self;
  speEntregue.OnClick := AOnPedidoEntregue;
  //RemoveItem;
end;

function TComponentItem001.OnPedidoPronto(
  AOnPedidoPronto: TNotifyEvent): TComponentItem001;
begin
  Result := Self;
  spePronto.OnClick := AOnPedidoPronto;
end;

function TComponentItem001.Ordem(AValue: Integer): TComponentItem001;
begin
  Result := Self;
  lblOrdem.Text := Format('%do.', [AValue]);
end;

function TComponentItem001.Pedido(AValue: Integer): TComponentItem001;
begin
  Result := Self;
  lblPedNum.Text := Format('Ped %3.0d', [AValue]);
  FNumPedido := AValue;
end;

procedure TComponentItem001.RemoveItem;
begin
  FContainer.RemoveObject(FIndex);
  FIndex.DisposeOf;
end;

function TComponentItem001.VertScrollBox(AValue: TGridLayout): TComponentItem001;
begin
  Result := Self;
  FContainer := AValue;
end;

end.















