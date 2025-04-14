unit FrMain;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, Spin, ExtCtrls,
  synaser, ImgList;

const
  CSleepWait = 1000;

type

  { TFormMain }

  TFormMain = class(TForm)
    btEnviarTransPagto: TBitBtn;
    btEnviarEstorno: TBitBtn;
    btSearchPorts: TSpeedButton;
    btSerial: TSpeedButton;
    cbIsPreAuth: TCheckBox;
    cbPrintReceipt: TCheckBox;
    cbxInterestType: TComboBox;
    cbxTypeTransaction: TComboBox;
    cbxPorta: TComboBox;
    cbxCreditType: TComboBox;
    cbIsTyped: TCheckBox;
    edNSU: TEdit;
    gbEstorno: TGroupBox;
    gbPinPad: TGroupBox;
    gbPagamento: TGroupBox;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    mLog: TMemo;
    seTimeOut: TSpinEdit;
    seInstallment: TSpinEdit;
    seValor: TEdit;
    procedure btEnviarEstornoClick(Sender: TObject);
    procedure btEnviarTransPagtoClick(Sender: TObject);
    procedure btSearchPortsClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure seValorKeyPress(Sender: TObject; var Key: Char);
    procedure seValorChange(Sender: TObject);
  private
    fSerial: TBlockSerial;
    function ConectarSerial: Boolean;
    function ConfigurarSerial: Boolean;
    function LerRespostaSerial(ATimeOut: Integer): AnsiString;
    procedure Log(const Info: AnsiString);
  public

  end;

var
  FormMain: TFormMain;

implementation

uses
  TypInfo, Math,
  DirectPin,
  configuraserial,
  synacode;

{$R *.dfm}

function CharIsNum(const C: Char): Boolean;
begin
  Result := C in ['0'..'9'] ;
end ;

function OnlyNumber(const AValue: String): String;
Var
  I : Integer ;
  LenValue : Integer;
begin
  Result   := '' ;
  LenValue := Length( AValue ) ;
  For I := 1 to LenValue  do
  begin
     if CharIsNum( AValue[I] ) then
        Result := Result + AValue[I];
  end;
end ;

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
var
  J: TDPtypeTransaction;
  H: TDPcreditType;
  I: TDPinterestType;
  s: String;
begin
  fSerial := TBlockSerial.Create;
  fSerial.RaiseExcept := False;

  ImageList1.GetBitmap(1, btEnviarTransPagto.Glyph);
  ImageList1.GetBitmap(11, btEnviarEstorno.Glyph);

  cbxTypeTransaction.Items.Clear ;
  For J := Low(TDPtypeTransaction) to High(TDPtypeTransaction) do
  begin
    s := GetEnumName(TypeInfo(TDPtypeTransaction), integer(J));
    Delete(s,1,3);
    cbxTypeTransaction.Items.Add(s) ;
  end;
  cbxTypeTransaction.ItemIndex := 2;

  For H := Low(TDPcreditType) to High(TDPcreditType) do
  begin
    s := GetEnumName(TypeInfo(TDPcreditType), integer(H));
    Delete(s,1,3);
    cbxCreditType.Items.Add(s) ;
  end;
  cbxCreditType.ItemIndex := 0;

  For I := Low(TDPinterestType) to High(TDPinterestType) do
  begin
    s := GetEnumName(TypeInfo(TDPinterestType), integer(I));
    Delete(s,1,3);
    cbxInterestType.Items.Add(s) ;
  end;
  cbxInterestType.ItemIndex := 0;

  btSearchPortsClick(Sender);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  fSerial.Free;
end;

function TFormMain.ConectarSerial: Boolean;
var
  porta: TCaption;
begin
  porta := cbxPorta.Text;
  Log(Format('Conectando em: %s', [porta]));
  fSerial.Connect(porta);
  Log(Format('  Serial.LastError: %d', [fSerial.LastError]));
  Result := (fSerial.LastError = 0);
end;

function TFormMain.ConfigurarSerial: Boolean;
var
  baud, bits, stop: Integer;
  parity: Char;
  softflow, hardflow: Boolean;
