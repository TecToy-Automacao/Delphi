unit DirectPin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  ACK = $006;
  NAK = $015;
  SYN = $016;
  ETB = $017;

type

  TDPtypeTransaction = (dptNONE, dptDEBIT, dptCREDIT, dptVOUCHER, dptPIX);
  TDPcreditType = (dpcNO_INSTALLMENT, dpcINSTALLMENT);
  TDPinterestType = (dpiMERCHANT, dpiISSUER);
  TDPTypeCard = (dptcNONE, dptcMAGNETIC, dptcEMV_CONTACT, dptcCONTACTLESS_STRIPE, dptcCONTACTLESS_EMV, dptcTYPED);
  TDPFinalResult = (dpfrAPPROVED, dpfrPENDING, dpfrREPROVED_HOST, dpfrREPROVED_CARD, dpfrCANCELED, dpfrABORTED, dpfrCONNECTION_ERROR, dpfrCARD_READ_ERROR, dpfrCONFIRMED, dpfrUNDONE);
  TDPCollectInputType = (dpcitNUMERIC, dpcitNUMERIC_PASSWORD, dpcitPASSWORD, dpcitEMAIL, dpcitTEXT);
  TDPMessageType = (dpmtTEXT, dpmtQR_CODE);

  { TDPPayloadTransacao }

  { TDPPayloadRequestTransaction }

  TDPPayloadRequestTransaction = class
  private
    Famount: Double;
    FautoConfirm: Boolean;
    FcreditType: TDPcredittype;
    FentityIdentifier: String;
    Finstallment: Integer;
    FinterestType: TDPinterestType;
    FisPreAuth: Boolean;
    FisTyped: Boolean;
    FprintReceipt: Boolean;
    FtypeTransaction: TDPtypeTransaction;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;

    property type_: String read Ftype_;
    property amount: Double read Famount write Famount;
    property typeTransaction: TDPtypeTransaction read FtypeTransaction write FtypeTransaction;
    property creditType: TDPcreditType read FcreditType write FcreditType;
    property installment: Integer read Finstallment write Finstallment;
    property isTyped: Boolean read FisTyped write FisTyped;
    property isPreAuth: Boolean read FisPreAuth write FisPreAuth;
    property autoConfirm: Boolean read FautoConfirm write FautoConfirm;
    property interestType: TDPinterestType read FinterestType write FinterestType;
    property printReceipt: Boolean read FprintReceipt write FprintReceipt;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPPayloadResponseTransaction }

  TDPPayloadResponseTransaction = class
  private
    Famount: Double;
    FauthCode: String;
    Fbrand: String;
    FcodeResult: Integer;
    Fdate: TDateTime;
    FfinalResult: TDPFinalResult;
    FforceReset: Boolean;
    Fmessage: String;
    Fnsu: String;
    FnsuAcquirer: String;
    FpanMasked: String;
    FreceiptContent: String;
    Fresult_: Boolean;
    FserialNumber: String;
    Ftype: String;
    FtypeCard: TDPTypeCard;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;

    property type_: String read Ftype_;
    property result_: Boolean read Fresult_ write Fresult_;
    property message: String read Fmessage write Fmessage;
    property amount: Double read Famount write Famount;
    property nsu: String read Fnsu write Fnsu;
    property nsuAcquirer: String read FnsuAcquirer write FnsuAcquirer;
    property panMasked: String read FpanMasked write FpanMasked;
    property date: TDateTime read Fdate write Fdate;
    property typeCard: TDPTypeCard read FtypeCard write FtypeCard;
    property finalResult: TDPFinalResult read FfinalResult write FfinalResult;
    property codeResult: Integer read FcodeResult write FcodeResult;
    property authCode: String read FauthCode write FauthCode;
    property brand: String read Fbrand write Fbrand;
    property serialNumber: String read FserialNumber write FserialNumber;
    property typeResult: String read Ftype write Ftype;
    property receiptContent: String read FreceiptContent write FreceiptContent;
    property forceReset: Boolean read FforceReset write FforceReset;
  end;

  { TDPPayLoadRequestReversal }

  TDPPayLoadRequestReversal = class
  private
    FentityIdentifier: String;
    Fnsu: String;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;

    property type_: String read Ftype_;
    property nsu: String read Fnsu write Fnsu;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPPayLoadResponseReversal }

  TDPPayLoadResponseReversal = class
  private
    FfinalResult: TDPFinalResult;
    FforceReset: Boolean;
    Fmessage: String;
    FreceiptContent: String;
    Fresult_: Boolean;
    Ftype: String;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;

    property type_: String read Ftype_;
    property result_: Boolean read Fresult_ write Fresult_;
    property message: String read Fmessage write Fmessage;
    property finalResult: TDPFinalResult read FfinalResult write FfinalResult;
    property typeResult: String read Ftype write Ftype;
    property receiptContent: String read FreceiptContent write FreceiptContent;
    property forceReset: Boolean read FforceReset write FforceReset;
  end;

  { TDPPayloadRequestConfirmTransaction }

  TDPPayloadRequestConfirmTransaction = class
  private
    FentityIdentifier: String;
    Fnsu: String;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;
    property type_: String read Ftype_;
    property nsu: String read Fnsu write Fnsu;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPPayloadRequestUndoTransaction }

  TDPPayloadRequestUndoTransaction = class
  private
    FentityIdentifier: String;
    Fnsu: String;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;
    property type_: String read Ftype_;
    property nsu: String read Fnsu write Fnsu;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPPayloadRequestAbort }

  TDPPayloadRequestAbort = class
  private
    FentityIdentifier: String;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;
    property type_: String read Ftype_;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPPayloadRequestCollect }

  TDPPayloadRequestCollect = class
  private
    FentityIdentifier: String;
    FinputType: TDPCollectInputType;
    Fmask: String;
    Ftitle: String;
    Ftype_: String;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;
    property type_: String read Ftype_;
    property title: String read Ftitle write Ftitle;
    property mask: String read Fmask write Fmask;
    property inputType: TDPCollectInputType read FinputType write FinputType;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPPayloadRequestMessage }

  TDPPayloadRequestMessage = class
  private
    FcancelMessage: String;
    FconfirmMessage: String;
    FentityIdentifier: String;
    Fmessage: String;
    Ftimeout: Integer;
    Ftitle: String;
    Ftype_: String;
    FtypeMessage: TDPMessageType;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;
    property type_: String read Ftype_;
    property typeMessage: TDPMessageType read FtypeMessage write FtypeMessage;
    property title: String read Ftitle write Ftitle;
    property message: String read Fmessage write Fmessage;
    property confirmMessage: String read FconfirmMessage write FconfirmMessage;
    property cancelMessage: String read FcancelMessage write FcancelMessage;
    property timeout: Integer read Ftimeout write Ftimeout;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPPayloadRequestSurvey }

  TDPPayloadRequestSurvey = class
  private
    Factive: Boolean;
    FallowComment: Boolean;
    Fchannel: String;
    FcontextJSON: String;
    FcreatedAt: String;
    FcustomerId: String;
    FdeviceIdentifier: String;
    FentityIdentifier: String;
    Fevent: String;
    Fflow: String;
    FoperationType: String;
    Fquestion: String;
    FscaleMax: Integer;
    FscaleMin: Integer;
    FsurveyId: String;
    FsurveyType: String;
    Ftitle: String;
    FtransactionId: String;
    Ftype_: String;
    FuserId: String;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
  public
    constructor Create;
    procedure Clear;
    property AsJSON: String read GetAsJSON write SetAsJSON;
    property type_: String read Ftype_;
    property surveyType: String read FsurveyType write FsurveyType;
    property title: String read Ftitle write Ftitle;
    property question: String read Fquestion write Fquestion;
    property scaleMin: Integer read FscaleMin write FscaleMin;
    property scaleMax: Integer read FscaleMax write FscaleMax;
    property surveyId: String read FsurveyId write FsurveyId;
    property allowComment: Boolean read FallowComment write FallowComment;
    property active: Boolean read Factive write Factive;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property userId: String read FuserId write FuserId;
    property customerId: String read FcustomerId write FcustomerId;
    property transactionId: String read FtransactionId write FtransactionId;
    property operationType: String read FoperationType write FoperationType;
    property channel: String read Fchannel write Fchannel;
    property deviceIdentifier: String read FdeviceIdentifier write FdeviceIdentifier;
    property flow: String read Fflow write Fflow;
    property event: String read Fevent write Fevent;
    property contextJSON: String read FcontextJSON write FcontextJSON;
    property entityIdentifier: String read FentityIdentifier write FentityIdentifier;
  end;

  { TDPSerialMessage }

  TDPSerialMessage = class
  private
    FPayLoad: String;

    function GetMessage: AnsiString;
    procedure SetMessage(AValue: AnsiString);
  protected

  public
    constructor Create;
    procedure Clear;

    property message: AnsiString read GetMessage write SetMessage;
    property PayLoad: String read FPayLoad write FPayLoad;
    function Checksum(const AString: AnsiString): AnsiString;
  end;

  function StringCrcCCITT(const s: AnsiString; initial:Word=0; polynomial:Word=$1021): Word;

  function typeTransactionToString(AtypeTransaction: TDPtypeTransaction): String;
  function StringTotypeTransaction(const AStr: String): TDPtypeTransaction;

  function creditTypeToString(AcreditType: TDPcreditType): String;
  function StringTocreditType(const AStr: String): TDPcreditType;

  function interestTypeToString(AinterestType: TDPinterestType): String;
  function StringTointerestType(const AStr: String): TDPinterestType;

  function finalResultToString(AfinalResult: TDPFinalResult): String;
  function StringTofinalResult(const AStr: String): TDPFinalResult;

  function typeCardToString(AtypeCard: TDPTypeCard): String;
  function StringTotypeCard(const AStr: String): TDPTypeCard;

  function collectInputTypeToString(AInputType: TDPCollectInputType): String;
  function StringToCollectInputType(const AStr: String): TDPCollectInputType;

  function messageTypeToString(AMessageType: TDPMessageType): String;
  function StringToMessageType(const AStr: String): TDPMessageType;

