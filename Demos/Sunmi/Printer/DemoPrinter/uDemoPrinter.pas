unit uDemoPrinter;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects,
  FMX.ACBr.SunmiPrinter;

type
  TForm2 = class(TForm)
    Button1: TButton;
    ACBr: TImage;
    PrinterState: TText;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPrinter: TACBrSunmiPrinter;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);
begin
  FPrinter := TACBrSunmiPrinter.Create;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FPrinter.DisposeOf;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  FPrinter.setFontSize(10).printTextLF('Teste de impressao Font 10')
    .setFontSize(12).printTextLF('Teste de impressao Font 12').setFontSize(14)
    .printTextLF('Teste de impressao Font 14').setFontSize(16)
    .printTextLF('Teste de impressao Font 16').setFontSize(18)
    .printTextLF('Teste de impressao Font 18').setFontSize(20)
    .printTextLF('Teste de impressao Font 20').setAlignment(1)
    .printBarCode('TESTE', 4).lineWrap(2).setAlignment(2).printText('printText')
    .printTextLF('|printText + LF').lineWrap(1).setAlignment(1)
    .printQRCode('ACBr Automação Comercial Brasil').lineWrap(1).setAlignment(2)
    .printBitmap(ACBr.Bitmap).lineWrap(5).cutPaper;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  FPrinter.updatePrinterState.Execute(
    Procedure
    Begin
      case FPrinter.PrinterState of
        TACBrSunmiPrinterState.Ok:
          PrinterState.Text := 'Impressora Ok';
        TACBrSunmiPrinterState.Atualizando:
          PrinterState.Text := 'Impressora atualizando';
        TACBrSunmiPrinterState.Erro:
          PrinterState.Text := 'Impressora emerro';
        TACBrSunmiPrinterState.SemPapel:
          PrinterState.Text := 'Impressora sem papel';
        TACBrSunmiPrinterState.Superaquecida:
          PrinterState.Text := 'Impressora Superaquecida';
        TACBrSunmiPrinterState.TampaAberta:
          PrinterState.Text := 'Impressora com tampa aberta';
        TACBrSunmiPrinterState.ErroCortador:
          PrinterState.Text := 'Impressora com erro no cortador';
        TACBrSunmiPrinterState.RecuoCortador:
          PrinterState.Text := 'Impressora com recuo no cortador';
        TACBrSunmiPrinterState.NaoDetectada:
          PrinterState.Text := 'Impressora não encontrada';
      end;
    End);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  FPrinter.cutPaper.getCutPaperTimes;
  PrinterState.Text := FPrinter.Cortes.ToString + ' Cortes executados';
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  FPrinter.openDrawer.getOpenDrawerTimes.Execute(
    Procedure
    Begin
      PrinterState.Text := 'Gaveta aberta ' + FPrinter.Cortes.ToString
        + ' vezes';
    End).IfDrawerOpened(
    Procedure
    Begin
      PrinterState.Text := PrinterState.Text + #13#10 + ' Agaveta está aberta';
    End).IfDrawerClosed(
    Procedure
    Begin
      PrinterState.Text := PrinterState.Text + #13#10 + ' Agaveta está fechada';
    End);
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  if FPrinter.getDrawerStatus.GavetaAberta then
    PrinterState.Text := 'Agaveta está Aberta'
  Else
    PrinterState.Text := 'Agaveta está Fechada';
end;

end.
