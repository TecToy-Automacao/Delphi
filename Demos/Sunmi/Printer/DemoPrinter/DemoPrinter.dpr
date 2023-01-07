program DemoPrinter;

uses
  System.StartUpCopy,
  FMX.Forms,
  uDemoPrinter in 'uDemoPrinter.pas' {Form2},
  Androidapi.JNI.SunmiPrinter in '..\PrinterAPI\Androidapi.JNI.SunmiPrinter.pas',
  FMX.ACBr.SunmiPrinter in '..\PrinterAPI\FMX.ACBr.SunmiPrinter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
