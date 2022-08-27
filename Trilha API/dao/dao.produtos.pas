unit dao.produtos;

interface

uses
  ADRConn.DAO.Base,
  ADRConn.Model.Factory,
  ADRConn.Model.Interfaces,

  Dataset.Serialize,

  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils;

type
  TADRConnDAOProduto = class(TADRConnDAOBase)
    private
    public
      function List(): TJSONArray;
      function Find(AID: Integer): TJSONObject;
      function FindByCodBar(ACodBar: String): TJSONObject;
      function Update(AID: Integer; AValue: string): TJSONArray;
      function Insert(AValue: string): TJSONObject;
  end;

implementation

{ TADRConnDAOProduto }

function TADRConnDAOProduto.List: TJSONArray;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, NOME, DESCRICAO, VLR_UNITARIO, CODBAR FROM PRODUTO ORDER BY ID';
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

function TADRConnDAOProduto.Find(AID: Integer): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, NOME, DESCRICAO, VLR_UNITARIO, CODBAR FROM PRODUTO WHERE ID = :pID ORDER BY ID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataset :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AID)
          .OpenDataSet;

      Result := LDataset.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;

end;

function TADRConnDAOProduto.Update(AID: Integer; AValue: string): TJSONArray;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, NOME, DESCRICAO, VLR_UNITARIO FROM PRODUTO WHERE ID = :pID ORDER BY ID';
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

      LDataSet
        .MergeFromJSONObject(AValue);

      Result := LDataSet.ToJSONArray;
    except
      Result := TJSONArray.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOProduto.FindByCodBar(ACodBar: String): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, NOME, DESCRICAO, VLR_UNITARIO, CODBAR FROM PRODUTO WHERE CODBAR = :pCODBAR';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataset :=
        FQuery
          .SQL(LSelect)
          .ParamAsString('pCODBAR', ACODBAR)
          .OpenDataSet;

      Result := LDataset.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOProduto.Insert(AValue: string): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, NOME, DESCRICAO, VLR_UNITARIO FROM PRODUTO WHERE 1 = 2';
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

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

end.
