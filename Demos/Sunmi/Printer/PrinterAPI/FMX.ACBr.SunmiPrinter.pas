unit FMX.ACBr.SunmiPrinter;

interface

Uses
{$IFDEF ANDROID}
  Androidapi.AppGlue,
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI.Net,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Hardware,
  Androidapi.JNI.Embarcadero,
  Androidapi.JNI.Media,
  Androidapi.JNI.App,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util,
  Androidapi.JNI.SunmiPrinter,
  FMX.Helpers.Android,
  FMX.Platform.Android,
{$ENDIF}
  FMX.Graphics,
  System.SysUtils;

Const
  __Impressora_Status_OK = 1;
  __Impressora_Status_Atualizando = 2;
  __Impressora_Status_em_Erro = 3;
  __Impressora_Status_Sem_Papel = 4;
  __Impressora_Status_Superaquecida = 5;
  __Impressora_Status_Tampa_Aberta = 6;
  __Impressora_Status_Erro_no_Cortador = 7;
  __Impressora_Status_Recuo_do_cortador = 8;
  __Impressora_Status_nao_detectada = 505;

Type
  TACBrSunmiPrinterState = (Ok, Atualizando, Erro, SemPapel, Superaquecida,
    TampaAberta, ErroCortador, RecuoCortador, NaoDetectada);

  /// <summary>
  /// Printer class for Sunmi Printer
  /// </summary>
  TACBrSunmiPrinter = Class
  Private
    FPrinter: JSunmiPrinter;
    FGavetaAberta: Boolean;
    FPrinterMode: Integer;
    FDistanciaMarca: Integer;
    FCortes: Integer;
    FAberturas: Integer;
    FPrinterState: TACBrSunmiPrinterState;
  Public
    Constructor Create;
    /// <summary>
    /// Autoteste da impressora, a impressora imprimirá uma página de autoteste
    /// </summary>
    Procedure printerSelfChecking;
    /// <summary>
    /// Executa uma procedure
    /// </summary>
    Function Execute(aProc: TProc): TACBrSunmiPrinter;
    /// <summary>
    /// Obtenha a versão do serviço
    /// </summary>
    Function getServiceVersion: String;
    /// <summary>
    /// Obtenha o número de série da placa da impressora
    /// </summary>
    Function getPrinterSerialNo: String;
    /// <summary>
    /// Obtenha o número da versão do firmware da impressora
    /// </summary>
    Function getPrinterVersion: String;
    /// <summary>
    /// Obtenha o modelo da impressora
    /// </summary>
    Function getPrinterModal: String;
    /// <summary>
    /// Inicialize a impressora, redefina o programa lógico da impressora, mas não limpe os dados do buffer,
    /// então trabalhos de impressão incompletos continuarão após a redefinição.
    /// </summary>
    Function printerInit: TACBrSunmiPrinter;
    /// <summary>
    /// Salta determinada quantidade de linhas
    /// n = número de linhas
    /// </summary>
    Function lineWrap(n: Integer): TACBrSunmiPrinter;
    /// <summary>
    /// Envia array de bytes diretamente ao dispositivo
    /// </summary>
    Function sendRAWData(data: Array Of Byte): TACBrSunmiPrinter;
    /// <summary>
    /// Seta tipo de alinhamento
    /// alignment = 0-Esquerda, 1-Centro, 2-Direita
    /// </summary>
    Function setAlignment(alignment: Integer): TACBrSunmiPrinter;
    /// <summary>
    /// Seta fonte para impressão
    /// typeface = Nome da fonte
    /// </summary>
    Function setFontName(typeface: String): TACBrSunmiPrinter;
    /// <summary>
    /// Seta tamanho da fonte
    /// fontesize = Tamanho
    /// </summary>
    Function setFontSize(fontsize: Single): TACBrSunmiPrinter;
    /// <summary>
    /// Imprime texto
    /// text = texto a ser impresso
    /// </summary>
    Function printText(text: String): TACBrSunmiPrinter;
    /// <summary>
    /// Imprime texto e salta para próxima linha
    /// text = Texto a ser impresso
    /// </summary>
    Function printTextLF(text: String): TACBrSunmiPrinter;
    /// <summary>
    /// Imprime texto com fonte específica
    /// text = Texto a ser impresso
    /// Typeface = nome da fonte
    /// fontsize = tamanho
    /// </summary>
    Function printTextWithFont(text: String; typeface: String; fontsize: Single)
      : TACBrSunmiPrinter;
    /// <summary>
    /// Imprime textos em colunas
    /// colsTextArr = Array de textos a serem impressos
    /// colsWidthArr = Aarray de inteiros definindo o tamanho da coluna
    /// cosAlign = Array de inteiros definindo os alinhamentos dos textos dentro das colunas
    /// 0-Esquerda, 1-Centro, 2-Direita
    /// </summary>
    Function printColumnsText(colsTextArr: Array of String;
      colsWidthArr: Array Of Integer; colsAlign: Array Of Integer)
      : TACBrSunmiPrinter;
    /// <summary>
    /// Imprime imagem em bitmap
    /// bitmap = bitmap contendo a imagem a ser impressa
    /// </summary>
    Function printBitmap(bitmap: TBitmap): TACBrSunmiPrinter;
    /// <summary>
    /// Imprime código de barras
    /// data = conteúdo do código de barras
    /// symbology = Padrão = 2
    /// 0 - UPC-A，
    /// 1 - UPC-E，
    /// 2 - JAN13(EAN13)，
    /// 3 - JAN8(EAN8)，
    /// 4 - CODE39，
    /// 5 - ITF，
    /// 6 - CODABAR，
    /// 7 - CODE93，
    /// 8 - CODE128
    /// height = Altura do código de barras, o valor é de 1 a 255, o padrão = 162
    /// width = Largura do código de barras, intervalo de 2 a 6, padrão = 2
    /// textposition = Posição do texto Padrão = 2
    /// 0 - não imprimir texto,
    /// 1 - texto acima do código de barras,
    /// 2 - texto abaixo do código de barras,
    /// 3 - imprimir acima e abaixo do código de barras
    /// </summary>
    Function printBarCode(data: String; symbology: Integer = 2;
      height: Integer = 96; width: Integer = 2; textposition: Integer = 2)
      : TACBrSunmiPrinter;
    /// <summary>
    /// Imprime QRCode
    /// data = Dados a serem impressos
    /// modulesize = Tamanho do bloco de código de dimensão (unidade: ponto, valor 1 a 16 ) Padrao = 4
    /// errorlevel = nível de correção de erro Padrão = 1
    /// 0 - L(7%), 1 - M(15%), 2 - Q(25%), 3 - H(30%)
    /// </summary>
    Function printQRCode(data: String; modulesize: Integer = 4;
      errorlevel: Integer = 1): TACBrSunmiPrinter;
    /// <summary>
    /// Imprimir texto, a largura do texto será quebrada automaticamente quando uma linha estiver cheia
    /// e, se for menor que uma linha, não será impressa, a menos que seja forçada a quebrar.
    ///
    /// O texto é gerado como a largura do texto vetorial, ou seja, cada caractere não tem a mesma largura.
    /// text = Texto a ser impresso
    /// </summary>
    Function printOriginalText(text: String): TACBrSunmiPrinter;
    /// <summary>
    /// Entre no modo de buffer, todas as chamadas de impressão serão armazenadas em cache e imprima após chamar commitPrinterBuffer()
    /// clean = Limpa o buffer
    /// </summary>
    Function enterPrinterBuffer(clean: Boolean): TACBrSunmiPrinter;
    /// <summary>
    /// Envia conteúdo do buffer de impressão
    /// </summary>
    Function commitPrinterBuffer: TACBrSunmiPrinter;
    /// <summary>
    /// Sair do modo de buffer
    /// commit = Se deve imprimir o conteúdo do buffer
    /// </summary>
    Function exitPrinterBuffer(commit: Boolean): TACBrSunmiPrinter;

    /// <summary>
    /// Cortar papel
    /// </summary>
    Function cutPaper: TACBrSunmiPrinter;
    /// <summary>
    /// Obtenha o número de vezes que o papel foi cortado
    /// </summary>
    Function getCutPaperTimes: TACBrSunmiPrinter;
    /// <summary>
    /// Abrir gaveta
    /// </summary>
    Function openDrawer: TACBrSunmiPrinter;
    /// <summary>
    /// Obtenha o estado da gaveta (GavetaAberta)
    /// </summary>
    Function getDrawerStatus: TACBrSunmiPrinter;
    /// <summary>
    /// Obtenha o número de vezes que a gaveta foi aberta
    /// </summary>
    Function getOpenDrawerTimes: TACBrSunmiPrinter;
    /// <summary>
    /// Obtenha o modo de impressora atual (PrinterMode)
    /// Retorno: 0 modo normal 1 modo de marca preta
    /// </summary>
    Function getPrinterMode: TACBrSunmiPrinter;
    /// <summary>
    /// Obtenha a distância automática do percurso do papel da impressora no modo de marca preta(DistanciaMarca)
    /// </summary>
    Function getPrinterBBMDistance: TACBrSunmiPrinter;
    /// <summary>
    /// Obtenha o status mais recente da impressora (PrinterState)
    /// Valor de retorno: 1 Impressora normal
    /// 2 Status de atualização da impressora
    /// 3 Erro
    /// 4 Sem papel
    /// 5 Superaquecimento
    /// 6 Tampa aberta
    /// 7 Erro no Cortador
    /// 8 Recuo do cortador
    /// 505 Impressora não detectada
    /// </summary>
    Function updatePrinterState: TACBrSunmiPrinter;
    /// <summary>
    /// Executa o procedimento se a gaveta estiver aberta
    /// </summary>
    Function IfDrawerOpened(aProc: TProc): TACBrSunmiPrinter;
    /// <summary>
    /// Executa o procedimento se a gaveta estiver fechada
    /// </summary>
    Function IfDrawerClosed(aProc: TProc): TACBrSunmiPrinter;

    Property GavetaAberta: Boolean Read FGavetaAberta;
    Property PrinterMode: Integer Read FPrinterMode;
    Property DistanciaMarca: Integer Read FDistanciaMarca;
    Property PrinterState: TACBrSunmiPrinterState Read FPrinterState;
    Property Cortes: Integer Read FCortes;
    Property Aberturas: Integer Read FAberturas;
  End;

