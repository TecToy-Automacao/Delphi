unit Service.Pedidos;

interface

uses
  RESTRequest4D,
  DataSet.Serialize,

  Data.DB,

  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,

  Service.Base,

  System.Json,
  System.Classes,
  System.SysUtils;

type
  TServicePedidos = class(TServiceBase)
    memPedidos: TFDMemTable;
    memItensPedido: TFDMemTable;
    memPedidosID: TIntegerField;
    memPedidosNOME_CLIENTE: TStringField;
    memPedidosVALOR_TOTAL: TFloatField;
    memPedidosSTATUS: TStringField;
    memPedidosID_GARCOM: TIntegerField;
    memPedidosID_MESA: TIntegerField;
    memItensPedidoID: TIntegerField;
    memItensPedidoID_PEDIDO: TIntegerField;
    memItensPedidoQTDE: TIntegerField;
    memItensPedidoID_PRODUTO: TIntegerField;
    memItensPedidoNOME: TStringField;
    memItensPedidoDESCRICAO: TStringField;
    memItensPedidoVALOR_TOTAL: TFloatField;
    memItensPedidoSTATUS: TStringField;
    memItensPedidoID_COMANDA: TIntegerField;
    private
      { Private declarations }
      FPedidoSelecionadoID: Integer;
    public
      { Public declarations }

      function SyncPedido: Boolean;
      function SyncItensPedido(APedido: Integer): Boolean;
      function DeletePedido(APedido: Integer): Boolean;
      function DeleteItemPedido(APedido, AItemPedido: Integer): Boolean;
      procedure AbrirPedidos(const AMesa: Integer = 0);
      procedure AbrirItensPedido(const APedido: Integer);

      property PedidoSelecionadoID: Integer read FPedidoSelecionadoID write FPedidoSelecionadoID;
  end;

var
  ServicePedidos: TServicePedidos;

implementation

uses
  Comanda.Lib;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServicePedidos }

procedure TServicePedidos.AbrirItensPedido(const APedido: Integer);
var
  LResponse: IResponse;
  LResposta: TJSONArray;
  LValues:   TJSONValue;
begin
  // Itens do Pedido
  memItensPedido.DisableControls;
  memItensPedido.Filtered := False;
  memItensPedido.Filter   := EmptyStr;

  if not memItensPedido.Active then
    memItensPedido.Active := True;
  if not memItensPedido.IsEmpty then
    memItensPedido.EmptyDataSet;

  LResponse :=
    TRequest.New.BaseUrl(TLib.BaseUrl)
    .Resource(Format('pedidos/%s/itens', [APedido.ToString]))
    .ContentType('application/json')
    .Get;

  LResposta := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

  if (LResponse.StatusCode = 200) and not(LResponse.Content.Equals(EmptyStr)) then
  begin
    for LValues in LResposta do
    begin
      memItensPedido.Append;
      memItensPedido.FieldByName('ID').AsInteger         := LValues.GetValue<Integer>('ID');
      memItensPedido.FieldByName('ID_PEDIDO').AsInteger  := LValues.GetValue<Integer>('ID_PEDIDO');
      memItensPedido.FieldByName('QTDE').AsInteger       := LValues.GetValue<Integer>('QTDE');
      memItensPedido.FieldByName('ID_PRODUTO').AsInteger := LValues.GetValue<Integer>('ID_PRODUTO');
      memItensPedido.FieldByName('NOME').AsString        := LValues.GetValue<string>('NOME');
      memItensPedido.FieldByName('DESCRICAO').AsString   := LValues.GetValue<string>('DESCRICAO');
      memItensPedido.FieldByName('VALOR_TOTAL').AsFloat  := LValues.GetValue<double>('VALOR_TOTAL');
      memItensPedido.FieldByName('ID_COMANDA').AsInteger := LValues.GetValue<integer>('ID_COMANDA');

      memItensPedido.Post;
    end;
  end;

  memItensPedido.EnableControls;
end;

procedure TServicePedidos.AbrirPedidos(const AMesa: Integer);
var
  LResponse: IResponse;
  LResource: string;

  LResposta: TJSONArray;
  LValues:   TJSONValue;