implementation

uses
  fpjson, DateUtils,
  base64;

function JsonTryGetString(const o: TJSONObject; const AName: String; const ADefault: String = ''): String;
begin
  Result := ADefault;
  if (not Assigned(o)) or (o.IndexOfName(AName) < 0) then
    Exit;
  try
    Result := o.Strings[AName];
  except
    Result := ADefault;
  end;
end;

function JsonTryGetBool(const o: TJSONObject; const AName: String; const ADefault: Boolean = False): Boolean;
begin
  Result := ADefault;
  if (not Assigned(o)) or (o.IndexOfName(AName) < 0) then
    Exit;
  try
    Result := o.Booleans[AName];
  except
    Result := ADefault;
  end;
end;

function JsonTryGetInt(const o: TJSONObject; const AName: String; const ADefault: Integer = 0): Integer;
begin
  Result := ADefault;
  if (not Assigned(o)) or (o.IndexOfName(AName) < 0) then
    Exit;
  try
    Result := o.Integers[AName];
  except
    Result := ADefault;
  end;
end;

function JsonTryGetInt64(const o: TJSONObject; const AName: String; const ADefault: Int64 = 0): Int64;
begin
  Result := ADefault;
  if (not Assigned(o)) or (o.IndexOfName(AName) < 0) then
    Exit;
  try
    Result := o.Int64s[AName];
  except
    Result := ADefault;
  end;
