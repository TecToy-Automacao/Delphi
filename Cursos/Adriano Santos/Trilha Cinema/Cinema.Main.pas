unit Cinema.Main;

interface

uses
  Router4D,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects;

type
  TMain = class(TForm)
    LytMain: TLayout;
    recBackground: TRectangle;
    LytLogo: TLayout;
    imgLogo: TImage;
    LytNavegacao: TLayout;
    LytAdrianoSantos: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses
  Cinema.View.Menu;

{$R *.fmx}

procedure TMain.FormShow(Sender: TObject);
begin
  TRouter4D.Render<TViewMenu>.SetElement(LytNavegacao, LytNavegacao);
end;

end.
