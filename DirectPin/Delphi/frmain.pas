unit FrMain;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, Spin, ExtCtrls,
  synaser, ImgList, ImageList;

const
  CSleepWait = 1000;

type

  { TFormMain }

  TFormMain = class(TForm)
    btAbortar: TBitBtn;
    btColetar: TBitBtn;
    btConfirmar: TBitBtn;
    btEnviarTransPagto: TBitBtn;
    btEnviarEstorno: TBitBtn;
    btEnviarMensagem: TBitBtn;
    btSearchPorts: TSpeedButton;
    btSerial: TSpeedButton;
    btSurvey: TBitBtn;
    btUndo: TBitBtn;
    cbAutoConfirm: TCheckBox;
    cbIsPreAuth: TCheckBox;
    cbPrintReceipt: TCheckBox;
    cbSurveyAtiva: TCheckBox;
    cbSurveyPermitirComentario: TCheckBox;
    cbxCollectInputType: TComboBox;
    cbxInterestType: TComboBox;
    cbxMsgTipo: TComboBox;
    cbxSurveyTipo: TComboBox;
    cbxTypeTransaction: TComboBox;
    cbxPorta: TComboBox;
    cbxCreditType: TComboBox;
    cbIsTyped: TCheckBox;
    edCollectMask: TEdit;
    edCollectTitle: TEdit;
    edEntityIdentifier: TEdit;
    edMsgCancelar: TEdit;
    edMsgConfirmar: TEdit;
    edMsgTitulo: TEdit;
    edNSU: TEdit;
    edSurveyChannel: TEdit;
    edSurveyCreatedAt: TEdit;
    edSurveyCustomerId: TEdit;
    edSurveyDeviceIdentifier: TEdit;
    edSurveyEvent: TEdit;
    edSurveyFlow: TEdit;
    edSurveyOperationType: TEdit;
    edSurveyQuestion: TEdit;
    edSurveyTitulo: TEdit;
    edSurveyId: TEdit;
    edSurveyTransactionId: TEdit;
    edSurveyUserId: TEdit;
    gbEstorno: TGroupBox;
    gbOperacoes: TGroupBox;
    gbPinPad: TGroupBox;
    gbPagamento: TGroupBox;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    mLog: TMemo;
    mmMsgTexto: TMemo;
    mmSurveyContext: TMemo;
    PageControl1: TPageControl;
    seMsgTimeout: TSpinEdit;
    seSurveyMax: TSpinEdit;
    seSurveyMin: TSpinEdit;
    seTimeOut: TSpinEdit;
    seValor: TEdit;
    seInstallment: TSpinEdit;
    TabSheetColeta: TTabSheet;
    TabSheetMensagem: TTabSheet;
    TabSheetPesquisa: TTabSheet;
    procedure btAbortarClick(Sender: TObject);
    procedure btColetarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btEnviarEstornoClick(Sender: TObject);
    procedure btEnviarTransPagtoClick(Sender: TObject);
    procedure btEnviarMensagemClick(Sender: TObject);
    procedure btSearchPortsClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure btSurveyClick(Sender: TObject);
    procedure btUndoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure seValorChange(Sender: TObject);
    procedure seValorKeyPress(Sender: TObject; var Key: Char);
  private
    fSerial: TBlockSerial;
    fAbortSolicitado: Boolean;
    function ConectarSerial: Boolean;
    function ConfigurarSerial: Boolean;
    function LerRespostaSerial(ATimeOut: Integer): AnsiString;
    procedure Log(const Info: String);
    procedure LogSerialFrame(const Frame: AnsiString);
    function EnviarPayloadSerial(const APayload: String; ALimparAbort: Boolean = True): String;
    function GetEntityIdentifier: String;
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

type
  TAbortThread = class(TThread)
  private
    FOwner: TFormMain;
    FPayload: String;
    procedure SendAbortPayload;
  protected
    procedure Execute; override;
  public
    constructor Create(AOwner: TFormMain; const APayload: String);
  end;

constructor TAbortThread.Create(AOwner: TFormMain; const APayload: String);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FOwner := AOwner;
  FPayload := APayload;
end;

procedure TAbortThread.SendAbortPayload;
begin
  if Assigned(FOwner) then
    FOwner.EnviarPayloadSerial(FPayload, False);
  if Assigned(FOwner) then
    FOwner.fAbortSolicitado := False;
end;

procedure TAbortThread.Execute;
begin
  Sleep(150);
  if Assigned(FOwner) then
    Synchronize(SendAbortPayload);
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  J: TDPtypeTransaction;
  H: TDPcreditType;
  I: TDPinterestType;
  s: String;
