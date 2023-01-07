unit Component.Filme;

interface

uses
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
  FMX.Objects,
  FMX.Layouts,

  Data.Db, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFilme = class(TForm)
    LytComponente: TLayout;
    recComponente: TRectangle;
    lytApoio: TLayout;
    lytAvaliacao: TLayout;
    Layout1: TLayout;
    Circle1: TCircle;
    Circle2: TCircle;
    LblAvaliacao: TLabel;
  private
    { Private declarations }
    FContainer: TFMXObject;
    FIndex : TFilme;
    FID : Integer;
  public
    { Public declarations }
    function Identify(ANumero: Integer): TFilme;
    function Image(AImage: TBlobField): TFilme; overload;
    function Image(APath: string): TFilme; overload;
    function Image(AStream: TStream): TFilme; overload;
    function OnClickFilme(AOnClickFilme: TNotifyEvent): TFilme;
    function OnTapFilme(AOnTapFilme: TTapEvent): TFilme;
    function Avaliacao(ANumero: Integer): TFilme;
    function Container(AContainer: TFMXObject): TFilme;
    function New: TFMXObject;

    property ID : Integer read FID write FID;
  end;

var
  Filme: TFilme;

implementation

{$R *.fmx}

{ TFilme }

function TFilme.Avaliacao(ANumero: Integer): TFilme;
begin
  Result := Self;
  LblAvaliacao.Text := Format('%2.2d', [ANumero]);
end;

function TFilme.Container(AContainer: TFMXObject): TFilme;
begin
  Result := Self;
  FContainer := AContainer;
end;

function TFilme.Image(AImage: TBlobField): TFilme;
begin
  Result := Self;
  if Assigned(AImage) then
    recComponente.Fill.Bitmap.Bitmap.Assign(AImage);
end;

function TFilme.Image(APath: string): TFilme;
begin
  Result := Self;
  recComponente.Fill.Bitmap.Bitmap.LoadFromFile(APath);
end;

function TFilme.Identify(ANumero: Integer): TFilme;
begin
  Result := Self;
  FID := ANumero;
end;

function TFilme.Image(AStream: TStream): TFilme;
begin
  Result := Self;
  recComponente.Fill.Bitmap.Bitmap.LoadFromStream(AStream);
end;

function TFilme.New: TFMXObject;
begin
  Result := LytComponente;
  LytComponente.Width  := (TFlowLayout(FContainer).Width / 4) - 8;
end;

function TFilme.OnClickFilme(AOnClickFilme: TNotifyEvent): TFilme;
begin
  Result := Self;
  {$IFDEF MSWINDOWS}
  if Assigned(AOnClickFilme) then
  begin
    recComponente.HitTest := True;
    recComponente.OnClick := AOnClickFilme;
  end;
  {$ENDIF}
end;

function TFilme.OnTapFilme(AOnTapFilme: TTapEvent): TFilme;
begin
  Result := Self;
  {$IFDEF ANDROID}
  if Assigned(AOnTapFilme) then
  begin
    recComponente.HitTest := False;
    LytComponente.OnTap := AOnTapFilme;
  end;
  {$ENDIF}
end;

end.
