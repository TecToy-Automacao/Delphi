unit Cinema.Routes;

interface

uses
  Router4D,
  Cinema.Constantes,
  Cinema.View.Menu,
  Cinema.View.Detalhes,
  Cinema.View.Comprar
  ;

type
  TRoutes = class
    public
      constructor Create;
      destructor Destroy; override;
  end;

var
  Routes : TRoutes;

implementation

{ TRoutes }

constructor TRoutes.Create;
begin
  TRouter4D.Switch.Router(C_View_Menu, TViewMenu);
  TRouter4D.Switch.Router(C_View_Detalhes, TViewDetalhes);
  TRouter4D.Switch.Router(C_View_Comprar, TViewComprar);
end;

destructor TRoutes.Destroy;
begin

  inherited;
end;

initialization
  Routes := TRoutes.Create;

finalization
  Routes.Free;


end.