implementation

uses
  FMX.Surfaces;

{ TACBrSunmiMiniPrinter }

constructor TACBrSunmiPrinter.Create;
begin
{$IFDEF ANDROID}
  FPrinter := TJSunmiPrinter.JavaClass.init(TAndroidHelper.Context);
{$ENDIF}
end;

procedure TACBrSunmiPrinter.printerSelfChecking;
begin
{$IFDEF ANDROID}
  FPrinter.printerSelfChecking;
{$ENDIF}
end;

function TACBrSunmiPrinter.Execute(aProc: TProc): TACBrSunmiPrinter;
begin
  Result := Self;
  aProc();
end;

function TACBrSunmiPrinter.getPrinterModal: String;
begin
{$IFDEF ANDROID}
  Result := JStringToString(FPrinter.getPrinterModal);
{$ELSE}
  Result := '';
{$ENDIF}
end;

function TACBrSunmiPrinter.getPrinterSerialNo: String;
begin
{$IFDEF ANDROID}
  Result := JStringToString(FPrinter.getPrinterSerialNo);
{$ELSE}
  Result := '';
{$ENDIF}
end;

function TACBrSunmiPrinter.getPrinterVersion: String;
begin
{$IFDEF ANDROID}
  Result := JStringToString(FPrinter.getPrinterVersion);
{$ELSE}
  Result := '';
{$ENDIF}
end;

