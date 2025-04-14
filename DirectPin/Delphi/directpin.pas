unit DirectPin;

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
    Fmessage_: String;
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
    property message_: String read Fmessage_ write Fmessage_;
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

  { TDPPayLoadRequestReversal }

  TDPPayLoadRequestReversal = class
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

  { TDPPayLoadResponseReversal }

  TDPPayLoadResponseReversal = class
  private
    Fmessage_: String;
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
    property message_: String read Fmessage_ write Fmessage_;
    property receiptContent: String read FreceiptContent write FreceiptContent;
  end;

  { TDPSerialMessage }

  TDPSerialMessage = class
  private
    FPayLoad: String;

    function GetMessage_: AnsiString;
    procedure SetMessage_(AValue: AnsiString);
  protected

  public
    constructor Create;
    procedure Clear;

    property message_: AnsiString read GetMessage_ write SetMessage_;
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
  DateUtils, Math,
  JSons, synacode;

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
    o.Add('type').Value.AsString := type_;
    o.Add('amount').Value.AsInteger := Trunc(RoundTo(amount*100, 0));
    o.Add('typeTransaction').Value.AsString := typeTransactionToString(typeTransaction);
    o.Add('creditType').Value.AsString := creditTypeToString(creditType);
    o.Add('installment').Value.AsInteger := installment;
    o.Add('isTyped').Value.AsBoolean := isTyped;
    o.Add('isPreAuth').Value.AsBoolean := isPreAuth;
    o.Add('interestType').Value.AsString := interestTypeToString(interestType);
    o.Add('printReceipt').Value.AsBoolean := printReceipt;
    Result := o.Stringify;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadRequestTransaction.SetAsJSON(const AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := TJSONObject.Create();
  try
    o.Parse(AValue);
    Ftype_ := o.Values['type'].AsString;
    amount := o.Values['amount'].AsInteger/100;
    typeTransaction := StringTotypeTransaction(o.Values['typeTransaction'].AsString);
    creditType := StringTocreditType(o.Values['creditType'].AsString);
    installment := o.Values['installment'].AsInteger;
    isTyped := o.Values['isTyped'].AsBoolean;
    isPreAuth := o.Values['isPreAuth'].AsBoolean;
    isTyped := o.Values['isTyped'].AsBoolean;
    interestType := StringTointerestType(o.Values['interestType'].AsString);
    printReceipt := o.Values['printReceipt'].AsBoolean;
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
  Fmessage_ := '';
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
    o.Add('type').Value.AsString := type_;
    o.Add('result').Value.AsBoolean := result_;
    o.Add('message').Value.AsString := message_;
    o.Add('amount').Value.AsInteger := Trunc(amount*100);
    o.Add('nsu').Value.AsString := nsu;
    o.Add('nsuAcquirer').Value.AsString := nsuAcquirer;
    o.Add('panMasked').Value.AsString := panMasked;
    o.Add('date').Value.AsInteger := DateTimeToUnix(date)*1000;
    o.Add('typeCard').Value.AsString := typeCard;
    o.Add('finalResult').Value.AsString := finalResult;
    o.Add('codeResult').Value.AsInteger := codeResult;
    o.Add('receiptContent').Value.AsString := receiptContent;
    Result := o.Stringify;
  finally
    o.Free;
  end;
end;

procedure TDPPayloadResponseTransaction.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := TJSONObject.Create;
  try
    o.Parse(AValue);
    Ftype_ := o.Values['type'].AsString;
    result_ := o.Values['result'].AsBoolean;
    message_ := o.Values['message'].AsString;
    amount := o.Values['amount'].AsInteger/100;
    nsu := o.Values['nsu'].AsString;
    nsuAcquirer := o.Values['nsuAcquirer'].AsString;
    panMasked := o.Values['panMasked'].AsString;
    date := UnixToDateTime(Trunc(o.Values['date'].AsInteger/1000));
    typeCard := o.Values['typeCard'].AsString;
    finalResult := o.Values['finalResult'].AsString;
    codeResult := o.Values['codeResult'].AsInteger;
    receiptContent := o.Values['receiptContent'].AsString;
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
  Fnsu := '';
  Ftype_ := 'reversal';
end;

function TDPPayLoadRequestReversal.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type').Value.AsString := type_;
    o.Add('nsu').Value.AsString := nsu;
    Result := o.Stringify;
  finally
    o.Free;
  end;
end;

procedure TDPPayLoadRequestReversal.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := TJSONObject.Create;
  try
    o.Parse(AValue);
    Ftype_ := o.Values['type'].AsString;
    nsu := o.Values['nsu'].AsString;
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
  Fmessage_ := '';
  FreceiptContent := '';
  Fresult_ := False;
  Ftype_ := '';
end;

function TDPPayLoadResponseReversal.GetAsJSON: String;
var
  o: TJSONObject;
begin
  o := TJSONObject.Create;
  try
    o.Add('type').Value.AsString := type_;
    o.Add('result').Value.AsBoolean := result_;
    o.Add('message').Value.AsString := message_;
    o.Add('receiptContent').Value.AsString := receiptContent;
    Result := o.Stringify;
  finally
    o.Free;
  end;
end;

procedure TDPPayLoadResponseReversal.SetAsJSON(AValue: String);
var
  o: TJSONObject;
begin
  Clear;
  o := TJSONObject.Create;
  try
    o.Parse(AValue);
    Ftype_ := o.Values['type'].AsString;
    result_ := o.Values['result'].AsBoolean;
    message_ := o.Values['message'].AsString;
    receiptContent := o.Values['receiptContent'].AsString;
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

function TDPSerialMessage.GetMessage_: AnsiString;
var
  s: String;
begin
  s := EncodeBase64(PayLoad);
  Result := chr(SYN) + s + Checksum(s) + chr(ETB) ;
end;

procedure TDPSerialMessage.SetMessage_(AValue: AnsiString);
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

  FPayLoad := DecodeBase64(s);
end;

end.


// TODO, verificar Boolean e TDates
