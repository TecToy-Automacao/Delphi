unit Comanda.Lib;

interface

uses
  System.Classes,
  System.StrUtils,
  System.SysUtils;

type
  TLib = class
    private
      class var FUser   : string;
      class var FPass   : string;
      class var FServer : string;
      class var FPort   : integer;
      class var FBaseUrl: string;

      class function  GetBaseUrl: string; static;
      class procedure SetBaseUrl(const Value: string); static;
    public
      class property User    : string  read FUser      write FUser;
      class property Pass    : string  read FPass      write FPass;
      class property Server  : string  read FServer    write FServer;
      class property Port    : integer read FPort      write FPort;
      class property BaseUrl : string  read GetBaseUrl write SetBaseUrl;
  end;

implementation

{ TLib }

class function TLib.GetBaseUrl: string;
begin
  Result := Format('http://%s:%s/', [FServer, FPort.ToString]);
end;

class procedure TLib.SetBaseUrl(const Value: string);
begin
  FBaseUrl := Value;
end;

end.
