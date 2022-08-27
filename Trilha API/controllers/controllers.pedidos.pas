unit controllers.pedidos;

interface

procedure Registry;

implementation

uses
  Horse,

  ADRConn.Model.Factory,
  ADRConn.Model.Interfaces,

  DAO.Pedidos,

  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils;

procedure DoList(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : TJSONArray;
begin
  LConn := TADRConnModelFactory.GetConnectionIniFile();
  LConn.Connect;
  LDAO := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.List;
    if LResult.Count > 0 then
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.OK)
    else
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.NotFound)
  finally
    LDao.Free;
  end;
end;

procedure DoListPedidosProducao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : TJSONArray;
begin
  LConn := TADRConnModelFactory.GetConnectionIniFile();
  LConn.Connect;
  LDAO := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.ListPedidosProducao;
    if LResult.Count > 0 then
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.OK)
    else
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.NotFound)
  finally
    LDao.Free;
  end;
end;

procedure DoFind(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LID     : Integer;
  LResult : TJSONObject;
begin
  if not TryStrToInt(Req.Params['id'] , LID) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  LConn := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.Find(LID);
    if LResult.Count > 0 then
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.OK)
    else
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.NotFound);
  finally
    LDao.Free;
  end;

end;

procedure DoPedidoMesa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LIDMesa : Integer;
  LResult : TJSONArray;
begin
  if not TryStrToInt(Req.Params['idmesa'] , LIDMesa) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  LConn := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.PedidoMesa(LIDMesa);
    if LResult.Count > 0 then
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.OK)
    else
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.NotFound);
  finally
    LDao.Free;
  end;

end;

procedure DoPedidoComanda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO        : TADRConnDAOPedido;
  LConn       : IADRConnection;
  LIDComanda  : Integer;
  LResult     : TJSONArray;
begin
  if not TryStrToInt(Req.Params['idcomanda'] , LIDComanda) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  LConn := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.PedidoComanda(LIDComanda);
    if LResult.Count > 0 then
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.OK)
    else
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.NotFound);
  finally
    LDao.Free;
  end;

end;

procedure DoInsert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : TJSONObject;
  LID     : Integer;
begin
  //Testamos se recebemos um JSON no Body
  if Req.Body.IsEmpty then
    raise Exception.Create('Corpo da requisição inválido. Envie um JSONArray com os dados a serem inseridos.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO   := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.Insert(Req.Body);
    if LResult.Count > 0 then
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.Created)
    else
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.NoContent);
  finally
    LDao.Free;
  end;

end;

procedure DoUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : TJSONObject;
  LID     : Integer;
begin
  if not TryStrToInt(Req.Params['id'] , LID) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  //Testamos se recebemos um JSON no Body
  if Req.Body.IsEmpty then
    raise Exception.Create('Corpo da requisição inválido. Envie um JSONArray com os dados a serem inseridos.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO   := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.Update(LID, Req.Body);
    if LResult.Count > 0 then
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.Created)
    else
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.NoContent);
  finally
    LDao.Free;
  end;

end;

procedure DoDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : Boolean;
  LID     : Integer;
begin
  if not TryStrToInt(Req.Params['id'] , LID) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO   := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.Delete(LID);
    if LResult then
      Res
        .Send<TJSONObject>(TJSONObject.Create)
        .Status(THTTPStatus.NoContent)
    else
      Res
        .Send<TJSONObject>(TJSONObject.Create)
        .Status(THTTPStatus.NotFound);
  finally
    LDao.Free;
  end;

end;

procedure DoListItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LID     : Integer;
  LResult : TJSONArray;
begin
  if not TryStrToInt(Req.Params['id'] , LID) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  LConn := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.ListItens(LID);
    if LResult.Count > 0 then
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.OK)
    else
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.NotFound);
  finally
    LDao.Free;
  end;

end;

procedure DoInsertItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : TJSONObject;
  LID     : Integer;
begin
  if not TryStrToInt(Req.Params['id'] , LID) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  //Testamos se recebemos um JSON no Body
  if Req.Body.IsEmpty then
    raise Exception.Create('Corpo da requisição inválido. Envie um JSONArray com os dados a serem inseridos.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.InsertItem(LID, Req.Body);
    if LResult.Count > 0 then
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.Created)
    else
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.NoContent);
  finally
    LDao.Free;
  end;
end;

procedure DoUpdateItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : TJSONObject;
  LPedido : Integer;
  LItem   : Integer;
begin
  if not TryStrToInt(Req.Params['pedido'] , LPedido) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  if not TryStrToInt(Req.Params['item'] , LItem) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  //Testamos se recebemos um JSON no Body
  if Req.Body.IsEmpty then
    raise Exception.Create('Corpo da requisição inválido. Envie um JSONArray com os dados a serem inseridos.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO   := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.UpdateItem(LPedido, LItem, Req.Body);
    if LResult.Count > 0 then
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.Created)
    else
      Res
        .Send<TJSONObject>(LResult)
        .Status(THTTPStatus.NoContent);
  finally
    LDao.Free;
  end;
end;

procedure DoDeleteItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOPedido;
  LConn   : IADRConnection;
  LResult : Boolean;
  LPedido : Integer;
  LItem   : Integer;
begin
  if not TryStrToInt(Req.Params['pedido'] , LPedido) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  if not TryStrToInt(Req.Params['item'] , LItem) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO   := TADRConnDAOPedido.Create(LConn);
  try
    LResult := LDAO.DeleteItem(LPedido, LItem);
    if LResult then
      Res
        .Send<TJSONObject>(TJSONObject.Create)
        .Status(THTTPStatus.NoContent)
    else
      Res
        .Send<TJSONObject>(TJSONObject.Create)
        .Status(THTTPStatus.NotFound);
  finally
    LDao.Free;
  end;
end;


procedure Registry;
begin
  //Rotas de Pedidos
  THorse.Get    ('/pedidos'                      , DoList);
  THorse.Get    ('/pedidos/:id'                  , DoFind);
  THorse.Get    ('/pedidos/mesa/:idmesa'         , DoPedidoMesa);
  THorse.Get    ('/pedidos/comanda/:idcomanda'   , DoPedidoComanda);
  THorse.Post   ('/pedidos'                      , DoInsert);
  THorse.Put    ('/pedidos/:id'                  , DoUpdate);
  THorse.Delete ('/pedidos/:id'                  , DoDelete);

  //Rotas de Itens
  THorse.Get    ('/pedidos/:id/itens'            , DoListItens);
  THorse.Post   ('/pedidos/:id/itens'            , DoInsertItem);
  THorse.Put    ('/pedidos/:pedido/itens/:item'  , DoUpdateItem);
  THorse.Delete ('/pedidos/:pedido/itens/:item'  , DoDeleteItem);

  //Rotas para cozinha
  THorse.Get    ('/pedidos/producao'            , DoListPedidosProducao);

end;

end.
