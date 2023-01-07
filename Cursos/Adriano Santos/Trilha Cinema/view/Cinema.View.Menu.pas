unit Cinema.View.Menu;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts;

type
  TViewMenu = class(TForm, iRouter4DComponent)
    LytMain: TLayout;
    recBackground: TRectangle;
    flowFilmes: TFlowLayout;
    LytLogo: TLayout;
    lblFilmes: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DoTapFilme(Sender: TObject; const Point: TPointF);
    procedure DoClickFilme(Sender: TObject);
  public
    { Public declarations }
    function Render: TFMXObject;
    procedure UnRender;
  end;

var
  ViewMenu: TViewMenu;

implementation

{$R *.fmx}


uses
  Service.Dados,
  Component.Filme,
  Cinema.Constantes;

procedure TViewMenu.DoClickFilme(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  TRouter4D.Link.&To(C_View_Detalhes,
    TProps
      .Create
        .PropInteger(TFilme(TLayout(Sender).Owner).ID).Key('ID'));
  {$ENDIF}
end;

procedure TViewMenu.DoTapFilme(Sender: TObject; const Point: TPointF);
begin
  {$IFDEF ANDROID}
  TRouter4D.Link.&To(C_View_Detalhes,
    TProps
      .Create
        .PropInteger(TFilme(TLayout(Sender).Owner).ID).Key('ID'));
  {$ENDIF}
end;

procedure TViewMenu.FormCreate(Sender: TObject);
begin
  ServiceDados.QryFilmes.Active := False;
  ServiceDados.QryFilmes.Active := True;
  ServiceDados.QryFilmes.First;
  while not ServiceDados.QryFilmes.EOF do
  begin
    flowFilmes
      .AddObject(
      TFilme.Create(nil)
      .Container(flowFilmes)
      .Identify(ServiceDados.QryFilmesID.AsInteger)
      .Avaliacao(ServiceDados.QryFilmesAVALIACAO.AsInteger)
      .Image(ServiceDados.QryFilmesFOTO)
      .OnClickFilme(DoClickFilme)
      .OnTapFilme(DoTapFilme)
      .New
      );
    ServiceDados.QryFilmes.Next;
  end;
end;

function TViewMenu.Render: TFMXObject;
begin
  Result := LytMain;
end;

procedure TViewMenu.UnRender;
begin

end;

end.
