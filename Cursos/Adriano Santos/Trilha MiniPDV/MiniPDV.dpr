program MiniPDV;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  UntMain in 'UntMain.pas' {MainForm},
  PDV.Consts in 'infra\PDV.Consts.pas',
  Service.Base in 'services\Service.Base.pas' {ServiceBase: TDataModule},
  Service.Geral in 'services\Service.Geral.pas' {ServiceGeral: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TServiceBase, ServiceBase);
  Application.CreateForm(TServiceGeral, ServiceGeral);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
