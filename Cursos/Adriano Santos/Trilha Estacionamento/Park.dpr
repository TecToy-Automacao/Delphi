program Park;

uses
  System.StartUpCopy,
  FMX.Forms,
  Park.Main in 'Park.Main.pas' {ViewMain},
  Service.Dados in 'services\Service.Dados.pas' {ServiceDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.CreateForm(TServiceDados, ServiceDados);
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
