program Cinema;

uses
  System.StartUpCopy,
  FMX.Forms,
  Cinema.Main in 'Cinema.Main.pas' {Main},
  Component.Filme in 'components\Component.Filme.pas' {Filme},
  Service.Dados in 'service\Service.Dados.pas' {ServiceDados: TDataModule},
  Cinema.View.Detalhes in 'view\Cinema.View.Detalhes.pas' {ViewDetalhes},
  Cinema.Routes in 'routes\Cinema.Routes.pas',
  Cinema.Constantes in 'routes\Cinema.Constantes.pas',
  Cinema.View.Menu in 'view\Cinema.View.Menu.pas' {ViewMenu},
  Cinema.View.Comprar in 'view\Cinema.View.Comprar.pas' {ViewComprar};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TServiceDados, ServiceDados);
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