begin
  baud := StrToInt(frConfiguraSerial.cmbBaudRate.Items[frConfiguraSerial.cmbBaudRate.ItemIndex]);
  bits := StrToInt(frConfiguraSerial.cmbDataBits.Items[frConfiguraSerial.cmbDataBits.ItemIndex]);
  parity := frConfiguraSerial.cmbParity.Items[frConfiguraSerial.cmbParity.ItemIndex][1];
  stop := frConfiguraSerial.cmbStopBits.ItemIndex;
  softflow := frConfiguraSerial.chSoftFlow.Checked;
  hardflow := frConfiguraSerial.chHardFlow.Checked;

  Log(Format('Configurando baud: %d, bits: %d, parity: %s, stop: %d, softflow: %s, hardflow: %s',
              [baud, bits, parity, stop, BoolToStr(softflow, True), BoolToStr(hardflow, True)]));
  fSerial.config(baud, bits, parity, stop, softflow, hardflow);
  Log(Format('  Serial.LastError: %d', [fSerial.LastError]));
  Result := (fSerial.LastError = 0);
end;

function TFormMain.LerRespostaSerial(ATimeOut: Integer): AnsiString;
var
  i, tentativas: Integer;
  TemDados: Boolean;
  b: Byte;
begin
  Result := '';
  tentativas := max(Trunc(ATimeOut/seTimeOut.Value), 1);

  b := fSerial.RecvByte(seTimeOut.Value);
  Log(Format('  ret: %d', [b]));
  if (b = NAK) then
    Log('  NAK - comando inválido')
  else if (b <> ACK) then
    Log('  Erro na resposta');

  if not (b = ACK) then
    Exit;

  Log('  ACK - comando ok');

  i := 0;
  TemDados := False;
  while not TemDados and (i < tentativas) do
  begin
    TemDados := fSerial.CanReadEx(seTimeOut.Value);
    Sleep(CSleepWait);
    inc(i);
    Log('  '+Format('%d/%d', [i, tentativas]));
  end;

  if TemDados then
  begin
    Log('  Lendo dados da resposta:');
    Result := fSerial.RecvPacket(seTimeOut.Value * 2);
    Log(Result);
  end;
end;

procedure TFormMain.Log(const Info: AnsiString);
begin
  mLog.Lines.Add(Info);
end;

procedure TFormMain.btSearchPortsClick(Sender: TObject);
var
  s: String;
begin
  Log('Procurando Portas...');
  cbxPorta.Items.Clear;
  s := GetSerialPortNames;
  Log('  '+s);
  cbxPorta.Items.Text := StringReplace(s, ',', sLineBreak, [rfReplaceAll]);
  if (cbxPorta.Items.Count > 0) then
    cbxPorta.ItemIndex := 0;
end;

procedure TFormMain.btSerialClick(Sender: TObject);
begin
  frConfiguraSerial.ShowModal;
end;

procedure TFormMain.btEnviarTransPagtoClick(Sender: TObject);
var
  ReqTrans: TDPPayloadRequestTransaction;
  ResTrans: TDPPayloadResponseTransaction;
  dpMessage: TDPSerialMessage;
  Payload, porta, JSonResp: String;
  s: AnsiString;
  b: Byte;
