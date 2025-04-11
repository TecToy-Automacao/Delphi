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

  { TDPPayloadTransacao }

  { TDPPayloadRequestTransaction }

  TDPPayloadRequestTransaction = class
  private
    Famount: Double;
    FcreditType: TDPcredittype;
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
    property interestType: TDPinterestType read FinterestType write FinterestType;
    property printReceipt: Boolean read FprintReceipt write FprintReceipt;
  end;

  { TDPPayloadResponseTransaction }

  TDPPayloadResponseTransaction = class
  private
    Famount: Double;
    FcodeResult: Integer;
    Fdate: TDateTime;
    FfinalResult: String;
    Fmessage: String;
    Fnsu: String;
    FnsuAcquirer: String;
    FpanMasked: String;
    FreceiptContent: String;
    Fresult_: Boolean;
    FtypeCard: String;
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
    property typeCard: String read FtypeCard write FtypeCard;
    property finalResult: String read FfinalResult write FfinalResult;
    property codeResult: Integer read FcodeResult write FcodeResult;
    property receiptContent: String read FreceiptContent write FreceiptContent;
  end;

  { TTDPayLoadRequestReversal }

  TTDPayLoadRequestReversal = class
  private
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
  end;

  { TTDPayLoadResponseReversal }

  TTDPayLoadResponseReversal = class
  private
    Fmessage: String;
    FreceiptContent: String;
    Fresult_: Boolean;
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
    property receiptContent: String read FreceiptContent write FreceiptContent;
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

implementation

uses
  fpjson, DateUtils,
  base64;

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

{ TDPPayloadRequestTransaction }

constructor TDPPayloadRequestTransaction.Create;
begin
  inherited;
  Clear;
end;

procedure TDPPayloadRequestTransaction.Clear;
begin
  Famount := 0;
  FcreditType := dpcNO_INSTALLMENT;
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
    o.Add('interestType', interestTypeToString(interestType));
    o.Add('printReceipt', printReceipt);
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
  try
    Ftype_ := o.Strings['type'];
    amount := o.Floats['amount'];
    typeTransaction := StringTotypeTransaction(o.Strings['typeTransaction']);
    creditType := StringTocreditType(o.Strings['creditType']);
    installment := o.Integers['installment'];
    isTyped := o.Booleans['isTyped'];
    isPreAuth := o.Booleans['isPreAuth'];
    isTyped := o.Booleans['isTyped'];
    interestType := StringTointerestType(o.Strings['interestType']);
    printReceipt := o.Booleans['printReceipt'];
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
  FcodeResult := 0;
  Fdate := 0;
  FfinalResult := '';
  Fmessage := '';
  Fnsu := '';
  FnsuAcquirer := '';
  FpanMasked := '';
  FreceiptContent := '';
  Fresult_ := False;
  FtypeCard := '';
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
    o.Add('amount', amount);
    o.Add('nsu', nsu);
    o.Add('nsuAcquirer', nsuAcquirer);
    o.Add('panMasked', panMasked);
    o.Add('date', DateTimeToUnix(date, False)*1000);
    o.Add('typeCard', typeCard);
    o.Add('finalResult', finalResult);
    o.Add('codeResult', codeResult);
    o.Add('receiptContent', receiptContent);
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
    Ftype_ := o.Strings['type'];
    result_ := o.Booleans['result'];
    message := o.Strings['message'];
    amount := o.Floats['amount'];
    nsu := o.Strings['nsu'];
    nsuAcquirer := o.Strings['nsuAcquirer'];
    panMasked := o.Strings['panMasked'];
    date := UnixToDateTime(Trunc(o.Int64s['date']/1000), False);
    typeCard := o.Strings['typeCard'];
    finalResult := o.Strings['finalResult'];
    codeResult := o.Integers['codeResult'];
    receiptContent := o.Strings['receiptContent'];
  finally
    o.Free;
  end;
end;

{ TTDPayLoadRequestReversal }

constructor TTDPayLoadRequestReversal.Create;
begin
  inherited;
  Clear;
end;

procedure TTDPayLoadRequestReversal.Clear;
begin
  Fnsu := '';
  Ftype_ := 'reversal';
end;

function TTDPayLoadRequestReversal.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('nsu', nsu);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TTDPayLoadRequestReversal.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  try
    Ftype_ := o.Strings['type'];
    nsu := o.Strings['nsu'];
  finally
    o.Free;
  end;
end;

{ TTDPayLoadResponseReversal }

constructor TTDPayLoadResponseReversal.Create;
begin
  inherited;
  Clear;
end;

procedure TTDPayLoadResponseReversal.Clear;
begin
  Fmessage := '';
  FreceiptContent := '';
  Fresult_ := False;
  Ftype_ := '';
end;

function TTDPayLoadResponseReversal.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type', type_);
    o.Add('result', result_);
    o.Add('message', message);
    o.Add('receiptContent', receiptContent);
    Result := o.AsJSON;
  finally
    o.Free;
  end;
end;

procedure TTDPayLoadResponseReversal.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := GetJSON(AValue) as TJSONObject;
  try
    Ftype_ := o.Strings['type'];
    result_ := o.Booleans['result'];
    message := o.Strings['message'];
    receiptContent := o.Strings['receiptContent'];
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
