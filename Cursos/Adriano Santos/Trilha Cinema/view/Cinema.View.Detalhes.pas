unit Cinema.View.Detalhes;

interface

uses
  Router4D,
  Router4D.Interfaces,
  Router4D.Props,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.EditBox,
  FMX.SpinBox;

type
  TViewDetalhes = class(TForm, iRouter4DComponent)
    LytMain: TLayout;
    recBackground: TRectangle;
    LytLogo: TLayout;
    imgLogo: TImage;
    LytDetalhes: TLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    LytComponente: TLayout;
    lytApoio: TLayout;
    recComponente: TRectangle;
    lytAvaliacao: TLayout;
    Layout4: TLayout;
    Circle1: TCircle;
    Circle2: TCircle;
    LblAvaliacao: TLabel;
    lblTitulo: TLabel;
    Label2: TLabel;
    lblSinopse: TLabel;
    LytBotoes: TLayout;
    lytComprar: TLayout;
    recComprar: TRectangle;
    Comprar: TLabel;
    speComprar: TSpeedButton;
    Layout6: TLayout;
    Label4: TLabel;
    lytCancelar: TLayout;
    recCancelar: TRectangle;
    lblCancelar: TLabel;
    speCancelar: TSpeedButton;
    lblQtde: TLabel;
    lytMenos: TLayout;
    pthMenos: TPath;
    speMenos: TSpeedButton;
    lytMais: TLayout;
    pthMais: TPath;
    speMais: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure speCancelarClick(Sender: TObject);
    procedure speMaisClick(Sender: TObject);
    procedure speMenosClick(Sender: TObject);
    procedure speComprarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Render: TFMXObject;
    procedure UnRender;

    [Subscribe]
    procedure Props(AValue: TProps);


  end;

var
  ViewDetalhes: TViewDetalhes;

implementation

uses
  Service.Dados,
  Cinema.Constantes;

{$R *.fmx}

{ TViewDetalhes }

procedure TViewDetalhes.FormCreate(Sender: TObject);
begin
  GlobalEventBus.RegisterSubscriber(Self);
end;

procedure TViewDetalhes.Props(AValue: TProps);
begin
  if AValue.Key = 'ID' then
  begin
    ServiceDados.QryFilmes.Filtered := False;
    ServiceDados.QryFilmes.Filter := Format('ID=%d', [AValue.PropInteger]);
    ServiceDados.QryFilmes.Filtered := True;

    lblTitulo.Text := ServiceDados.QryFilmesTITULO.AsString;
    lblSinopse.Text := ServiceDados.QryFilmesSINOPSE.AsString + '...';
    LblAvaliacao.Text := ServiceDados.QryFilmesAVALIACAO.AsInteger.ToString;
    recComponente.Fill.Bitmap.Bitmap.Assign(ServiceDados.QryFilmesFOTO);
  end;
end;

function TViewDetalhes.Render: TFMXObject;
begin
  Result := LytMain;
end;

procedure TViewDetalhes.speCancelarClick(Sender: TObject);
begin
  ServiceDados.QryFilmes.Filter := EmptyStr;
  ServiceDados.QryFilmes.Filtered := False;
  TRouter4D.Link.&To(C_View_Menu);
end;

procedure TViewDetalhes.speComprarClick(Sender: TObject);
begin
  TRouter4D.Link.&To(C_View_Comprar);
end;

procedure TViewDetalhes.speMaisClick(Sender: TObject);
var
  LQtde : Integer;
begin
  LQtde := lblQtde.Text.ToInteger + 1;
  if LQtde > 9 then
    ShowMessage('Não é permitido comprar mais que 9 ingressos.')
  else
    lblQtde.Text := LQtde.ToString;
end;

procedure TViewDetalhes.speMenosClick(Sender: TObject);
var
  LQtde : Integer;
begin
  LQtde := lblQtde.Text.ToInteger - 1;
  if LQtde <= 0 then
    lblQtde.Text := '1'
  else
    lblQtde.Text := LQtde.ToString;
end;

procedure TViewDetalhes.UnRender;
begin

end;

end.
