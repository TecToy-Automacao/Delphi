unit Service.Geral;

interface

uses
  RESTRequest4D,

  Data.DB,

  Dataset.Serialize,

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

  System.Classes,
  System.JSON,
  System.SysUtils;

type
  TServiceGeral = class(TServiceBase)
    memPedidos: TFDMemTable;
    memPedidosID: TIntegerField;
    memPedidosNOME_CLIENTE: TStringField;
    memPedidosID_GARCOM: TIntegerField;
    memPedidosID_MESA: TIntegerField;
    memPedidosTOTAL_PEDIDO: TFloatField;
    memItensPedido: TFDMemTable;
    memItensPedidoID: TIntegerField;
    memItensPedidoID_PEDIDO: TIntegerField;
    memItensPedidoQTDE: TIntegerField;
    memItensPedidoID_PRODUTO: TIntegerField;
    memItensPedidoID_COMANDA: TIntegerField;
    memItensPedidoID_MESA: TIntegerField;
    memItensPedidoVALOR_UNITARIO: TFloatField;
    memItensPedidoNOME: TStringField;
    memItensPedidoTOTAL_ITEM: TFloatField;
    MemProdutos: TFDMemTable;
    MemProdutosID: TIntegerField;
    MemProdutosNOME: TStringField;
    MemProdutosDESCRICAO: TStringField;
    MemProdutosVLR_UNITARIO: TFloatField;
    MemProdutosCODBAR: TStringField;
    procedure memPedidosTOTAL_PEDIDOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure MemProdutosVLR_UNITARIOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure memItensPedidoVALOR_UNITARIOGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure memItensPedidoTOTAL_ITEMGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ResetToDefaults;
    procedure BuscarComanda(AID_Comanda: Integer);
    procedure BuscarProduto(AProduto: string; ACodBarra: Boolean = False);
    procedure AddItem(APedido, AID_Produto, AID_COMANDA, AQtde : Integer);
    procedure RemoveItem(APedido, AItem: Integer);
  end;

var
  ServiceGeral: TServiceGeral;

implementation

uses
  PDV.Consts;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TServiceGeral.AddItem(APedido, AID_Produto, AID_COMANDA, AQTDE: Integer);
var
  LResponse : IResponse;
  LBody     : TJSONObject;
begin
  try
    LBody := TJSONObject.Create;
    LBody.AddPair('ID', TJSONNumber.Create(-1));
    LBody.AddPair('ID_PEDIDO', TJSONNumber.Create(APedido));
    LBody.AddPair('QTDE', TJSONNumber.Create(AQtde));
    LBody.AddPair('ID_PRODUTO', TJSONNumber.Create(AID_Produto));
    LBody.AddPair('ID_COMANDA', TJSONNumber.Create(AID_COMANDA));
    LBody.AddPair('STATUS', 'E');

    LResponse :=
      TRequest.New.BaseURL(Format('%s:%s/', [C_BaseUrl, C_Porta]))
        .Resource(Format('pedidos/%s/itens', [APedido.ToString]))
        .BasicAuthentication(C_Usuario, C_Senha)
        .ContentType('application/json')
        .AddBody(LBody)
        .Post;

    if (LResponse.StatusCode = 200) and (not(LResponse.Content.Equals(Emptystr)))
    then
    begin

    end;
  except on E:Exception do
    begin

    end;
  end;
end;

procedure TServiceGeral.BuscarComanda(AID_Comanda: Integer);
var
  LResponse         : IResponse;
  LContent          : TJSONArray;
  LPedido           : TJSONObject;
  LItens            : TJSONArray;
  LValues           : TJSONValue;

  //Itens
  LId_Item          : Integer;
  LId_Pedido        : Integer;
  LQtde             : Integer;
  LID_Produto       : Integer;
  LNome_Produto     : string;
  LID_Mesa          : Integer;
  L_Vlr_Unitario    : Double;
  L_VlrTotal_Item   : Double;

  //Pedido
  LNome_Cliente     : string;
  LID_Garcom        : integer;
  LNome_Garcom      : string;
  L_Vlr_TotalPedido : Double;
