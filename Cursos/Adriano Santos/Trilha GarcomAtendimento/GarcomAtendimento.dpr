program GarcomAtendimento;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  Service.Base in 'services\Service.Base.pas' {ServiceBase: TDataModule},
  Comanda.Config.Perfil in 'infra\Comanda.Config.Perfil.pas',
  Comanda.Lib in 'infra\Comanda.Lib.pas',
  Comanda.SQL.Constantes in 'infra\Comanda.SQL.Constantes.pas',
  Service.Mesas in 'services\Service.Mesas.pas' {ServiceMesas: TDataModule},
  Service.Pedidos in 'services\Service.Pedidos.pas' {ServicePedidos: TDataModule},
  Service.Produtos in 'services\Service.Produtos.pas' {ServiceProdutos: TDataModule},
  Service.Usuarios in 'services\Service.Usuarios.pas' {ServiceUsuarios: TDataModule},
  UntPrincipal in 'UntPrincipal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TServiceBase, ServiceBase);
  Application.CreateForm(TServiceMesas, ServiceMesas);
  Application.CreateForm(TServicePedidos, ServicePedidos);
  Application.CreateForm(TServiceProdutos, ServiceProdutos);
  Application.CreateForm(TServiceUsuarios, ServiceUsuarios);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
