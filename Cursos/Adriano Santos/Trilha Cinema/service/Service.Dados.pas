unit Service.Dados;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,

  System.IOUtils;

type
  TServiceDados = class(TDataModule)
    fdConn: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QryFilmes: TFDQuery;
    QryFilmesID: TIntegerField;
    QryFilmesTITULO: TStringField;
    QryFilmesSINOPSE: TStringField;
    QryFilmesFOTO: TBlobField;
    QryFilmesAVALIACAO: TIntegerField;
    procedure fdConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceDados: TServiceDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


procedure TServiceDados.fdConnBeforeConnect(Sender: TObject);
begin
  fdConn.Params.Values['OpenMode'] := 'ReadWrite';
{$IFDEF MSWINDOWS}
  fdConn.Params.Values['Database'] := 'C:\Projetos\TecToy_Oficial\Cursos\Adriano Santos\databases\Filmes.db';
{$ENDIF}

{$IFDEF ANDROID}
  fdConn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'Filmes.db');
{$ENDIF}
end;

end.
