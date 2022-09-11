unit dao.pedidos;

interface

uses
  ADRConn.DAO.Base,
  ADRConn.Model.Factory,
  ADRConn.Model.Interfaces,

  Data.DB,

  Dataset.Serialize,
  DataSet.Serialize.Config,

  FireDAC.Comp.Client,

  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils;

type
  TADRConnDAOPedido = class(TADRConnDAOBase)
    private
    public
      //Pedidos
      function List(): TJSONArray;
      function Find(AID: Integer): TJSONObject;
      function PedidoMesa(AIDMesa: Integer): TJSONArray;
      function PedidoComanda(AIDComanda: Integer): TJSONArray;
      function Insert(AValue: string): TJSONObject;
      function Update(AID: Integer; AValue: string): TJSONObject;
      function Delete(AID: Integer): Boolean;

      function ListPedidosProducao: TJSONArray;

      //Itens do Pedido
      function ListItens(AIDPedido: Integer) : TJSONArray;
      function InsertItem(AIDPedido: Integer; AValue: string) : TJSONObject;
      function UpdateItem(AIDPedido, AIDItem: Integer; AValue: string): TJSONObject;
      function DeleteItem(AIDPedido, AIDItem: Integer): Boolean;
  end;

implementation

{ TADRConnDAOPedido }

function TADRConnDAOPedido.List: TJSONArray;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, VALOR_TOTAL, STATUS, ID_GARCOM, ID_MESA FROM PEDIDO WHERE STATUS = ''A'' OR STATUS = ''C'' ORDER BY ID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataset :=
        FQuery
          .SQL(LSelect)
          .OpenDataSet;

      Result := LDataset.ToJSONArray;
    except
      Result := TJSONArray.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOPedido.ListPedidosProducao: TJSONArray;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, VALOR_TOTAL, STATUS, ID_GARCOM, ID_MESA FROM PEDIDO WHERE STATUS = ''A'' OR STATUS = ''C'' ORDER BY ID';

  LSelectItens =
    'SELECT                                ' +
    '  IT.ID,                              ' +
    '  IT.ID_PEDIDO,                       ' +
    '  IT.QTDE,                            ' +
    '  IT.ID_PRODUTO,                      ' +
    '  IT.OBS,                             ' +
    '  IT.STATUS,                          ' +
    '  PED.ID,                             ' +
    '  PED.ID_MESA,                        ' +
    '  PROD.NOME                           ' +
    'FROM                                  ' +
    '  ITEM_PEDIDO IT                      ' +
    '  INNER JOIN PEDIDO PED               ' +
    '  ON IT.ID_PEDIDO = PED.ID            ' +
    '  INNER JOIN PRODUTO PROD             ' +
    '  ON IT.ID_PRODUTO = PROD.ID          ' +
    'WHERE                                 ' +
    '  IT.ID_PEDIDO = :pID_PEDIDO          ' +
    'ORDER BY                              ' +
    '  PED.ID,                             ' +
    '  IT.ID                               ';
{$EndRegion}
var
  LPedidos      : TDataSet;
  LItens        : TDataSet;
  LJSONPedidos  : TJSONObject;
  LJSONItens    : TJSONArray;
  LValues       : TJSONValue;
begin
  try
    try
      //Abre pedidos
      Result := TJSONArray.Create;
      LPedidos :=
        FQuery
          .SQL(LSelect)
          .OpenDataSet;

      LPedidos.First;
      LPedidos.DisableControls;
      //Loop em Pedidos e adicona os itens
      while not LPedidos.Eof do
      begin
        LJSONPedidos := LPedidos.ToJSONObject;

        var LID_Pedido: Integer := LPedidos.FieldByName('id').AsInteger;
        LItens :=
          FQuery
            .SQL(LSelectItens)
            .ParamAsInteger('pID_PEDIDO', LID_Pedido)
            .OpenDataSet;

        LJSONItens := LItens.ToJSONArray;
        LJSONPedidos.AddPair('itens', LJSONItens);

        LPedidos.Next;
        Result.Add(LJSONPedidos);
      end;
    except
      Result := TJSONArray.Create;
    end;
  finally
    LPedidos.Free;
    LItens.Free;
  end;
end;

function TADRConnDAOPedido.Find(AID: Integer): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, VALOR_TOTAL, STATUS, ID_GARCOM, ID_MESA FROM PEDIDO WHERE ID =:pID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AID)
          .OpenDataSet;

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;

end;