begin
  // Pedidos
  memPedidos.DisableControls;
  memPedidos.Filtered := False;
  memPedidos.Filter   := EmptyStr;

  if not memPedidos.Active then
    memPedidos.Active := True;

  if not memPedidos.IsEmpty then
    memPedidos.EmptyDataSet;

  LResource := 'pedidos';
  if AMesa > 0 then
    LResource := Format('pedidos/mesa/%s', [AMesa.ToString]);

  LResponse :=
    TRequest.New.BaseUrl(TLib.BaseUrl)
    .Resource(LResource)
    .ContentType('application/json')
    .Get;

  LResposta := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

  if (LResponse.StatusCode = 200) and not(LResponse.Content.Equals(EmptyStr)) then
  begin
    for LValues in LResposta do
    begin
      memPedidos.Append;
      memPedidos.FieldByName('ID').AsInteger          := LValues.GetValue<Integer>('ID');
      memPedidos.FieldByName('VALOR_TOTAL').AsFloat   := LValues.GetValue<double>('VALOR_TOTAL');
      memPedidos.FieldByName('STATUS').AsString       := LValues.GetValue<string>('STATUS');
      memPedidos.FieldByName('ID_GARCOM').AsInteger   := LValues.GetValue<Integer>('ID_GARCOM');
      memPedidos.FieldByName('ID_MESA').AsInteger     := LValues.GetValue<Integer>('ID_MESA');
      memPedidos.Post;
    end;
  end;
end;

function TServicePedidos.DeleteItemPedido(APedido, AItemPedido: Integer): Boolean;
var
  LResponse: IResponse;
  LResource: string;
begin
  LResource := 'pedidos/%s/itens/%s';
  try
    LResponse :=
      TRequest.New.BaseUrl(TLib.BaseUrl)
      .Resource(Format(LResource, [APedido.ToString, AItemPedido.ToString]))
      .ContentType('application/json')
      .Delete;

    Result := LResponse.StatusCode = 204;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TServicePedidos.DeletePedido(APedido: Integer): Boolean;
var
  LResponse: IResponse;
begin
  try
    LResponse :=
      TRequest.New.BaseUrl(TLib.BaseUrl)
      .Resource(Format('pedidos/%s', [APedido.ToString]))
      .ContentType('application/json')
      .Delete;

    Result := LResponse.StatusCode = 204;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TServicePedidos.SyncItensPedido(APedido: Integer): Boolean;
var
  LJSONREsposta: TJSONValue;
begin
  try
    TDataSetSerializeConfig.GetInstance.Export.ExportNullValues := False;

    if memItensPedido.FieldByName('ID').AsInteger = -1 then
      // Novo Item de Pedido
      Send(Format('pedidos/%s/itens', [PedidoSelecionadoID.ToString]), memItensPedido.ToJSONObject.ToString, LJSONREsposta)
    else
    begin
      var
        LIDItem: Integer := memItensPedido.FieldByName('ID').AsInteger;
      Send(
        LIDItem,
        Format('pedidos/%s/itens/', [PedidoSelecionadoID.ToString]),
        memItensPedido.ToJSONObject.ToString); // Altera o Item Pedido Atual
    end;

    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao atualizar o servidor.');
    end;
  end;

end;

function TServicePedidos.SyncPedido: Boolean;
var
  LIDGerado:     Integer;
  LJSONREsposta: TJSONValue;
begin
  try
    TDataSetSerializeConfig.GetInstance.Export.ExportNullValues := False;

    LIDGerado := 0;
    if memPedidos.FieldByName('ID').AsInteger = -1 then
    begin
      // Novo Pedido
      Send('pedidos', memPedidos.ToJSONObject.ToString, LJSONREsposta);
      LJSONREsposta.TryGetValue<Integer>('ID', LIDGerado);
      if LIDGerado > 0 then
        PedidoSelecionadoID := LIDGerado;
    end
    else
      Send(PedidoSelecionadoID, 'pedidos', memPedidos.ToJSONObject.ToString); // Altera o Pedido Atual

    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao atualizar o servidor.');
    end;
  end;
end;

end.
