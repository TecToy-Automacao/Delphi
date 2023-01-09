program Park;

uses
  System.StartUpCopy,
  FMX.Forms,
  Park.Main in 'Park.Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
