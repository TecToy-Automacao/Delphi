unit uSecondDisplay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.acbr.SecondDisplay, FMX.Effects;

type
  TFormSecondDisplay = class(TForm)
  private
    Tela02: TACBrSecondDisplayLayout;
    { Private declarations }
  public
    Procedure ShowLayout(aLayout: TControl);
    Procedure HideLayout(aLayout: TControl);
  end;

var
  FormSecondDisplay: TFormSecondDisplay;

implementation

{$R *.fmx}
{ TForm3 }

procedure TFormSecondDisplay.ShowLayout(aLayout: TControl);
begin
  aLayout.Width := Tela02.Width;
  aLayout.Height := Tela02.Height;
  aLayout.Parent := Tela02;
  aLayout.Align := TAlignLayout.Contents;
  aLayout.BringToFront;
  Tela02.Show;
end;

procedure TFormSecondDisplay.HideLayout(aLayout: TControl);
begin
  aLayout.Parent := Nil;
  Tela02.Clear;
end;

end.
