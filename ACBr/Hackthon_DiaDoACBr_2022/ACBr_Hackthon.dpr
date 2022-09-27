program ACBr_Hackthon;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  Androidapi.JNI.Nfc in 'API\Androidapi.JNI.Nfc.pas',
  Androidapi.JNI.Nfc.Tech in 'API\Androidapi.JNI.Nfc.Tech.pas',
  NFCHelper in 'API\NFCHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