begin
  fSerial := TBlockSerial.Create;
  fSerial.RaiseExcept := False;
  fAbortSolicitado := False;
  Randomize;

  cbxTypeTransaction.Items.Clear;
  for J := Low(TDPtypeTransaction) to High(TDPtypeTransaction) do
  begin
    s := GetEnumName(TypeInfo(TDPtypeTransaction), Integer(J));
    Delete(s, 1, 3);
    cbxTypeTransaction.Items.Add(s);
  end;
  cbxTypeTransaction.ItemIndex := 2;

  for H := Low(TDPcreditType) to High(TDPcreditType) do
  begin
    s := GetEnumName(TypeInfo(TDPcreditType), Integer(H));
    Delete(s, 1, 3);
    cbxCreditType.Items.Add(s);
  end;
  cbxCreditType.ItemIndex := 0;

  for I := Low(TDPinterestType) to High(TDPinterestType) do
  begin
    s := GetEnumName(TypeInfo(TDPinterestType), Integer(I));
    Delete(s, 1, 3);
    cbxInterestType.Items.Add(s);
  end;
  cbxInterestType.ItemIndex := 0;

  cbxCollectInputType.Items.Clear;
  cbxCollectInputType.Items.Add('NUMERIC');
  cbxCollectInputType.Items.Add('NUMERIC_PASSWORD');
  cbxCollectInputType.Items.Add('PASSWORD');
  cbxCollectInputType.Items.Add('EMAIL');
  cbxCollectInputType.Items.Add('TEXT');
  cbxCollectInputType.ItemIndex := 4;

  cbxMsgTipo.Items.Clear;
  cbxMsgTipo.Items.Add('TEXT');
  cbxMsgTipo.Items.Add('QR_CODE');
  cbxMsgTipo.ItemIndex := 0;

  cbxSurveyTipo.Items.Clear;
  cbxSurveyTipo.Items.Add('GENERIC');
  cbxSurveyTipo.Items.Add('NPS');
  cbxSurveyTipo.Items.Add('CSAT');
  cbxSurveyTipo.Items.Add('CES');
  cbxSurveyTipo.ItemIndex := 0;

  btSearchPortsClick(Sender);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  fSerial.Free;
end;

function TFormMain.ConectarSerial: Boolean;
var
  porta: String;
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
  tentativas := Max(Trunc(ATimeOut / seTimeOut.Value), 1);

  b := fSerial.RecvByte(seTimeOut.Value);
  Log(Format('  ret: %d', [b]));
  if (b = NAK) then
    Log('  NAK - comando invalido')
  else if (b <> ACK) then
    Log('  Erro na resposta');

  if not (b = ACK) then
    Exit;

  Log('  ACK - comando ok');

  i := 0;
  TemDados := False;
  while not TemDados and (i < tentativas) do
  begin
    Application.ProcessMessages;
    if fAbortSolicitado then
    begin
      Log('  Abort solicitado. Interrompendo espera...');
      Exit;
    end;
    TemDados := fSerial.CanReadEx(seTimeOut.Value);
    Sleep(CSleepWait);
    Inc(i);
    Log('  ' + Format('%d/%d', [i, tentativas]));
  end;

  if TemDados then
  begin
    Log('  Lendo dados da resposta:');
    Result := fSerial.RecvPacket(seTimeOut.Value * 2);
    LogSerialFrame(Result);
  end;
end;

procedure TFormMain.Log(const Info: String);
begin
  mLog.Lines.Add(Info);
end;

procedure TFormMain.LogSerialFrame(const Frame: AnsiString);
var
  i: Integer;
  line: String;
  b: Byte;
begin
  line := '';
  for i := 1 to Length(Frame) do
  begin
    b := Ord(Frame[i]);
    if (b >= $20) and (b < $7F) then
      line := line + Char(Chr(b))
    else
      line := line + Format('<%02x>', [b]);
  end;
  mLog.Lines.Add(line);
end;

function TFormMain.GetEntityIdentifier: String;
begin
  Result := Trim(edEntityIdentifier.Text);
end;

function TFormMain.EnviarPayloadSerial(const APayload: String; ALimparAbort: Boolean): String;
var
  dpMessage: TDPSerialMessage;
  s: AnsiString;
