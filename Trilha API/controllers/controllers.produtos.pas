unit controllers.produtos;

interface

procedure Registry;

implementation

uses
  Horse,

  ADRConn.Model.Factory,
  ADRConn.Model.Interfaces,

  DAO.Produtos,

  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils;

procedure DoList(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOProduto;
  LConn   : IADRConnection;
  LResult : TJSONArray;
begin
  LConn := TADRConnModelFactory.GetConnectionIniFile();
  LConn.Connect;
  LDAO := TADRConnDAOProduto.Create(LConn);
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

procedure DoFind(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOProduto;
  LConn   : IADRConnection;
  LID     : Integer;
  LResult : TJSONObject;
begin
  if not TryStrToInt(Req.Params['id'] , LID) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  LConn := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO := TADRConnDAOProduto.Create(LConn);
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

procedure DoFindByCodBar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOProduto;
  LConn   : IADRConnection;
  LCodBar : String;
  LResult : TJSONObject;
begin
  if not Req.Params.TryGetValue('codbar', LCodBar) then
    raise Exception.Create('Código de Barras inválido. Envie um número inteiro.');

  LConn := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO := TADRConnDAOProduto.Create(LConn);
  try
    LResult := LDAO.FindByCodBar(LCodBar);
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

procedure DoUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOProduto;
  LConn   : IADRConnection;
  LDADOS  : TJSONValue;
  LResult : TJSONArray;
  LID     : Integer;
begin
  if not TryStrToInt(Req.Params['id'] , LID) then
    raise Exception.Create('ID inválido. Envie um número inteiro.');

  //Testamos se recebemos um JSON no Body
  if Req.Body.IsEmpty then
    raise Exception.Create('Corpo da requisição inválido. Envie um JSONArray com os dados a serem inseridos.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO   := TADRConnDAOProduto.Create(LConn);
  LDADOS := TJSONObject.ParseJSONValue(Req.Body);
  try
    LResult := LDAO.Update(LID, Req.Body);
    if LResult.Count > 0 then
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.Created)
    else
      Res
        .Send<TJSONArray>(LResult)
        .Status(THTTPStatus.NoContent);
  finally
    LDao.Free;
  end;
end;

procedure DoInsert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAO    : TADRConnDAOProduto;
  LConn   : IADRConnection;
  LDADOS  : TJSONValue;
  LResult : TJSONObject;
  LID     : Integer;
begin
  //Testamos se recebemos um JSON no Body
  if Req.Body.IsEmpty then
    raise Exception.Create('Corpo da requisição inválido. Envie um JSONArray com os dados a serem inseridos.');

  LConn   := TADRConnModelFactory.GetConnectionIniFile;
  LConn.Connect;
  LDAO   := TADRConnDAOProduto.Create(LConn);
  LDADOS := TJSONObject.ParseJSONValue(Req.Body);
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

procedure Registry;
begin
  THorse.Get ('/produtos'                    , DoList);
  THorse.Get ('/produtos/:id'                , DoFind);
  THorse.Get ('/produtos/codbarras/:codbar'  , DoFindByCodBar);
  THorse.Post('/produtos'                    , DoInsert);
  THorse.Put ('/produtos/:id'                , DoUpdate);
end;

end.
