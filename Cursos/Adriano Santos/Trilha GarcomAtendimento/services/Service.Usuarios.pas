unit Service.Usuarios;

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
  System.Json,
  System.SysUtils;

type
  TServiceUsuarios = class(TServiceBase)
    memGarcom: TFDMemTable;
  private
    { Private declarations }
  public
    { Public declarations }
    function Login(const AUsuario, ASenha: string): Boolean;
  end;

var
  ServiceUsuarios: TServiceUsuarios;

implementation

uses
  Comanda.Lib;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceUsuarios }

function TServiceUsuarios.Login(const AUsuario, ASenha: string): Boolean;
var
  LResponse: IResponse;
begin
  try
    LResponse :=
      TRequest.New.BaseURL(TLib.BaseURL)
      .Resource('usuarios/login')
      .AddParam('usuario', AUsuario)
      .AddParam('senha', ASenha)
      .ContentType('application/json')
      .DataSetAdapter(memGarcom)
      .Get;

    if (LResponse.StatusCode = 404) then
      raise Exception.Create('Usuário ou Senha não encontrados.');

    if memGarcom.FieldByName('TIPOUSUARIO').AsInteger <> 2 then // Não é um GARÇOM/GARÇONETE
      raise Exception.Create('Esse usuário não pertence a um Garçom ou Garçonete!');

    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