begin
  Result := '';
  if ALimparAbort then
    fAbortSolicitado := False;

  if not ConectarSerial then
    Exit;

  try
    if not ConfigurarSerial then
      Exit;

    Log('- Conteudo (payload) -');
    Log(APayload);

    dpMessage := TDPSerialMessage.Create;
    try
      dpMessage.PayLoad := APayload;
      s := dpMessage.message;
      Log('- Mensagem Serial -');
      LogSerialFrame(s);
      fSerial.SendString(s);
      Log(Format('  Serial.LastError: %d', [fSerial.LastError]));
      if (fSerial.LastError <> 0) then
        Exit;

      s := LerRespostaSerial(seTimeOut.Value * 100);
      if fAbortSolicitado then
      begin
        Log('  Abort solicitado. Encerrando operacao...');
        Exit;
      end;

      try
        dpMessage.message := s;
        Result := dpMessage.PayLoad;
      except
        on E: Exception do
        begin
          Log(E.Message);
          Result := Utf8RawAnsiToString(DecodeBase64(s));
        end;
      end;

      Log('- Resposta -');
      Log(Result);
    finally
      dpMessage.Free;
    end;
  finally
    fSerial.CloseSocket;
  end;
end;

procedure TFormMain.btSearchPortsClick(Sender: TObject);
var
  s: String;
begin
  Log('Procurando Portas...');
  cbxPorta.Items.Clear;
  s := GetSerialPortNames;
  Log('  ' + s);
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
  Payload, JSonResp: String;
