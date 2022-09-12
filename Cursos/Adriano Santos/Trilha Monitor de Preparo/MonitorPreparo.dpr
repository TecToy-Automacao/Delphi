program MonitorPreparo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UntMain in 'UntMain.pas' {ViewMonitorProducao},
  Cozinha.Routers in 'routers\Cozinha.Routers.pas',
  Cozinha.Routers.Consts in 'routers\Cozinha.Routers.Consts.pas',
  Cozinha.Components.Item001 in 'views\Components\Cozinha.Components.Item001.pas' {ComponentItem001},
  Service.Base in 'services\Service.Base.pas' {ServiceBase: TDataModule},
  Service.Pedidos in 'services\Service.Pedidos.pas' {ServicePedidos: TDataModule},
  Cozinha.Consts in 'infra\Cozinha.Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := true;
  Application.CreateForm(TServiceBase, ServiceBase);
  Application.CreateForm(TServicePedidos, ServicePedidos);
  Application.CreateForm(TViewMonitorProducao, ViewMonitorProducao);
  Application.Run;
end.