function TACBrSunmiPrinter.getServiceVersion: String;
begin
{$IFDEF ANDROID}
  Result := JStringToString(FPrinter.getServiceVersion);
{$ELSE}
  Result := '';
{$ENDIF}
end;

function TACBrSunmiPrinter.commitPrinterBuffer: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.commitPrinterBuffer;
{$ENDIF}
end;

function TACBrSunmiPrinter.enterPrinterBuffer(clean: Boolean)
  : TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.enterPrinterBuffer(clean);
{$ENDIF}
end;

function TACBrSunmiPrinter.exitPrinterBuffer(commit: Boolean)
  : TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.exitPrinterBuffer(commit);
{$ENDIF}
end;

function TACBrSunmiPrinter.printerInit: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printerInit;
{$ENDIF}
end;

function TACBrSunmiPrinter.lineWrap(n: Integer): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.lineWrap(n);
{$ENDIF}
end;

function TACBrSunmiPrinter.printBarCode(data: String; symbology: Integer = 2;
  height: Integer = 96; width: Integer = 2; textposition: Integer = 2)
  : TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printBarCode(StringToJstring(data), symbology, height, width,
    textposition);
{$ENDIF}
end;

function TACBrSunmiPrinter.printBitmap(bitmap: TBitmap): TACBrSunmiPrinter;

{$IFDEF ANDROID}
  function BitmapToJBitmap(aBitmap: TBitmap): JBitmap;
  var
    BitmapSurface: TBitmapSurface;
  begin
    Assert(aBitmap <> nil);
    Result := TJBitmap.JavaClass.createBitmap(aBitmap.width, aBitmap.height,
      TJBitmap_Config.JavaClass.ARGB_8888);
    BitmapSurface := TBitmapSurface.Create;
    try
      BitmapSurface.Assign(aBitmap);
      if not SurfaceToJBitmap(BitmapSurface, Result) then
        Result := nil;
    finally
      BitmapSurface.Free;
    end;
  end;
{$ENDIF}

begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printBitmap(BitmapToJBitmap(bitmap));
{$ENDIF}
end;

