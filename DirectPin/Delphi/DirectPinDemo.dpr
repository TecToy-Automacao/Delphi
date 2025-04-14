program DirectPinDemo;

uses
  Forms { you can add units after this },
  FrMain in 'frmain.pas',
  configuraserial in 'configuraserial.pas',
  DirectPin in 'directpin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TfrConfiguraSerial, frConfiguraSerial);
  Application.Run;
end.