end;

// https://forum.lazarus.freepascal.org/index.php/topic,38279.msg259717.html#msg259717
function StringCrcCCITT(const s: AnsiString; initial:Word=0; polynomial:Word=$1021): Word;
var
  crc: Cardinal;
  len, I, J: Integer;
  b: Byte;
  bit, c15: Boolean;
begin
  len := Length(s);
  crc := initial; // initial value
  for I := 1 to len do
  begin
    b := Byte(s[I]);
    for J := 0 to 7 do
    begin
      bit := (((b shr (7-J)) and 1) = 1);
      c15 := (((crc shr 15) and 1) = 1);
      crc := crc shl 1;
      if ((c15 xor bit)) then
        crc := crc xor polynomial;
    end;
  end;
  Result := crc and $ffff;
end;

function typeTransactionToString(AtypeTransaction: TDPtypeTransaction): String;
begin
  case AtypeTransaction of
    dptDEBIT: Result := 'DEBIT';
    dptCREDIT: Result := 'CREDIT';
    dptVOUCHER: Result := 'VOUCHER';
    dptPIX: Result := 'PIX';
  else
    Result := 'NONE';
  end;
end;

function StringTotypeTransaction(const AStr: String): TDPtypeTransaction;
var
  s: String;
begin
  s := trim(UpperCase(AStr));
  if (s = 'DEBIT') then
    Result := dptDEBIT
  else if (s = 'CREDIT') then
    Result := dptCREDIT
  else if (s = 'VOUCHER') then
    Result := dptVOUCHER
  else if (s = 'PIX') then
    Result := dptPIX
  else
    Result := dptNONE;
