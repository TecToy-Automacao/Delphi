unit Service.Produtos;

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

  System.JSON,
  System.Classes,
  System.SysUtils;

type
  TServiceProdutos = class(TServiceBase)
    memProdutos: TFDMemTable;
    memProdutosID: TIntegerField;
    memProdutosNOME: TStringField;
    memProdutosDESCRICAO: TStringField;
    memProdutosVLR_UNITARIO: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirProdutos;
  end;

var
  ServiceProdutos: TServiceProdutos;

implementation

uses
  Comanda.Lib;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceProdutos }

procedure TServiceProdutos.AbrirProdutos;
var
  LResponse : IResponse;
  LResposta : TJSONArray;
  LValues   : TJSONValue;
begin
  memProdutos.DisableControls;
  memProdutos.Filtered := False;
  memProdutos.Filter   := EmptyStr;

  if not memProdutos.Active then
    memProdutos.Active := True;

  if not memProdutos.IsEmpty then
    memProdutos.EmptyDataSet;

  LResponse :=
    TRequest.New.BaseUrl(TLib.BaseUrl)
      .Resource('produtos')
      .ContentType('application/json')
      .Get;

  LResposta := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

  if (LResponse.StatusCode = 200) and not (LResponse.Content.Equals(EmptyStr)) then
  begin
    for LValues in LResposta do
    begin
      memProdutos.Append;
      memProdutos.FieldByName('ID').AsInteger          := LValues.GetValue<integer>('ID');
<<<<<<< HEAD
      memProdutos.FieldByName('NOME').AsString         := LValues.GetValue<string>('NOME');
=======
      //memProdutos.FieldByName('NOME').AsString         := LValues.GetValue<string>('NOME');
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
      memProdutos.FieldByName('DESCRICAO').AsString    := LValues.GetValue<string>('DESCRICAO');
      memProdutos.FieldByName('VLR_UNITARIO').AsFloat  := LValues.GetValue<double>('VLR_UNITARIO');

      memProdutos.Post;
    end;
  end;

  memProdutos.EnableControls;
end;

end.