begin
  Log('-- Enviar Transacao Pagamento --');

  if not ConectarSerial then
    Exit;

  try
    if not ConfigurarSerial then
      Exit;

    ReqTrans := TDPPayloadRequestTransaction.Create;
    try
       ReqTrans.amount := StrToFloatDef(seValor.Text, 0);
       ReqTrans.creditType := TDPcreditType(cbxCreditType.ItemIndex);
       ReqTrans.installment := seInstallment.Value;
       ReqTrans.typeTransaction := TDPtypeTransaction(cbxTypeTransaction.ItemIndex);
       ReqTrans.interestType := TDPinterestType(cbxInterestType.ItemIndex);
       ReqTrans.isPreAuth := cbIsPreAuth.Checked;
       ReqTrans.isTyped := cbIsTyped.Checked;
       ReqTrans.printReceipt := cbPrintReceipt.Checked;
       Payload := ReqTrans.AsJSON;
       Log('- Payload -');
       Log(Payload);
    finally
       ReqTrans.Free;
    end;

    dpMessage := TDPSerialMessage.Create;
    try
      dpMessage.PayLoad := Payload;
      s := dpMessage.message_;
      Log('- Serial Message -');
      Log(s);
      fSerial.SendString(s);
      Log(Format('  Serial.LastError: %d', [fSerial.LastError]));
      if (fSerial.LastError <> 0) then
        Exit;

      s := LerRespostaSerial(seTimeOut.Value * 100);

      ResTrans := TDPPayloadResponseTransaction.Create;
      try
        try
          dpMessage.message_ := s;
          JSonResp := dpMessage.PayLoad;
        except
          On E: Exception do
          begin
            Log(E.Message);
            JSonResp := DecodeBase64(s);
          end;
        end;

        Log('- Resposta -');
        Log(JSonResp);

        ResTrans.AsJSON := JSonResp;
        Log('-- Dados da Resposta da Transação --');
        Log('Result: '+BoolToStr(ResTrans.result_, True));
        Log('message: '+ResTrans.message_);
        Log('amount: '+FormatFloat('0.00', ResTrans.amount));
        Log('nsu: '+ResTrans.nsu);
        Log('nsuAcquirer: '+ResTrans.nsuAcquirer);
        Log('panMasked: '+ResTrans.panMasked);
        Log('date: '+FormatDateTime('dd/mm/yy hh:nn:ss', ResTrans.date));
        Log('typeCard: '+ResTrans.typeCard);
        Log('finalResult: '+ResTrans.finalResult);
        Log('codeResult: '+IntToStr(ResTrans.codeResult));
        Log('- receiptContent -');
        Log( StringReplace(ResTrans.receiptContent, '@', sLineBreak, [rfReplaceAll]) );
        edNSU.Text := ResTrans.nsu;
      finally
         ResTrans.Free;
      end;
    finally
      dpMessage.Free;
    end;
  finally
    fSerial.CloseSocket;
  end;
end;

procedure TFormMain.btEnviarEstornoClick(Sender: TObject);
var
  ReqRev: TDPPayLoadRequestReversal;
  ResRev: TDPPayLoadResponseReversal;
  dpMessage: TDPSerialMessage;
  Payload, JSonResp: String;
  s: AnsiString;
begin
  Log('-- Enviar Estorno --');

  if not ConectarSerial then
    Exit;

  try
    if not ConfigurarSerial then
      Exit;

    ReqRev := TDPPayLoadRequestReversal.Create;
    try
       ReqRev.nsu := edNSU.Text;
       Payload := ReqRev.AsJSON;
       Log('- Payload -');
       Log(Payload);
    finally
       ReqRev.Free;
    end;

    dpMessage := TDPSerialMessage.Create;
    try
      dpMessage.PayLoad := Payload;
      s := dpMessage.message_;
      Log('- Serial Message -');
      Log(s);
      fSerial.SendString(s);
      Log(Format('  Serial.LastError: %d', [fSerial.LastError]));
      if (fSerial.LastError <> 0) then
        Exit;

      s := LerRespostaSerial(seTimeOut.Value * 100);

      ResRev := TDPPayLoadResponseReversal.Create;
      try
        try
          dpMessage.message_ := s;
          JSonResp := dpMessage.PayLoad;
        except
          On E: Exception do
          begin
            Log(E.Message);
            JSonResp := DecodeBase64(s);
          end;
        end;

        Log('- Resposta -');
        Log(JSonResp);

        ResRev.AsJSON := JSonResp;
        Log('-- Dados da Resposta da Transação --');
        Log('Result: '+BoolToStr(ResRev.result_, True));
        Log('message: '+ResRev.message_);
        Log('- receiptContent -');
        Log( StringReplace(ResRev.receiptContent, '@', sLineBreak, [rfReplaceAll]) );
      finally
         ResRev.Free;
      end;
    finally
      dpMessage.Free;
    end;
  finally
    fSerial.CloseSocket;
  end;
end;


procedure TFormMain.seValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not( Key in ['0'..'9',#8,#13,#27])  then
    Key := #0;
end;

procedure TFormMain.seValorChange(Sender: TObject);
var
  AValor: Double;
begin
  AValor := StrToIntDef(OnlyNumber(seValor.Text), 0)/100;
  seValor.Text := FormatFloat('0.00', AValor);
  seValor.SelStart := Length(seValor.Text);
end;

end.