end;

function creditTypeToString(AcreditType: TDPcreditType): String;
begin
  case AcreditType of
    dpcINSTALLMENT: Result := 'INSTALLMENT';
  else
    Result := 'NO_INSTALLMENT';
  end;
end;

function StringTocreditType(const AStr: String): TDPcreditType;
var
  s: String;
begin
  s := trim(UpperCase(AStr));
  if (s = 'INSTALLMENT') then
    Result := dpcINSTALLMENT
  else
    Result := dpcNO_INSTALLMENT;
end;

function interestTypeToString(AinterestType: TDPinterestType): String;
begin
  case AinterestType of
    dpiISSUER: Result := 'ISSUER';
  else
    Result := 'MERCHANT';
  end;
end;

function StringTointerestType(const AStr: String): TDPinterestType;
var
  s: String;
begin
  s := trim(UpperCase(AStr));
  if (s = 'ISSUER') then
    Result := dpiISSUER
  else
    Result := dpiMERCHANT;
end;

function finalResultToString(AfinalResult: TDPFinalResult): String;
begin
  case AfinalResult of
    dpfrAPPROVED: Result := 'APPROVED';
    dpfrPENDING: Result := 'PENDING';
    dpfrREPROVED_HOST: Result := 'REPROVED_HOST';
    dpfrREPROVED_CARD: Result := 'REPROVED_CARD';
    dpfrCANCELED: Result := 'CANCELED';
    dpfrABORTED: Result := 'ABORTED';
    dpfrCONNECTION_ERROR: Result := 'CONNECTION_ERROR';
    dpfrCARD_READ_ERROR: Result := 'CARD_READ_ERROR';
    dpfrCONFIRMED: Result := 'CONFIRMED';
    dpfrUNDONE: Result := 'UNDONE';
  else
    Result := 'CONNECTION_ERROR';
  end;
end;

function StringTofinalResult(const AStr: String): TDPFinalResult;
var
  s: String;
begin
  s := Trim(UpperCase(AStr));
  if (s = 'APPROVED') then
    Result := dpfrAPPROVED
  else if (s = 'PENDING') then
    Result := dpfrPENDING
  else if (s = 'REPROVED_HOST') then
    Result := dpfrREPROVED_HOST
  else if (s = 'REPROVED_CARD') then
    Result := dpfrREPROVED_CARD
  else if (s = 'CANCELED') then
    Result := dpfrCANCELED
  else if (s = 'ABORTED') then
    Result := dpfrABORTED
  else if (s = 'CARD_READ_ERROR') then
    Result := dpfrCARD_READ_ERROR
  else if (s = 'CONFIRMED') then
    Result := dpfrCONFIRMED
  else if (s = 'UNDONE') or (s = 'UNDO') then
    Result := dpfrUNDONE
  else
    Result := dpfrCONNECTION_ERROR;
end;

function typeCardToString(AtypeCard: TDPTypeCard): String;
begin
  case AtypeCard of
    dptcMAGNETIC: Result := 'MAGNETIC';
    dptcEMV_CONTACT: Result := 'EMV_CONTACT';
    dptcCONTACTLESS_STRIPE: Result := 'CONTACTLESS_STRIPE';
    dptcCONTACTLESS_EMV: Result := 'CONTACTLESS_EMV';
    dptcTYPED: Result := 'TYPED';
  else
    Result := 'NONE';
  end;
end;

function StringTotypeCard(const AStr: String): TDPTypeCard;
var
  s: String;
begin
  s := Trim(UpperCase(AStr));
  if (s = 'MAGNETIC') then
    Result := dptcMAGNETIC
  else if (s = 'EMV_CONTACT') then
    Result := dptcEMV_CONTACT
  else if (s = 'CONTACTLESS_STRIPE') then
    Result := dptcCONTACTLESS_STRIPE
  else if (s = 'CONTACTLESS_EMV') then
    Result := dptcCONTACTLESS_EMV
  else if (s = 'TYPED') then
    Result := dptcTYPED
  else
    Result := dptcNONE;
