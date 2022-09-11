program EtiquetaEventos;

uses
  System.StartUpCopy,
  FMX.Forms,
  EtiquetaEventosFr in 'EtiquetaEventosFr.pas' {EtiquetaEventosForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TEtiquetaEventosForm, EtiquetaEventosForm);
  Application.Run;
end.
