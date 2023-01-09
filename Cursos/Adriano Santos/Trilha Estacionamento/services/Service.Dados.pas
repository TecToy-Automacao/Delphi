unit Service.Dados;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Phys.SQLite;

type
  TServiceDados = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    fdConn: TFDConnection;
    QryCarros: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QryCarrosPLACA: TStringField;
    QryCarrosMARCA: TStringField;
    QryCarrosMODELO: TStringField;
    QryCarrosDATA_ENTRADA: TDateField;
    QryCarrosHORA_ENTRADA: TTimeField;
    QryCarrosDATA_SAIDA: TDateField;
    QryCarrosHORA_SAIDA: TTimeField;
    QryCarrosTOTAL: TFloatField;
    QryCarrosTICKET: TIntegerField;
    QryCarrosBAIXADO: TIntegerField;
    QryCarrosCOR: TStringField;
    QryIncTicket: TFDQuery;
    QryIncTicketMAX_TICKET: TLargeintField;
    procedure fdConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    function MaxTicket: Integer;
  public
    { Public declarations }
    procedure AbrirCarros;
    procedure Entrada(APlaca, AMarca, AModelo: string);
    procedure Saida(APlaca: string);
  end;

var
  ServiceDados: TServiceDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


procedure TServiceDados.AbrirCarros;
begin
  QryCarros.Active := False;
  QryCarros.Active := True;
end;

procedure TServiceDados.Entrada(APlaca, AMarca, AModelo: string);
begin
  QryCarros.Append;
  QryCarros.FieldByName('TICKET').AsInteger := MaxTicket;
  QryCarros.FieldByName('PLACA').AsString := APlaca;
  QryCarros.FieldByName('MARCA').AsString := AMarca;
  QryCarros.FieldByName('MODELO').AsString := AModelo;
  QryCarros.FieldByName('DATA_ENTRADA').AsDateTime := Now;
  QryCarros.FieldByName('HORA_ENTRADA').AsDateTime := Now;
  QryCarros.FieldByName('BAIXADO').AsInteger := 0;
  QryCarros.Post;
end;

procedure TServiceDados.fdConnBeforeConnect(Sender: TObject);
begin
  fdConn.Params.Values['OpenMode'] := 'ReadWrite';
{$IFDEF MSWINDOWS}
  fdConn.Params.Values['Database'] := 'C:\Projetos\TecToy_Oficial\Cursos\Adriano Santos\databases\Park.db';
{$ENDIF}

{$IFDEF ANDROID}
  fdConn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'Park.db');
{$ENDIF}
end;

function TServiceDados.MaxTicket: Integer;
begin
  QryIncTicket.Active := False;
  QryIncTicket.Active := True;
  Result := QryIncTicketMAX_TICKET.AsInteger;
end;

procedure TServiceDados.Saida(APlaca: string);
begin

end;

end.