end;

function collectInputTypeToString(AInputType: TDPCollectInputType): String;
begin
  case AInputType of
    dpcitNUMERIC: Result := 'NUMERIC';
    dpcitNUMERIC_PASSWORD: Result := 'NUMERIC_PASSWORD';
    dpcitPASSWORD: Result := 'PASSWORD';
    dpcitEMAIL: Result := 'EMAIL';
  else
    Result := 'TEXT';
  end;
end;

function StringToCollectInputType(const AStr: String): TDPCollectInputType;
var
  s: String;
begin
  s := Trim(UpperCase(AStr));
  if (s = 'NUMERIC') then
    Result := dpcitNUMERIC
  else if (s = 'NUMERIC_PASSWORD') then
    Result := dpcitNUMERIC_PASSWORD
  else if (s = 'PASSWORD') then
    Result := dpcitPASSWORD
  else if (s = 'EMAIL') then
    Result := dpcitEMAIL
  else
    Result := dpcitTEXT;
end;

function messageTypeToString(AMessageType: TDPMessageType): String;
begin
  case AMessageType of
    dpmtQR_CODE: Result := 'QR_CODE';
  else
    Result := 'TEXT';
  end;
end;

function StringToMessageType(const AStr: String): TDPMessageType;
var
  s: String;
begin
  s := Trim(UpperCase(AStr));
  if (s = 'QR_CODE') then
    Result := dpmtQR_CODE
  else
    Result := dpmtTEXT;
end;

{ TDPPayloadRequestTransaction }

constructor TDPPayloadRequestTransaction.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestTransaction.Clear;
begin
  Famount := 0;
  FautoConfirm := True;
  FcreditType := dpcNO_INSTALLMENT;
  FentityIdentifier := '';
  Finstallment := 0;
  FinterestType := dpiMERCHANT;
  FisPreAuth := False;
  FisTyped := False;
  FprintReceipt := False;
  FtypeTransaction := dptNONE;
  Ftype_ := 'transaction';
end;

function TDPPayloadRequestTransaction.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('amount', Trunc(amount*100));
    o.Add('typeTransaction', typeTransactionToString(typeTransaction));
    o.Add('creditType', creditTypeToString(creditType));
    o.Add('installment', installment);
    o.Add('isTyped', isTyped);
    o.Add('isPreAuth', isPreAuth);
    o.Add('autoConfirm', autoConfirm);
    o.Add('interestType', interestTypeToString(interestType));
    o.Add('printReceipt', printReceipt);
    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestTransaction.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;

  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    amount := JsonTryGetInt64(o, 'amount', 0) / 100;
    typeTransaction := StringTotypeTransaction(JsonTryGetString(o, 'typeTransaction', 'NONE'));
    creditType := StringTocreditType(JsonTryGetString(o, 'creditType', 'NO_INSTALLMENT'));
    installment := JsonTryGetInt(o, 'installment', 0);
    isTyped := JsonTryGetBool(o, 'isTyped', False);
    isPreAuth := JsonTryGetBool(o, 'isPreAuth', False);
    autoConfirm := JsonTryGetBool(o, 'autoConfirm', True);
    interestType := StringTointerestType(JsonTryGetString(o, 'interestType', 'MERCHANT'));
    printReceipt := JsonTryGetBool(o, 'printReceipt', False);
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');
  finally
    o.Free;
  end;
end;

{ TDPPayloadResponseTransaction }

constructor TDPPayloadResponseTransaction.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadResponseTransaction.Clear;
begin
  Famount := 0;
  FauthCode := '';
  Fbrand := '';
  FcodeResult := 0;
  Fdate := 0;
  FfinalResult := dpfrCONNECTION_ERROR;
  FforceReset := False;
  Fmessage := '';
  Fnsu := '';
  FnsuAcquirer := '';
  FpanMasked := '';
  FreceiptContent := '';
  Fresult_ := False;
  FserialNumber := '';
  Ftype := '';
  FtypeCard := dptcNONE;
  Ftype_ := '';
end;