function TADRConnDAOPedido.Insert(AValue: string): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, VALOR_TOTAL, STATUS, ID_GARCOM, ID_MESA FROM PEDIDO WHERE 1 = 2';
  LSelectResult =
    'SELECT ID, VALOR_TOTAL, STATUS, ID_GARCOM, ID_MESA FROM PEDIDO WHERE ID = :pID_PEDIDO';
{$EndRegion}
var
  LDataSet : TDataSet;
  LJSON    : TJSONObject;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .OpenDataSet;

      LDataSet
        .LoadFromJSON(AValue);

      var LID_Gerado: Integer := TFDQuery(LDataSet).Connection.GetLastAutoGenValue('GEN_PEDIDO_ID');
      LDataSet :=
        FQuery
          .SQL(LSelectResult)
          .ParamAsInteger('pID_PEDIDO', LID_Gerado)
          .OpenDataSet;

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOPedido.Update(AID: Integer; AValue: string): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, STATUS, ID_GARCOM, ID_MESA, STATUS FROM PEDIDO WHERE ID = :pID';
{$EndRegion}
var
  LDataSet      : TDataSet;
  LJSON         : TJSONValue;
  LID_Pedido    : Integer;
  LStatus       : string;
begin
  try
    try
      Self.StartTransaction;

      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AID)
          .OpenDataSet;

      LJSON := TJSONObject.ParseJSONValue(AValue) as TJSONValue;
      LJSON.TryGetValue<integer>('ID', LID_Pedido);
      LJSON.TryGetValue<string>('STATUS', LSTATUS);

      //Se o status do pedido for "C" Pronto ou "E" Entregue, atualiza todos os
      //  itens do pedido para o mesmo status do Pedido.
      if LStatus.Equals('C') or LStatus.Equals('E') or LStatus.Equals('F') then
      begin
        FQuery
          .SQL('UPDATE ITEM_PEDIDO SET STATUS=:pSTATUS WHERE ID_PEDIDO=:pID_PEDIDO')
          .ParamAsString('pSTATUS', LStatus)
          .ParamAsInteger('pID_PEDIDO', LID_Pedido)
          .ExecSQL;
      end;

      LDataSet
        .MergeFromJSONObject(AValue);

      Self.Commit;

      Result := LDataSet.ToJSONObject;
    except on E:Exception do
      begin
        Self.Rollback;
        Result := TJSONObject.Create;
      end;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOPedido.Delete(AID: Integer): Boolean;
{$Region 'SELECT'}
const
  LPedido = 'SELECT ID FROM PEDIDO WHERE ID = :pID';
  LItens  = 'SELECT ID, ID_PEDIDO FROM ITEM_PEDIDO WHERE ID_PEDIDO =:pID_PEDIDO';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LItens)
          .ParamAsInteger('pID_PEDIDO', AID)
          .OpenDataSet;

      if not LDataSet.IsEmpty then
      begin
        LDataSet.Last;
        while not LDataSet.BOF do
          LDataSet.Delete;
      end;

      LDataSet :=
        FQuery
          .SQL(LPedido)
          .ParamAsInteger('pID', AID)
          .OpenDataSet;

      if not LDataSet.IsEmpty then
      begin
        LDataSet.Delete;
        Result := True;
      end
      else Result := False;
    except
      Result := False;
    end;
  finally
    LDataSet.Free;
  end;

end;

function TADRConnDAOPedido.ListItens(AIDPedido: Integer): TJSONArray;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT                                             ' +
    '  IT.ID,                                           ' +
    '  IT.ID_PEDIDO,                                    ' +
    '  IT.ID_PRODUTO,                                   ' +
    '  IT.QTDE,                                         ' +
    '  IT.ID_COMANDA,                                   ' +
    '  PD.DESCRICAO,                                    ' +
    '  SUM(IT.QTDE * PD.VLR_UNITARIO) AS VALOR_TOTAL    ' +
    'FROM                                               ' +
    '  ITEM_PEDIDO IT                                   ' +
    '  INNER JOIN PRODUTO PD                            ' +
    '  ON IT.ID_PRODUTO = PD.ID                         ' +
    'WHERE                                              ' +
    '  ID_PEDIDO = :pID_PEDIDO                          ' +
    'GROUP BY                                           ' +
    '  IT.ID,                                           ' +
    '  IT.ID_PEDIDO,                                    ' +
    '  IT.ID_PRODUTO,                                   ' +
    '  IT.QTDE,                                         ' +
    '  IT.ID_COMANDA,                                   ' +
    '  PD.DESCRICAO                                     ';

