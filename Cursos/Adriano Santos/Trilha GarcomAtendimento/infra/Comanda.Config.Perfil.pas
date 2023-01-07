unit Comanda.Config.Perfil;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.UITypes,
  System.UIConsts;

type
  TPerfil = class
    protected
<<<<<<< HEAD
      function String2Hex(const Buffer: AnsiString): string;
      function Hex2String(const Buffer: string): AnsiString;
=======
//      function String2Hex(const Buffer: AnsiString): string;
//      function Hex2String(const Buffer: string): AnsiString;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9
    private
      class var FCOR_PRINCIPAL       : TAlphaColor;
      class var FCOR_SECUNDARIA      : TAlphaColor;
      class var FCOR_TERCIARIA       : TAlphaColor;
      class var FCOR_OCUPADA         : TAlphaColor;
      class var FCOR_LABEL_OCUPADA   : TAlphaColor;
      class var FCOR_LIVRE           : TAlphaColor;
      class var FCOR_LABEL_LIVRE     : TAlphaColor;
      class var FCOR_FONTE_ESMAECIDA : TAlphaColor;
      class var FCOR_FONTE_ATIVA     : TAlphaColor;
    public
      //Cores do Sistema
      class property COR_PRINCIPAL       : TAlphaColor read FCOR_PRINCIPAL        write FCOR_PRINCIPAL;
      class property COR_SECUNDARIA      : TAlphaColor read FCOR_SECUNDARIA       write FCOR_SECUNDARIA;
      class property COR_TERCIARIA       : TAlphaColor read FCOR_TERCIARIA        write FCOR_TERCIARIA;
      class property COR_OCUPADA         : TAlphaColor read FCOR_OCUPADA          write FCOR_OCUPADA;
      class property COR_LABEL_OCUPADA   : TAlphaColor read FCOR_LABEL_OCUPADA    write FCOR_LABEL_OCUPADA;
      class property COR_LIVRE           : TAlphaColor read FCOR_LIVRE            write FCOR_LIVRE;
      class property COR_LABEL_LIVRE     : TAlphaColor read FCOR_LABEL_LIVRE      write FCOR_LABEL_LIVRE;
      class property COR_FONTE_ESMAECIDA : TAlphaColor read FCOR_FONTE_ESMAECIDA  write FCOR_FONTE_ESMAECIDA;
      class property COR_FONTE_ATIVA     : TAlphaColor read FCOR_FONTE_ATIVA      write FCOR_FONTE_ATIVA;

      class procedure InicializarCores;
  end;

implementation

{ TPerfil }

<<<<<<< HEAD
function TPerfil.String2Hex(const Buffer: AnsiString): string;
begin
  SetLength(Result, Length(Buffer) * 2);
  BinToHex(PAnsiChar(Buffer), PChar(Result), Length(Buffer));
end;

function TPerfil.Hex2String(const Buffer: string): AnsiString;
begin
  SetLength(Result, Length(Buffer) div 2);
  HexToBin(PChar(Buffer), PAnsiChar(Result), Length(Result));
end;
=======
//function TPerfil.String2Hex(const Buffer: AnsiString): string;
//begin
//  SetLength(Result, Length(Buffer) * 2);
//  BinToHex(PAnsiChar(Buffer), PChar(Result), Length(Buffer));
//end;
//
//function TPerfil.Hex2String(const Buffer: string): AnsiString;
//begin
//  SetLength(Result, Length(Buffer) div 2);
//  HexToBin(PChar(Buffer), PAnsiChar(Result), Length(Result));
//end;
>>>>>>> 2162eb58de87ca0133b7864ec9c2a5825dca7be9

class procedure TPerfil.InicializarCores;
begin
  {$IFDEF PERFIL_TECTOY}
    FCOR_PRINCIPAL       := StringToAlphacolor('Peru');
    FCOR_SECUNDARIA      := StringToAlphacolor('Seashell');
    FCOR_TERCIARIA       := StringToAlphacolor('Seashell');
    FCOR_OCUPADA         := StringToAlphacolor('Tomato');
    FCOR_LABEL_OCUPADA   := StringToAlphacolor('White');
    FCOR_LIVRE           := StringToAlphacolor('Chartreuse');
    FCOR_LABEL_LIVRE     := StringToAlphacolor('White');
    FCOR_FONTE_ESMAECIDA := StringToAlphacolor('$FF733827');
    FCOR_FONTE_ATIVA     := StringToAlphacolor('White');
  {$ENDIF}

  {$IFDEF PERFIL_TECTOY_BLACK}
    FCOR_PRINCIPAL       := TAlphaColorRec.Black;
    FCOR_SECUNDARIA      := StringToAlphacolor('Seashell');
    FCOR_TERCIARIA       := StringToAlphacolor('Seashell');
    FCOR_OCUPADA         := StringToAlphacolor('Tomato');
    FCOR_LABEL_OCUPADA   := StringToAlphacolor('White');
    FCOR_LIVRE           := StringToAlphacolor('Chartreuse');
    FCOR_LABEL_LIVRE     := StringToAlphacolor('White');
    FCOR_FONTE_ESMAECIDA := StringToAlphacolor('$FF733827');
    FCOR_FONTE_ATIVA     := StringToAlphacolor('White');
  {$ENDIF}

  {$IFDEF PERFIL_AZUL}
    //Cores do Sistema
    FCOR_PRINCIPAL           := $FF3661E9;
    FCOR_SECUNDARIA          := $FFA68477;
    FCOR_TERCIARIA           := TAlphaColorRec.White;

    //Cores das Mesas
    FCOR_OCUPADA             := $FF3661E9;
    FCOR_LABEL_OCUPADA       := TAlphaColorRec.White;
    FCOR_LIVRE               := TAlphaColorRec.White;
    FCOR_LABEL_LIVRE         := TAlphaColorRec.Black;

    FCOR_FONTE_ESMAECIDA     := $FF9D9C9C;
    FCOR_FONTE_ATIVA         := $FF59A19;
  {$ENDIF}

  {$IFDEF PERFIL_LARANJA}
    //Cores do Sistema
    FCOR_PRINCIPAL          := $FF733B27;
    FCOR_SECUNDARIA         := $FFA68477;
    FCOR_TERCIARIA          := TAlphaColorRec.White;

    //Cores das mesas
    FCOR_OCUPADA            := $FFEE6F42;
    FCOR_LABEL_OCUPADA      := $FFD9D0C7;
    FCOR_LIVRE              := $FFD9D0C7;
    FCOR_LABEL_LIVRE        := $FFEE6F42;

    FCOR_FONTE_ESMAECIDA    := $FF9D9C9C;
    FCOR_FONTE_ATIVA        := $FF59A19;
  {$ENDIF}
end;

end.
