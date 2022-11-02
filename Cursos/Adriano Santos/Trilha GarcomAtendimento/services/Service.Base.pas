unit Service.Base;

interface

uses
  RESTRequest4D,
  Data.DB,
  FireDAC.Comp.Client,
  System.JSON,
  System.SysUtils,
  System.Classes;

type
  TServiceBase = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CloseAllTables(AService: TDataModule);
    function  Send(const AResource: string; AJSON: string) : Boolean; overload;
    function  Send(const AResource: string; AJSON: string; out AJSONObj: TJSONValue) : Boolean; overload;
    function  Send(const AID: integer; const AResource: string; AJSON: string) : Boolean; overload;
  end;

var
  ServiceBase: TServiceBase;

implementation

uses
  Comanda.Lib;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceBase }


procedure TServiceBase.CloseAllTables(AService: TDataModule);
var
  I : Integer;
begin
  for I := 0 to Pred(AService.ComponentCount) do
  begin
    if (AService.Components[I] is TFDMemTable) then
    begin
      if not TFDMemTable(AService.Components[I]).IsEmpty then
        TFDMemTable(AService.Components[I]).EmptyDataSet;
      TFDMemTable(AService.Components[I]).Filtered := False;
      TFDMemTable(AService.Components[I]).Filter   := EmptyStr;
      TFDMemTable(AService.Components[I]).Active   := False;
    end;

  end;
end;

function TServiceBase.Send(const AID: integer; const AResource: string;
  AJSON: string): Boolean;
begin
  try
    var LResponse : IResponse :=
      TRequest.New.BaseURL(TLib.BaseUrl)
      .Resource(AResource + '/' + AID.ToString)
      .ContentType('application/json')
      .AddBody(AJSON)
      .Put;

    Result := LResponse.StatusCode = 201;
  except on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TServiceBase.Send(const AResource: string; AJSON: string): Boolean;
var
  LResponse : IResponse;
begin
  //Novo Registro -> Post para o Servicor
  try
    LResponse :=
      TRequest.New.BaseURL(TLib.BaseUrl)
      .Resource(AResource)
      .ContentType('application/json')
      .AddBody(AJSON)
      .Post;

    Result := LResponse.StatusCode = 201;
  except on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TServiceBase.Send(const AResource: string; AJSON: string;
  out AJSONObj: TJSONValue): Boolean;
var
  LResponse : IResponse;
begin
  //Novo Registro -> Post para o Servidor
  try
    LResponse :=
      TRequest.New.BaseURL(TLib.BaseUrl)
      .Resource(AResource)
      .ContentType('application/json')
      .AddBody(AJSON)
      .Post;

    var LResult: Boolean := LResponse.StatusCode = 201;
    if LResult then
    begin
      AJSONObj := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONValue;
      Result := LResult;
    end
    else
      Result := LResponse.StatusCode = 201;
  except on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