begin
  try
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
      TRequest.New.BaseURL(Format('%s:%s/', [C_BaseUrl, C_Porta]))
        .Resource(Format('pedidos/comanda/%s', [AID_Comanda.ToString]))
        .BasicAuthentication(C_Usuario, C_Senha)
        .ContentType('application/json')
        .Get;

    if (LResponse.StatusCode = 200) and (not(LResponse.Content.Equals(Emptystr)))
    then
    begin
      LContent := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;
      L_Vlr_TotalPedido := 0;
      for var I: Integer := 0 to Pred(LContent.Count) do
      begin
        LPedido := TJSONObject(LContent.Items[I]);
        LItens  := TJSONArray(LContent.Items[I].FindValue('itens'));
        //Adiciona os itens da comanda

        for LValues in LItens  do
        begin
          memItensPedido.Append;

          LValues.TryGetValue<integer>('ID', LId_Item);
          LValues.TryGetValue<integer>('ID_PEDIDO', LId_Pedido);
          LValues.TryGetValue<integer>('QTDE', LQtde);
          LValues.TryGetValue<integer>('ID_PRODUTO', LID_Produto);
          LValues.TryGetValue<integer>('ID_MESA', LID_Mesa);
          LValues.TryGetValue<double>('VLR_UNITARIO', L_Vlr_Unitario);
          LValues.TryGetValue<string>('NOME', LNome_Produto);
          LValues.TryGetValue<double>('TOTAL_ITEM', L_VlrTotal_Item);

          L_Vlr_TotalPedido := L_Vlr_TotalPedido + L_VlrTotal_Item;

          memItensPedido.FieldByName('ID').AsInteger := LId_Item;
          memItensPedido.FieldByName('ID_PEDIDO').AsInteger := LId_Pedido;
          memItensPedido.FieldByName('QTDE').AsInteger := LQtde;
          memItensPedido.FieldByName('ID_PRODUTO').AsInteger := LID_Produto;
          memItensPedido.FieldByName('ID_COMANDA').AsInteger := AID_Comanda; //Vem do parâmetro lido
          memItensPedido.FieldByName('ID_MESA').AsInteger := LID_Mesa;
          memItensPedido.FieldByName('VALOR_UNITARIO').AsFloat := L_Vlr_Unitario;
          memItensPedido.FieldByName('NOME').AsString := LNome_Produto;
          memItensPedido.FieldByName('TOTAL_ITEM').AsFloat := L_VlrTotal_Item;
          memItensPedido.Post;
        end;

        memPedidos.Append;
        LPedido.TryGetValue<Integer>('ID', LId_Pedido);
        LPedido.TryGetValue<string>('NOME_CLIENTE', LNome_Cliente);
        LPedido.TryGetValue<Integer>('ID_GARCOM', LID_Garcom);
        LPedido.TryGetValue<Integer>('ID_MESA', LID_Mesa);
        LPedido.TryGetValue<Integer>('ID_COMANDA', AID_COMANDA);

        memPedidos.FieldByName('ID').AsInteger          := LId_Pedido;
        memPedidos.FieldByName('NOME_CLIENTE').AsString := LNome_Cliente;
        memPedidos.FieldByName('ID_GARCOM').AsInteger   := LID_Garcom;
        memPedidos.FieldByName('ID_MESA').AsInteger     := LID_Mesa;
        memPedidos.FieldByName('TOTAL_PEDIDO').AsFloat  := L_Vlr_TotalPedido;

        memPedidos.Post;
      end;
    end;

    memPedidos.EnableControls;
    memItensPedido.EnableControls;
  except on E:Exception do
    begin

    end;
  end;
end;

procedure TServiceGeral.BuscarProduto(AProduto: string; ACodBarra: Boolean = False);
var
  LResponse         : IResponse;
  LContent          : TJSONValue;
  LResource         : String;
begin
  try
    if ACodBarra
    then LResource := Format('produtos/codbarras/%s', [AProduto])
    else LResource := Format('produtos/%s', [AProduto]);

    if not MemProdutos.Active then
      MemProdutos.Active := True;
    MemProdutos.EmptyDataSet;
    MemProdutos.Filter       := EmptyStr;

    MemProdutos.DisableControls;

    LResponse :=
      TRequest.New.BaseURL(Format('%s:%s/', [C_BaseUrl, C_Porta]))
        .Resource(LResource)
        .BasicAuthentication(C_Usuario, C_Senha)
        .ContentType('application/json')
        .Get;

    if (LResponse.StatusCode = 200) and (not(LResponse.Content.Equals(Emptystr)))
    then
    begin
      MemProdutos.Append;
      LContent := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONValue;
      var LID : Integer;
      var LNome : string;
      var LDescricao: string;
      var LVlr_Unitario : Double;
      var LCODBAR: string;

      LContent.TryGetValue<integer>('ID', LID);
      LContent.TryGetValue<string>('NOME', LNome);
      LContent.TryGetValue<string>('DESCRICAO', LDescricao);
      LContent.TryGetValue<double>('VLR_UNITARIO', LVlr_Unitario);
      LContent.TryGetValue<string>('CODBAR', LCODBAR);

      MemProdutos.FieldByName('ID').AsInteger := LID;
      MemProdutos.FieldByName('NOME').AsString := LNome;
      MemProdutos.FieldByName('DESCRICAO').AsString := LDescricao;
      MemProdutos.FieldByName('VLR_UNITARIO').AsFloat := LVlr_Unitario;
      MemProdutos.FieldByName('CODBAR').AsString := LCODBAR;

      MemProdutos.Post;
      //MemProdutos.LoadFromJSON(LResponse.Content);
      //LContent := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;
    end;

    MemProdutos.EnableControls;
  except on E:Exception do
    begin

    end;
  end;
end;

procedure TServiceGeral.memItensPedidoTOTAL_ITEMGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := FormatFloat('###,##0.00', Sender.Value);
end;

procedure TServiceGeral.memItensPedidoVALOR_UNITARIOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := FormatFloat('###,##0.00', Sender.Value);
end;


procedure TServiceGeral.memPedidosTOTAL_PEDIDOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := FormatFloat('###,##0.00', Sender.Value);
end;

procedure TServiceGeral.MemProdutosVLR_UNITARIOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := FormatFloat('###,##0.00', Sender.Value);
end;

procedure TServiceGeral.RemoveItem(APedido, AItem: Integer);
var
  LResponse : IResponse;
begin
  try
    LResponse :=
      TRequest.New.BaseURL(Format('%s:%s/', [C_BaseUrl, C_Porta]))
        .Resource(Format('pedidos/%s/itens/%s', [APedido.ToString, AItem.ToString]))
        .BasicAuthentication(C_Usuario, C_Senha)
        .ContentType('application/json')
        .Delete;

  except on E:Exception do
    begin

    end;
  end;
end;

procedure TServiceGeral.ResetToDefaults;
begin
  if not memPedidos.Active then
    memPedidos.Active := True;

  if not memPedidos.IsEmpty then
    memPedidos.EmptyDataSet;

  memPedidos.Filter       := EmptyStr;
  memItensPedido.Filter   := EmptyStr;

  memPedidos.Filtered     := False;
  memItensPedido.Filtered := False;

  if not memItensPedido.Active then
    memItensPedido.Active := True;

  if not memItensPedido.IsEmpty then
    memItensPedido.EmptyDataSet;
end;

end.