function TACBrSunmiPrinter.printColumnsText(colsTextArr: array of String;
  colsWidthArr, colsAlign: array of Integer): TACBrSunmiPrinter;
{$IFDEF ANDROID}
Var
  i: Integer;
  S: array of JString;
{$ENDIF}
begin
  Result := Self;
{$IFDEF ANDROID}
  SetLength(S, Length(colsTextArr));
  for i := 0 to Length(S) - 1 do
    S[i] := StringToJstring(colsTextArr[i]);
  FPrinter.printColumnsText(S, colsWidthArr, colsAlign);
{$ENDIF}
end;

function TACBrSunmiPrinter.printOriginalText(text: String): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printOriginalText(StringToJstring(text));
{$ENDIF}
end;

function TACBrSunmiPrinter.printQRCode(data: String; modulesize: Integer = 4;
  errorlevel: Integer = 1): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printQRCode(StringToJstring(data), modulesize, errorlevel);
{$ENDIF}
end;

function TACBrSunmiPrinter.printText(text: String): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printText(StringToJstring(text));
{$ENDIF}
end;

function TACBrSunmiPrinter.printTextLF(text: String): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printTextLF(StringToJstring(text));
{$ENDIF}
end;

function TACBrSunmiPrinter.printTextWithFont(text, typeface: String;
  fontsize: Single): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.printTextWithFont(StringToJstring(text), StringToJstring(typeface),
    fontsize);
{$ENDIF}
end;

function TACBrSunmiPrinter.sendRAWData(data: array of Byte): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.sendRAWData(data);
{$ENDIF}
end;

function TACBrSunmiPrinter.setAlignment(alignment: Integer): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.setAlignment(alignment);
{$ENDIF}
end;

function TACBrSunmiPrinter.setFontName(typeface: String): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.setFontName(StringToJstring(typeface));
{$ENDIF}
end;

function TACBrSunmiPrinter.setFontSize(fontsize: Single): TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.setFontSize(fontsize);
{$ENDIF}
end;

function TACBrSunmiPrinter.cutPaper: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.cutPaper;
{$ENDIF}
end;

function TACBrSunmiPrinter.getCutPaperTimes: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FCortes := FPrinter.getCutPaperTimes;
{$ENDIF}
end;

function TACBrSunmiPrinter.getDrawerStatus: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FGavetaAberta := FPrinter.getDrawerStatus;
{$ENDIF}
end;

function TACBrSunmiPrinter.getOpenDrawerTimes: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FAberturas := FPrinter.getOpenDrawerTimes;
{$ENDIF}
end;

function TACBrSunmiPrinter.getPrinterBBMDistance: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FDistanciaMarca := FPrinter.getPrinterBBMDistance;
{$ENDIF}
end;

function TACBrSunmiPrinter.getPrinterMode: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinterMode := FPrinter.getPrinterMode;
{$ENDIF}
end;

function TACBrSunmiPrinter.openDrawer: TACBrSunmiPrinter;
begin
  Result := Self;
{$IFDEF ANDROID}
  FPrinter.openDrawer;
{$ENDIF}
end;

function TACBrSunmiPrinter.updatePrinterState: TACBrSunmiPrinter;
{$IFDEF ANDROID}
Var
  LState: Integer;
{$ENDIF}
begin
  Result := Self;
{$IFDEF ANDROID}
  LState := FPrinter.updatePrinterState;
  case LState of
    __Impressora_Status_OK: FPrinterState := TACBrSunmiPrinterState.Ok;
    __Impressora_Status_Atualizando: FPrinterState := TACBrSunmiPrinterState.Atualizando;
    __Impressora_Status_em_Erro: FPrinterState := TACBrSunmiPrinterState.Erro;
    __Impressora_Status_Sem_Papel: FPrinterState := TACBrSunmiPrinterState.SemPapel;
    __Impressora_Status_Superaquecida: FPrinterState := TACBrSunmiPrinterState.Superaquecida;
    __Impressora_Status_Tampa_Aberta: FPrinterState := TACBrSunmiPrinterState.TampaAberta;
    __Impressora_Status_Erro_no_Cortador: FPrinterState := TACBrSunmiPrinterState.ErroCortador;
    __Impressora_Status_Recuo_do_cortador: FPrinterState := TACBrSunmiPrinterState.RecuoCortador;
    __Impressora_Status_nao_detectada: FPrinterState := TACBrSunmiPrinterState.NaoDetectada;
  end;
{$ENDIF}
end;

function TACBrSunmiPrinter.IfDrawerClosed(aProc: TProc): TACBrSunmiPrinter;
begin
  Result := Self;
  FPrinter.getDrawerStatus;
  If GavetaAberta Then
    aProc;
end;

function TACBrSunmiPrinter.IfDrawerOpened(aProc: TProc): TACBrSunmiPrinter;
begin
  Result := Self;
  FPrinter.getDrawerStatus;
  If Not GavetaAberta Then
    aProc;
end;

end.
