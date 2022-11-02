unit Service.Mesas;

interface

uses
  RESTRequest4D,

  Data.DB,

  DataSet.Serialize,

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
  System.SysUtils;

type
  TServiceMesas = class(TServiceBase)
    memMesas: TFDMemTable;
  private
    { Private declarations }
    FTotal    : Integer;
    FLivres   : Integer;
    FOcupadas : Integer;
  public
    { Public declarations }
    procedure ContarMesas;
    procedure ListarMesas;
    procedure MarcarMesa;
    procedure DesmarcarMesa;

    property Total    : Integer read FTotal    write FTotal;
    property Livres   : Integer read FLivres   write FLivres;
    property Ocupadas : Integer read FOcupadas write FOcupadas;
  end;

var
  ServiceMesas: TServiceMesas;

implementation

uses
  Comanda.Lib;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceMesas }

procedure TServiceMesas.ContarMesas;
begin
  if not memMesas.IsEmpty then
  begin
    memMesas.DisableControls;
    memMesas.Filtered := False;
    memMesas.Filter   := 'OCUPADA = 0';
    memMesas.Filtered := True;
    FLivres           := memMesas.RecordCount;

    memMesas.Filtered := False;
    memMesas.Filter   := 'OCUPADA = 1';
    memMesas.Filtered := True;
    FOcupadas         := memMesas.RecordCount;

    memMesas.Filtered := False;
    memMesas.Filter   := '';
    FTotal            := memMesas.RecordCount;

    memMesas.EnableControls;
  end;
end;

procedure TServiceMesas.DesmarcarMesa;
var
  LJSON      : string;
  LID        : Integer;
begin
  try
    ServiceMesas.memMesas.Edit;
    ServiceMesas.memMesas.FieldByName('OCUPADA').AsInteger := 0;
    ServiceMesas.memMesas.Post;
    LID   := memMesas.FieldByName('ID').AsInteger;
    LJSON := memMesas.ToJSONObjectString();
    Send(LID, 'mesas', LJSON);
  except on E:Exception do
    begin
      raise Exception.Create('Erro ao atualizar o servidor.');
    end;
  end;
end;

procedure TServiceMesas.MarcarMesa;
var
  LJSON      : string;
  LID        : Integer;
begin
  try
    ServiceMesas.memMesas.Edit;
    ServiceMesas.memMesas.FieldByName('OCUPADA').AsInteger := 1;
    ServiceMesas.memMesas.Post;
    LID   := memMesas.FieldByName('ID').AsInteger;
    LJSON := memMesas.ToJSONObjectString();
    Send(LID, 'mesas', LJSON);
  except on E:Exception do
    begin
      raise Exception.Create('Erro ao atualizar o servidor.');
    end;
  end;
end;

procedure TServiceMesas.ListarMesas;
var
  LResponse : IResponse;
begin
  LResponse :=
    TRequest.New.BaseUrl(TLib.BaseUrl)
      .Resource('mesas')
      .ContentType('application/json')
      .DataSetAdapter(memMesas)
      .Get;

  ContarMesas;
end;


end.
