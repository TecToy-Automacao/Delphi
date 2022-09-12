unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  uFrameVendaProduto;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FrameVendaProduto : TFrameVendaProduto;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation


{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);
begin
FrameVendaProduto := TFrameVendaProduto.Create(Self);
Image1.Visible := False;
Image2.Visible := False;
end;




procedure TForm2.Button1Click(Sender: TObject);
begin
FrameVendaProduto.Show;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
FrameVendaProduto.Imagem           := Image1.Bitmap;
FrameVendaProduto.Descricao        := 'Alexa';
FrameVendaProduto.Quantidade       := 1;
FrameVendaProduto.ValorUnitario    := 356.99;
FrameVendaProduto.TotalVenda       := 356.99;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
FrameVendaProduto.Imagem           := Image2.Bitmap;
FrameVendaProduto.Descricao        := 'Mintendo Switch';
FrameVendaProduto.Quantidade       := 1;
FrameVendaProduto.ValorUnitario    := 2600.00;
FrameVendaProduto.TotalVenda       := 2956.99;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
FrameVendaProduto.Hide;
end;

end.
