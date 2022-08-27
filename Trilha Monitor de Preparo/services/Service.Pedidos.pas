unit Service.Pedidos;

interface

uses
  RESTRequest4D,

  Data.DB,

  DataSet.Serialize,
  DataSet.Serialize.Config,

  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,

  REST.Json,

  Service.Base,

  System.Classes,
  System.Json,
  System.SysUtils,
  System.Variants;

type
  TServicePedidos = class(TServiceBase)
    memPedidos: TFDMemTable;
    memItensPedido: TFDMemTable;
    memItensPedidoID: TIntegerField;
    memItensPedidoID_PEDIDO: TIntegerField;
    memItensPedidoQTDE: TIntegerField;
    memItensPedidoID_PRODUTO: TIntegerField;
    memItensPedidoNOME: TStringField;
    memItensPedidoDESCRICAO: TStringField;
    memItensPedidoVALOR_TOTAL: TFloatField;
    DtsMaster: TDataSource;
    memPedidosID: TIntegerField;
    memPedidosNOME_CLIENTE: TStringField;
    memPedidosVALOR_TOTAL: TFloatField;
    memPedidosSTATUS: TStringField;
    memPedidosID_GARCOM: TIntegerField;
    memPedidosID_MESA: TIntegerField;
    memItensPedidoSTATUS: TStringField;
    memItensPedidoID_COMANDA: TIntegerField;
    private
      { Private declarations }
    public
      { Public declarations }
      procedure AbrirPedidosEItensPedido;
      procedure AlterarStatusItem(APedido, AItem: Integer; AStatus: string);
      procedure AlterarStatusPedido(APedido: Integer; AStatus: string);
  end;

var
  ServicePedidos: TServicePedidos;

implementation

uses
  Cozinha.Consts;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServicePedidos }

procedure TServicePedidos.AbrirPedidosEItensPedido;
var
  LResponse     : IResponse;
  LContent      : TJSONArray;
  LPedido       : TJSONObject;
  LItens        : TJSONArray;

  LID           :Integer;
  LNOME_CLIENTE :string;
  LVALOR_TOTAL  :Double;
  LSTATUS       :string;
  LID_GARCOM    :Integer;
  LID_MESA      :Integer;
  LID_COMANDA   :Integer;

begin
  if not memPedidos.Active then
    memPedidos.Active := True;
  memPedidos.EmptyDataSet;

  memPedidos.Filter       := EmptyStr;
  memItensPedido.Filter   := EmptyStr;

  memPedidos.Filtered     := False;
  memItensPedido.Filtered := False;

  if not memItensPedido.Active then
    memItensPedido.Active := True;

   memItensPedido.EmptyDataSet;

  memPedidos.DisableControls;
  memItensPedido.DisableControls;

  LResponse :=
    TRequest.New.BaseURL(Format('%s:%s/', [C_BaseURL, C_Porta]))
      .Resource('pedidos/producao')
      .BasicAuthentication('admin', '123456')
      .ContentType('application/json')
      .Get;

  if (LResponse.StatusCode = 200) and (not(LResponse.Content.Equals(Emptystr)))
  then
  begin
    LContent := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;
    for var I: Integer := 0 to Pred(LContent.Count) do
    begin
      LPedido := TJSONObject(LContent.Items[I]);
      LItens  := TJSONArray(LContent.Items[I].FindValue('itens'));
      LPedido.RemovePair('itens');
      memItensPedido.LoadFromJSON(LItens.ToString);

      memPedidos.Append;
      LPedido.TryGetValue<Integer>('ID', LID);
      LPedido.TryGetValue<string>('NOME_CLIENTE', LNOME_CLIENTE);
      LPedido.TryGetValue<Double>('VALOR_TOTAL', LVALOR_TOTAL);
      LPedido.TryGetValue<string>('STATUS', LSTATUS);
      LPedido.TryGetValue<Integer>('ID_GARCOM', LID_GARCOM);
      LPedido.TryGetValue<Integer>('ID_MESA', LID_MESA);

      memPedidos.FieldByName('ID').AsInteger          := LID;
      memPedidos.FieldByName('NOME_CLIENTE').AsString := LNOME_CLIENTE;
      memPedidos.FieldByName('VALOR_TOTAL').AsFloat   := LVALOR_TOTAL;
      memPedidos.FieldByName('STATUS').AsString       := LSTATUS;
      memPedidos.FieldByName('ID_GARCOM').AsInteger   := LID_GARCOM;
      memPedidos.FieldByName('ID_MESA').AsInteger     := LID_MESA;

      memPedidos.Post;
    end;
  end;

  memPedidos.EnableControls;
  memItensPedido.EnableControls;
end;

procedure TServicePedidos.AlterarStatusItem(APedido, AItem: Integer;
  AStatus: string);
var
  LResponse: IResponse;
begin
  memItensPedido.Filtered := False;
  memItensPedido.Filter   := Format('(ID=%d) AND (ID_PEDIDO=%d)', [AItem, APedido]);
  memItensPedido.Filtered := True;

  if not (memItensPedido.IsEmpty) then
  begin
    memItensPedido.Edit;
    memItensPedido.FieldByName('STATUS').AsString := AStatus;
    memItensPedido.Post;

    LResponse :=
      TRequest.New.BaseURL(Format('%s:%s/', [C_BaseURL, C_Porta]))
        .Resource(Format('pedidos/%s/itens/%s', [APedido.ToString, AItem.ToString]))
        .BasicAuthentication(C_Usuario, C_Senha)
        .ContentType('application/json')
        .AddBody(memItensPedido.ToJSONObject)
        .Put;
  end;
end;

procedure TServicePedidos.AlterarStatusPedido(APedido: Integer;
  AStatus: string);
var
  LResponse: IResponse;
begin
  memPedidos.Filtered := False;
  memPedidos.Filter   := Format('ID=%d', [APedido]);
  memPedidos.Filtered := True;

  TDataSetSerializeConfig.GetInstance.Export.ExportNullValues := False;

  if not (memPedidos.IsEmpty) then
  begin
    memPedidos.Edit;
    memPedidos.FieldByName('STATUS').AsString := AStatus;
    memPedidos.Post;

    LResponse :=
      TRequest.New.BaseURL(Format('%s:%s/', [C_BaseURL, C_Porta]))
        .Resource(Format('pedidos/%s', [APedido.ToString]))
        .BasicAuthentication(C_Usuario, C_Senha)
        .ContentType('application/json')
        .AddBody(memPedidos.ToJSONObject)
        .Put;
  end;

end;

end.