begin
  fAbortSolicitado := False;
  Log('-- Enviar transacao de pagamento --');

  ReqTrans := TDPPayloadRequestTransaction.Create;
  try
{$IF CompilerVersion >= 20}
    ReqTrans.amount := StrToFloatDef(StringReplace(Trim(seValor.Text), ',',
      FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);
{$ELSE}
    ReqTrans.amount := StrToFloatDef(StringReplace(Trim(seValor.Text), ',',
      DecimalSeparator, [rfReplaceAll]), 0);
{$IFEND}
    ReqTrans.creditType := TDPcreditType(cbxCreditType.ItemIndex);
    ReqTrans.installment := seInstallment.Value;
    ReqTrans.typeTransaction := TDPtypeTransaction(cbxTypeTransaction.ItemIndex);
    ReqTrans.interestType := TDPinterestType(cbxInterestType.ItemIndex);
    ReqTrans.isPreAuth := cbIsPreAuth.Checked;
    ReqTrans.isTyped := cbIsTyped.Checked;
    ReqTrans.printReceipt := cbPrintReceipt.Checked;
    ReqTrans.autoConfirm := cbAutoConfirm.Checked;
    ReqTrans.entityIdentifier := GetEntityIdentifier;
    Payload := ReqTrans.AsJSON;
  finally
    ReqTrans.Free;
  end;

  JSonResp := EnviarPayloadSerial(Payload);
  if (Trim(JSonResp) = '') then
    Exit;

  ResTrans := TDPPayloadResponseTransaction.Create;
  try
    ResTrans.AsJSON := JSonResp;
    Log('-- Dados da resposta da transacao --');
    Log('Resultado: ' + BoolToStr(ResTrans.result_, True));
    Log('Mensagem: ' + ResTrans.message);
    Log('Valor: ' + FormatFloat('0.00', ResTrans.amount));
    if (Trim(ResTrans.authCode) <> '') then
      Log('Autorizacao: ' + ResTrans.authCode);
    if (Trim(ResTrans.brand) <> '') then
      Log('Bandeira: ' + ResTrans.brand);
    Log('NSU: ' + ResTrans.nsu);
    Log('NSU adquirente: ' + ResTrans.nsuAcquirer);
    Log('PAN mascarado: ' + ResTrans.panMasked);
    Log('Data: ' + FormatDateTime('dd/mm/yy hh:nn:ss', ResTrans.date));
    Log('Tipo captura: ' + typeCardToString(ResTrans.typeCard));
    Log('Resultado final: ' + finalResultToString(ResTrans.finalResult));
    Log('Codigo retorno: ' + IntToStr(ResTrans.codeResult));
    if (Trim(ResTrans.serialNumber) <> '') then
      Log('Serial terminal: ' + ResTrans.serialNumber);
    Log('ForceReset: ' + BoolToStr(ResTrans.forceReset, True));
    Log('- Comprovante -');
    Log(StringReplace(ResTrans.receiptContent, '@', sLineBreak, [rfReplaceAll]));
    edNSU.Text := ResTrans.nsu;
  finally
    ResTrans.Free;
  end;
end;

procedure TFormMain.btEnviarEstornoClick(Sender: TObject);
var
  ReqRev: TDPPayLoadRequestReversal;
  ResRev: TDPPayLoadResponseReversal;
  Payload, JSonResp: String;
begin
  fAbortSolicitado := False;
  Log('-- Enviar estorno (cancel_transaction) --');

  ReqRev := TDPPayLoadRequestReversal.Create;
  try
    ReqRev.nsu := Trim(edNSU.Text);
    ReqRev.entityIdentifier := GetEntityIdentifier;
    Payload := ReqRev.AsJSON;
  finally
    ReqRev.Free;
  end;

  JSonResp := EnviarPayloadSerial(Payload);
  if (Trim(JSonResp) = '') then
    Exit;

  ResRev := TDPPayLoadResponseReversal.Create;
  try
    ResRev.AsJSON := JSonResp;
    Log('-- Dados da resposta --');
    Log('Resultado: ' + BoolToStr(ResRev.result_, True));
    Log('Resultado final: ' + finalResultToString(ResRev.finalResult));
    Log('Mensagem: ' + ResRev.message);
    Log('ForceReset: ' + BoolToStr(ResRev.forceReset, True));
    Log('- Comprovante -');
    Log(StringReplace(ResRev.receiptContent, '@', sLineBreak, [rfReplaceAll]));
  finally
    ResRev.Free;
  end;
end;

procedure TFormMain.btConfirmarClick(Sender: TObject);
var
  Req: TDPPayloadRequestConfirmTransaction;
  Res: TDPPayLoadResponseReversal;
  Payload, JSonResp: String;
begin
  fAbortSolicitado := False;
  Log('-- Confirmar (confirmtransaction) --');
  Req := TDPPayloadRequestConfirmTransaction.Create;
  try
    Req.nsu := Trim(edNSU.Text);
    Req.entityIdentifier := GetEntityIdentifier;
    Payload := Req.AsJSON;
  finally
    Req.Free;
  end;

  JSonResp := EnviarPayloadSerial(Payload);
  if (Trim(JSonResp) = '') then
    Exit;

  Res := TDPPayLoadResponseReversal.Create;
  try
    Res.AsJSON := JSonResp;
    Log('-- Resposta confirmacao --');
    Log('Resultado: ' + BoolToStr(Res.result_, True));
    Log('Resultado final: ' + finalResultToString(Res.finalResult));
    Log('Mensagem: ' + Res.message);
  finally
    Res.Free;
  end;
end;

procedure TFormMain.btUndoClick(Sender: TObject);
var
  Req: TDPPayloadRequestUndoTransaction;
  Res: TDPPayLoadResponseReversal;
  Payload, JSonResp: String;
begin
  fAbortSolicitado := False;
  Log('-- Desfazer (undotransaction) --');
  Req := TDPPayloadRequestUndoTransaction.Create;
  try
    Req.nsu := Trim(edNSU.Text);
    Req.entityIdentifier := GetEntityIdentifier;
    Payload := Req.AsJSON;
  finally
    Req.Free;
  end;

  JSonResp := EnviarPayloadSerial(Payload);
  if (Trim(JSonResp) = '') then
    Exit;

  Res := TDPPayLoadResponseReversal.Create;
  try
    Res.AsJSON := JSonResp;
    Log('-- Resposta desfazimento --');
    Log('Resultado: ' + BoolToStr(Res.result_, True));
    Log('Resultado final: ' + finalResultToString(Res.finalResult));
    Log('Mensagem: ' + Res.message);
  finally
    Res.Free;
  end;
end;

procedure TFormMain.btAbortarClick(Sender: TObject);
var
  Req: TDPPayloadRequestAbort;
  Payload: String;
begin
  if fAbortSolicitado then
    Exit;

  Log('-- Abortar (abort) --');
  fAbortSolicitado := True;
  try
    fSerial.CloseSocket;
  except
  end;

  Req := TDPPayloadRequestAbort.Create;
  try
    Req.entityIdentifier := GetEntityIdentifier;
    Payload := Req.AsJSON;
  finally
    Req.Free;
  end;

{$IF CompilerVersion >= 21}
  TAbortThread.Create(Self, Payload).Start;
{$ELSE}
  TAbortThread.Create(Self, Payload).Resume;
{$IFEND}
end;

procedure TFormMain.btColetarClick(Sender: TObject);
var
  Req: TDPPayloadRequestCollect;
  Payload: String;
begin
  fAbortSolicitado := False;
  Log('-- Coleta (collect) --');
  Req := TDPPayloadRequestCollect.Create;
  try
    Req.title := Trim(edCollectTitle.Text);
    Req.mask := Trim(edCollectMask.Text);
    if (cbxCollectInputType.ItemIndex >= 0) then
      Req.inputType := StringToCollectInputType(cbxCollectInputType.Items[cbxCollectInputType.ItemIndex]);
    Req.entityIdentifier := GetEntityIdentifier;
    Payload := Req.AsJSON;
  finally
    Req.Free;
  end;

  EnviarPayloadSerial(Payload);
end;

procedure TFormMain.btEnviarMensagemClick(Sender: TObject);
var
  Req: TDPPayloadRequestMessage;
  Payload: String;
begin
  fAbortSolicitado := False;
  Log('-- Mensagem (message) --');
  Req := TDPPayloadRequestMessage.Create;
  try
    if (cbxMsgTipo.ItemIndex >= 0) then
      Req.typeMessage := StringToMessageType(cbxMsgTipo.Items[cbxMsgTipo.ItemIndex])
    else
      Req.typeMessage := dpmtTEXT;
    Req.title := Trim(edMsgTitulo.Text);
    Req.message := Trim(mmMsgTexto.Text);
    Req.confirmMessage := Trim(edMsgConfirmar.Text);
    Req.cancelMessage := Trim(edMsgCancelar.Text);
    Req.timeout := seMsgTimeout.Value;
    Req.entityIdentifier := GetEntityIdentifier;
    Payload := Req.AsJSON;
  finally
    Req.Free;
  end;

  EnviarPayloadSerial(Payload);
end;

procedure TFormMain.btSurveyClick(Sender: TObject);
var
  Req: TDPPayloadRequestSurvey;
  Payload: String;
  dtUtc: TDateTime;
  surveyTipo: String;
  surveyId: String;
begin
  fAbortSolicitado := False;
  Log('-- Pesquisa (survey) --');
  Req := TDPPayloadRequestSurvey.Create;
  try
    Req.title := Trim(edSurveyTitulo.Text);
    Req.question := Trim(edSurveyQuestion.Text);
    Req.scaleMin := seSurveyMin.Value;
    Req.scaleMax := seSurveyMax.Value;
    surveyTipo := '';
    if (cbxSurveyTipo.ItemIndex >= 0) then
      surveyTipo := Trim(cbxSurveyTipo.Items[cbxSurveyTipo.ItemIndex]);
    if (surveyTipo <> '') and (UpperCase(surveyTipo) <> 'GENERIC') then
      Req.surveyType := surveyTipo
    else
      Req.surveyType := '';
    surveyId := Trim(edSurveyId.Text);
    if (Length(surveyId) >= 36) then
      Req.surveyId := surveyId
    else
      Req.surveyId := '';
    Req.allowComment := cbSurveyPermitirComentario.Checked;
    Req.active := cbSurveyAtiva.Checked;
    Req.createdAt := Trim(edSurveyCreatedAt.Text);
    if (Req.createdAt = '') then
    begin
      dtUtc := Now;
      Req.createdAt := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss"Z"', dtUtc);
    end;
    Req.userId := Trim(edSurveyUserId.Text);
    Req.customerId := Trim(edSurveyCustomerId.Text);
    Req.transactionId := Trim(edSurveyTransactionId.Text);
    Req.operationType := Trim(edSurveyOperationType.Text);
    Req.channel := Trim(edSurveyChannel.Text);
    Req.deviceIdentifier := Trim(edSurveyDeviceIdentifier.Text);
    Req.flow := Trim(edSurveyFlow.Text);
    Req.event := Trim(edSurveyEvent.Text);
    Req.contextJSON := Trim(mmSurveyContext.Text);
    Req.entityIdentifier := GetEntityIdentifier;
    Payload := Req.AsJSON;
  finally
    Req.Free;
  end;

  Log('- Payload (survey) -');
  Log(Payload);
  EnviarPayloadSerial(Payload);
end;

function CharIsNum(const C: Char): Boolean;
begin
  Result := C in ['0'..'9'];
end;

function OnlyNumber(const AValue: String): String;
var
  I, LenValue: Integer;
begin
  Result := '';
  LenValue := Length(AValue);
  for I := 1 to LenValue do
  begin
    if CharIsNum(AValue[I]) then
      Result := Result + AValue[I];
  end;
end;

procedure TFormMain.seValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, #27]) then
    Key := #0;
end;

procedure TFormMain.seValorChange(Sender: TObject);
var
  aValor: Double;
begin
  aValor := StrToIntDef(OnlyNumber(seValor.Text), 0) / 100;
  seValor.Text := FormatFloat('0.00', aValor);
  seValor.SelStart := Length(seValor.Text);
end;

end.