function TDPPayloadResponseTransaction.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('result', result_);
    o.Add('message', message);
    o.Add('amount', Trunc(amount*100));
    if (Trim(authCode) <> '') then
      o.Add('authCode', authCode);
    if (Trim(brand) <> '') then
      o.Add('brand', brand);
    o.Add('nsu', nsu);
    o.Add('nsuAcquirer', nsuAcquirer);
    o.Add('panMasked', panMasked);
    o.Add('date', DateTimeToUnix(date, False)*1000);
    if (Trim(serialNumber) <> '') then
      o.Add('serialNumber', serialNumber);
    if (Trim(typeResult) <> '') then
      o.Add('type', typeResult);
    o.Add('typeCard', typeCardToString(typeCard));
    o.Add('finalResult', finalResultToString(finalResult));
    o.Add('codeResult', codeResult);
    o.Add('receiptContent', receiptContent);
    o.Add('forceReset', forceReset);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadResponseTransaction.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;

  try
    Ftype_ := JsonTryGetString(o, 'type', '');
    result_ := JsonTryGetBool(o, 'result', False);
    message := JsonTryGetString(o, 'message', '');
    amount := JsonTryGetInt64(o, 'amount', 0) / 100;
    authCode := JsonTryGetString(o, 'authCode', '');
    brand := JsonTryGetString(o, 'brand', '');
    nsu := JsonTryGetString(o, 'nsu', '');
    nsuAcquirer := JsonTryGetString(o, 'nsuAcquirer', '');
    panMasked := JsonTryGetString(o, 'panMasked', '');
    if (o.IndexOfName('date') >= 0) then
      date := UnixToDateTime(Trunc(JsonTryGetInt64(o, 'date', 0) / 1000), False);
    serialNumber := JsonTryGetString(o, 'serialNumber', '');
    typeResult := JsonTryGetString(o, 'type', '');
    typeCard := StringTotypeCard(JsonTryGetString(o, 'typeCard', 'NONE'));
    finalResult := StringTofinalResult(JsonTryGetString(o, 'finalResult', ''));
    codeResult := JsonTryGetInt(o, 'codeResult', 0);
    receiptContent := JsonTryGetString(o, 'receiptContent', '');
    forceReset := JsonTryGetBool(o, 'forceReset', False);
  finally
    o.Free;
  end;
end;

{ TDPPayLoadRequestReversal }

constructor TDPPayLoadRequestReversal.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayLoadRequestReversal.Clear;
begin
  FentityIdentifier := '';
  Fnsu := '';
  Ftype_ := 'cancelTransaction';
end;

function TDPPayLoadRequestReversal.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('nsu', nsu);
    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayLoadRequestReversal.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;

  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    nsu := JsonTryGetString(o, 'nsu', '');
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');
  finally
    o.Free;
  end;
end;

{ TDPPayLoadResponseReversal }

constructor TDPPayLoadResponseReversal.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayLoadResponseReversal.Clear;
begin
  FfinalResult := dpfrCONNECTION_ERROR;
  FforceReset := False;
  Fmessage := '';
  FreceiptContent := '';
  Fresult_ := False;
  Ftype := '';
  Ftype_ := '';
end;

function TDPPayLoadResponseReversal.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('result', result_);
    o.Add('message', message);
    o.Add('finalResult', finalResultToString(finalResult));
    if (Trim(typeResult) <> '') then
      o.Add('type', typeResult);
    o.Add('receiptContent', receiptContent);
    o.Add('forceReset', forceReset);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayLoadResponseReversal.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;

  try
    Ftype_ := JsonTryGetString(o, 'type', '');
    result_ := JsonTryGetBool(o, 'result', False);
    message := JsonTryGetString(o, 'message', '');
    finalResult := StringTofinalResult(JsonTryGetString(o, 'finalResult', ''));
    typeResult := JsonTryGetString(o, 'type', '');
    receiptContent := JsonTryGetString(o, 'receiptContent', '');
    forceReset := JsonTryGetBool(o, 'forceReset', False);
  finally
    o.Free;
  end;
end;

{ TDPPayloadRequestConfirmTransaction }

constructor TDPPayloadRequestConfirmTransaction.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestConfirmTransaction.Clear;
begin
  Ftype_ := 'confirmtransaction';
  Fnsu := '';
  FentityIdentifier := '';
end;

function TDPPayloadRequestConfirmTransaction.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('nsu', nsu);
    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestConfirmTransaction.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;
  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    nsu := JsonTryGetString(o, 'nsu', '');
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');
  finally
    o.Free;
  end;