{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID_PEDIDO', AIDPedido)
          .OpenDataSet;

      Result := LDataSet.ToJSONArray;
    except
      Result := TJSONArray.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOPedido.PedidoComanda(AIDComanda: Integer): TJSONArray;
{$Region 'SELECT'}
const
  LSQLPedido =
    'SELECT ID, VALOR_TOTAL, STATUS, ID_GARCOM, ID_MESA FROM PEDIDO WHERE ID=:pID_PEDIDO';

  LSQLItens =
    'SELECT                                               ' +
    '  IT.ID,                                             ' +
    '  IT.ID_PEDIDO,                                      ' +
    '  IT.QTDE,                                           ' +
    '  IT.ID_PRODUTO,                                     ' +
    '  IT.ID_COMANDA,                                     ' +
    '  PED.ID AS ID_PEDIDO,                               ' +
    '  PED.ID_MESA,                                       ' +
    '  PROD.VLR_UNITARIO,                                 ' +
    '  PROD.NOME,                                         ' +
    '  SUM(IT.QTDE * PROD.VLR_UNITARIO) AS TOTAL_ITEM     ' +
    'FROM                                                 ' +
    '  ITEM_PEDIDO IT                                     ' +
    '  INNER JOIN PEDIDO PED   ON IT.ID_PEDIDO = PED.ID   ' +
    '  INNER JOIN PRODUTO PROD ON IT.ID_PRODUTO = PROD.ID ' +
    'WHERE                                                ' +
    '      IT.ID_COMANDA =:pID_COMANDA                    ' +
    '  AND PED.STATUS =''A''                              ' +
    'GROUP BY                                             ' +
    '  IT.ID,                                             ' +
    '  IT.ID_PEDIDO,                                      ' +
    '  IT.QTDE,                                           ' +
    '  IT.ID_PRODUTO,                                     ' +
    '  IT.ID_COMANDA,                                     ' +
    '  PED.ID,                                            ' +
    '  PED.ID_MESA,                                       ' +
    '  PROD.VLR_UNITARIO,                                 ' +
    '  PROD.NOME                                          ' +
    'ORDER BY                                             ' +
    '  PED.ID,                                            ' +
    '  IT.ID                                              ';
{$EndRegion}
var
  LPedidos      : TDataSet;
  LItens        : TDataSet;
  LID_Pedido    : Integer;
  LJSONPedidos  : TJSONObject;
  LJSONItens    : TJSONArray;
  LValues       : TJSONValue;
begin
  try
    Result := TJSONArray.Create;
    LItens :=
      FQuery
        .SQL(LSQLItens)
        .ParamAsInteger('pID_COMANDA', AIDComanda)
        .OpenDataSet;

    if LItens.IsEmpty then
      exit;

    LItens.DisableControls;
    LPedidos.DisableControls;

    LItens.First;
    LID_Pedido := LItens.FieldByName('ID_PEDIDO').AsInteger;
    LPedidos :=
      FQuery
        .SQL(LSQLPedido)
        .ParamAsInteger('pID_PEDIDO', LID_Pedido)
        .OpenDataSet;

    LJSONPedidos := LPedidos.ToJSONObject;
    LJSONItens := LItens.ToJSONArray;
    LJSONPedidos.AddPair('itens', LJSONItens);
    Result.Add(LJSONPedidos);
  except
    Result := TJSONArray.Create;
  end;
end;

function TADRConnDAOPedido.PedidoMesa(AIDMesa: Integer): TJSONArray;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, VALOR_TOTAL, STATUS, ID_GARCOM, ID_MESA FROM PEDIDO WHERE ID_MESA =:pID_MESA';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID_MESA', AIDMesa)
          .OpenDataSet;

      Result := LDataSet.ToJSONArray;
    except
      Result := TJSONArray.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOPedido.InsertItem(AIDPedido: Integer; AValue: string): TJSONObject;
{$Region 'SELECT'}
const
  //LSelect       = 'SELECT ID, ID_PEDIDO, QTDE, ID_PRODUTO FROM ITEM_PEDIDO WHERE 1 = 2';
  LSelect       = 'SELECT * FROM ITEM_PEDIDO WHERE 1 = 2';
  LSelectResult = 'SELECT ID, ID_PEDIDO, QTDE, ID_PRODUTO FROM ITEM_PEDIDO WHERE ID = :pID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .OpenDataSet;

      LDataSet
        .LoadFromJSON(AValue);

      var LID_Gerado: Integer := TFDQuery(LDataSet).Connection.GetLastAutoGenValue('GEN_ITEM_PEDIDO_ID');
      LDataSet :=
        FQuery
          .SQL(LSelectResult)
          .ParamAsInteger('pID', LID_Gerado)
          .OpenDataSet;

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;

end;

function TADRConnDAOPedido.UpdateItem(AIDPedido, AIDItem: Integer;
  AValue: string): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, ID_PEDIDO, QTDE, ID_PRODUTO, STATUS FROM ITEM_PEDIDO WHERE ID =:pID AND ID_PEDIDO = :pID_PEDIDO';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AIDItem)
          .ParamAsInteger('pID_PEDIDO', AIDPedido)
          .OpenDataSet;

      LDataSet
        .MergeFromJSONObject(AValue);

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOPedido.DeleteItem(AIDPedido, AIDItem: Integer): Boolean;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, ID_PEDIDO, QTDE, ID_PRODUTO FROM ITEM_PEDIDO WHERE ID =:pID AND ID_PEDIDO = :pID_PEDIDO';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AIDItem)
          .ParamAsInteger('pID_PEDIDO', AIDPedido)
          .OpenDataSet;

      if not LDataSet.IsEmpty then
      begin
        LDataSet.Delete;
        Result := True;
      end
      else Result := False
    except
      Result := False;
    end;
  finally
    LDataSet.Free;
  end;

end;


end.