end;

{ TDPPayloadRequestUndoTransaction }

constructor TDPPayloadRequestUndoTransaction.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestUndoTransaction.Clear;
begin
  Ftype_ := 'undotransaction';
  Fnsu := '';
  FentityIdentifier := '';
end;

function TDPPayloadRequestUndoTransaction.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('nsu', nsu);
    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestUndoTransaction.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;
  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    nsu := JsonTryGetString(o, 'nsu', '');
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');
  finally
    o.Free;
  end;
end;

{ TDPPayloadRequestAbort }

constructor TDPPayloadRequestAbort.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestAbort.Clear;
begin
  Ftype_ := 'abort';
  FentityIdentifier := '';
end;

function TDPPayloadRequestAbort.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestAbort.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;
  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');
  finally
    o.Free;
  end;
end;

{ TDPPayloadRequestCollect }

constructor TDPPayloadRequestCollect.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestCollect.Clear;
begin
  Ftype_ := 'collect';
  Ftitle := '';
  Fmask := '';
  FinputType := dpcitTEXT;
  FentityIdentifier := '';
end;

function TDPPayloadRequestCollect.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('title', title);
    if (Trim(mask) <> '') then
      o.Add('mask', mask);
    o.Add('inputType', collectInputTypeToString(inputType));
    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestCollect.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;
  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    title := JsonTryGetString(o, 'title', '');
    mask := JsonTryGetString(o, 'mask', '');
    inputType := StringToCollectInputType(JsonTryGetString(o, 'inputType', 'TEXT'));
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');
  finally
    o.Free;
  end;
end;

{ TDPPayloadRequestMessage }

constructor TDPPayloadRequestMessage.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestMessage.Clear;
begin
  Ftype_ := 'message';
  FtypeMessage := dpmtTEXT;
  Ftitle := '';
  Fmessage := '';
  FconfirmMessage := '';
  FcancelMessage := '';
  Ftimeout := 0;
  FentityIdentifier := '';
end;

function TDPPayloadRequestMessage.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('typeMessage', messageTypeToString(typeMessage));
    o.Add('title', title);
    if (Trim(message) <> '') then
      o.Add('message', message);
    if (Trim(confirmMessage) <> '') then
      o.Add('confirmMessage', confirmMessage);
    if (Trim(cancelMessage) <> '') then
      o.Add('cancelMessage', cancelMessage);
    if (timeout > 0) then
      o.Add('timeout', timeout);
    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestMessage.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;
  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    typeMessage := StringToMessageType(JsonTryGetString(o, 'typeMessage', 'TEXT'));
    title := JsonTryGetString(o, 'title', '');
    message := JsonTryGetString(o, 'message', '');
    confirmMessage := JsonTryGetString(o, 'confirmMessage', '');
    cancelMessage := JsonTryGetString(o, 'cancelMessage', '');
    timeout := JsonTryGetInt(o, 'timeout', 0);
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');
  finally
    o.Free;
  end;
end;

{ TDPPayloadRequestSurvey }

constructor TDPPayloadRequestSurvey.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestSurvey.Clear;
begin
  Ftype_ := 'survey';
  FsurveyType := '';
  Ftitle := '';
  Fquestion := '';
  FscaleMin := 0;
  FscaleMax := 0;
  FsurveyId := '';
  FallowComment := True;
  Factive := True;
  FcreatedAt := '';
  FuserId := '';
  FcustomerId := '';
  FtransactionId := '';
  FoperationType := '';
  Fchannel := '';
  FdeviceIdentifier := '';
  Fflow := '';
  Fevent := '';
  FcontextJSON := '';
  FentityIdentifier := '';
end;

function TDPPayloadRequestSurvey.GetAsJSON: String;
var
  o: TJSONObject;
  ctx: TJSONData;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    if (Trim(surveyType) <> '') then
      o.Add('surveyType', surveyType);
    if (Trim(title) <> '') then
      o.Add('title', title);
    o.Add('question', question);
    o.Add('scaleMin', scaleMin);
    o.Add('scaleMax', scaleMax);
    if (Trim(surveyId) <> '') then
      o.Add('surveyId', surveyId);
    o.Add('allowComment', allowComment);
    o.Add('active', active);
    if (Trim(createdAt) <> '') then
      o.Add('createdAt', createdAt);
    if (Trim(userId) <> '') then
      o.Add('userId', userId);
    if (Trim(customerId) <> '') then
      o.Add('customerId', customerId);
    if (Trim(transactionId) <> '') then
      o.Add('transactionId', transactionId);
    if (Trim(operationType) <> '') then
      o.Add('operationType', operationType);
    if (Trim(channel) <> '') then
      o.Add('channel', channel);
    if (Trim(deviceIdentifier) <> '') then
      o.Add('deviceIdentifier', deviceIdentifier);
    if (Trim(flow) <> '') then
      o.Add('flow', flow);
    if (Trim(event) <> '') then
      o.Add('event', event);

    if (Trim(contextJSON) <> '') then
    begin
      ctx := GetJSON(contextJSON);
      try
        if Assigned(ctx) then
          o.Add('context', ctx.Clone);
      finally
        ctx.Free;
      end;
    end;

    if (Trim(entityIdentifier) <> '') then
      o.Add('entityIdentifier', entityIdentifier);

    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestSurvey.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
  idx: Integer;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  if not Assigned(o) then
    Exit;
  try
    Ftype_ := JsonTryGetString(o, 'type', Ftype_);
    surveyType := JsonTryGetString(o, 'surveyType', '');
    title := JsonTryGetString(o, 'title', '');
    question := JsonTryGetString(o, 'question', '');
    scaleMin := JsonTryGetInt(o, 'scaleMin', 0);
    scaleMax := JsonTryGetInt(o, 'scaleMax', 0);
    surveyId := JsonTryGetString(o, 'surveyId', '');
    allowComment := JsonTryGetBool(o, 'allowComment', True);
    active := JsonTryGetBool(o, 'active', True);
    createdAt := JsonTryGetString(o, 'createdAt', '');
    userId := JsonTryGetString(o, 'userId', '');
    customerId := JsonTryGetString(o, 'customerId', '');
    transactionId := JsonTryGetString(o, 'transactionId', '');
    operationType := JsonTryGetString(o, 'operationType', '');
    channel := JsonTryGetString(o, 'channel', '');
    deviceIdentifier := JsonTryGetString(o, 'deviceIdentifier', '');
    flow := JsonTryGetString(o, 'flow', '');
    event := JsonTryGetString(o, 'event', '');
    entityIdentifier := JsonTryGetString(o, 'entityIdentifier', '');

    idx := o.IndexOfName('context');
    if (idx >= 0) and Assigned(o.Items[idx]) then
      contextJSON := o.Items[idx].AsJSON;
  finally
    o.Free;
  end;
end;

{ TDPSerialMessage }

constructor TDPSerialMessage.Create;
begin
  inherited;
  Clear;
end;

procedure TDPSerialMessage.Clear;
begin
  FPayLoad := '';
end;

function TDPSerialMessage.Checksum(const AString: AnsiString): AnsiString;
var
  crc: Word;
  hex: String;
begin
  crc := StringCrcCCITT(AString);
  hex := IntToHex(crc, 2);
  Result := chr(StrToInt('$'+copy(hex,1,2))) + chr(StrToInt('$'+copy(hex,3,2)))
end;

function TDPSerialMessage.GetMessage: AnsiString;
var
  s: String;
begin
  s := EncodeStringBase64(PayLoad);
  Result := chr(SYN) + s + Checksum(s) + chr(ETB) ;
end;

procedure TDPSerialMessage.SetMessage(AValue: AnsiString);
var
  s, crc1, crc2: AnsiString;
  le: Integer;
begin
  Clear;
  le := Length(AValue);
  // min: SYN + 1 byte payload + ETB + CRC(2) = 5
  if (le < 5) then
    raise Exception.Create('invalid message ');

  if (ord(AValue[1]) <> SYN) then
    raise Exception.Create('the message does not start with SYN');

  if (ord(AValue[le]) <> ETB) then
    raise Exception.Create('the message does not end with ETB');

  s := copy(AValue, 2, Length(AValue)-4);
  crc1 := copy(AValue, Length(AValue)-2, 2);
  crc2 := Checksum(s);
  if (crc1 <> crc2) then
    raise Exception.Create('message with wrong CRC');

  FPayLoad := DecodeStringBase64(s);
end;

end.

// TODO, verificar Boolean e TDates
