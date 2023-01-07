unit Cinema.View.Comprar;

interface

uses
  Router4D,
  Router4D.Interfaces,
  Router4D.Props,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.StrUtils,
  FMX.DialogService,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.ListBox,
  CustomThread,
  Loading,
  FMX.Effects,
  FMX.Filter.Effects;

type
  TViewComprar = class(TForm, iRouter4DComponent)
    LytMain: TLayout;
    recBackground: TRectangle;
    LytNavegacao: TLayout;
    LytBotoes: TLayout;
    lytConfirmar: TLayout;
    recConfirmar: TRectangle;
    lblConfirmar: TLabel;
    speConfirmar: TSpeedButton;
    lytCancelar: TLayout;
    recCancelar: TRectangle;
    lblCancelar: TLabel;
    speCancelar: TSpeedButton;
    lytAlignBotoes: TLayout;
    Image1: TImage;
    lytCadeiras: TLayout;
    lytTelao: TLayout;
    lytCadeirasFundo: TLayout;
    lytCadeirasTelao: TLayout;
    lstBoxEsqSup: TListBox;
    lstBoxDirSup: TListBox;
    lstBoxDirInf: TListBox;
    lstBoxEsqInf: TListBox;
    LPoltronaLivreTemplate: TListBoxItem;
    recBackTelao: TRectangle;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    Label1: TLabel;
    recTela: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    flowCadeirasTela: TFlowLayout;
    flowCadeirasFundo: TFlowLayout;
    lytLegenda: TLayout;
    LytPoltronaLegendaLivre: TLayout;
    pathCadeira: TPath;
    LytPoltronaLegendaOcupada: TLayout;
    LPoltronaOcupada: TListBoxItem;
    recPoltronaOcupada: TRectangle;
    pthPoltronaOcupada: TPath;
    lblGeralLivre: TLabel;
    lblGeralOcupada: TLabel;
    speClickPoltrona: TSpeedButton;
    LytSelecionada: TLayout;
    Label4: TLabel;
    LblSelecionadas: TLabel;
    LytPoltronaSelecionada: TLayout;
    LPoltronaSelecionada: TListBoxItem;
    recPoltronaSelecionada: TRectangle;
    pthPoltronaSelecionada: TPath;
    lblPoltronaSelecionada: TLabel;
    Layout2: TLayout;
    LytPagameto: TLayout;
    recPagamento: TRectangle;
    Layout3: TLayout;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    LytTitulos: TLayout;
    Label5: TLabel;
    LytItens: TLayout;
    lstItem: TListBox;
    lsValor: TListBox;
    Label6: TLabel;
    lblTotal: TLabel;
    LytTotal: TLayout;
    recBack: TRectangle;
    Layout4: TLayout;
    LytPagar: TLayout;
    Rectangle1: TRectangle;
    Label7: TLabel;
    SpeedButton2: TSpeedButton;
    LytCancelCompra: TLayout;
    Rectangle5: TRectangle;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    procedure speCancelarClick(Sender: TObject);
    procedure speConfirmarClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure recBackClick(Sender: TObject);
    procedure recBackTap(Sender: TObject; const Point: TPointF);
  private
    { Private declarations }
    FPoltronas: TStringList;
    procedure AddOnClickEvent(AControl: TControl; AEvent: TNotifyEvent);
    procedure DoClickEvent(Sender: TObject);

    procedure PreencherPoltronas;
    procedure LimparPoltronas(AListBox: TListBox);
    procedure CriarListaSelecionadas;
    procedure DestruirListaSelecionadas;

    procedure ClonarPoltrona(AID: Integer; AGrupoCadeiras: TListBox;
      AStatus: Integer; AStrPoltrona: string = '');
    procedure SortearOcupada(AContador: Integer; out AStatus: Integer);
    procedure AdicionarPoltrona(APoltrona: TFMXObject);
    procedure RemoverPoltrona(APoltrona: TFMXObject);
    procedure AtualizarLabelSelecionadas;
    procedure AtualizarCorPoltrona(APoltrona: TControl; ACor: TAlphaColor);

    procedure Totalizador;
    procedure MostrarBack;
    procedure MostrarTotalizador;
    procedure OcultarBack;
    procedure OcultarTotalizador;
  public
    { Public declarations }
    function Render: TFMXObject;
    procedure UnRender;

    [Subscribe]
    procedure Props(AValue: TProps);
  end;

const
  C_Num_Cadeiras    = 154; // Grupo1 + Grupo2 + Grupo3 + Grupo3;
  C_Num_Grupo1      = 28;
  C_Num_Grupo2      = 28;
  C_Num_Grupo3      = 49;
  C_Num_Grupo4      = 49;
  C_Cor_Livre       = $FFEAEAEB;
  C_Cor_Ocupada     = $FF7C7AA2;
  C_Cor_Selecionada = $FFF8F018;
var
  ViewComprar: TViewComprar;

implementation

uses
  Cinema.Constantes, Service.Dados;

{$R *.fmx}

{ TViewComprar }

procedure TViewComprar.AddOnClickEvent(AControl: TControl; AEvent: TNotifyEvent);
var
  I: Integer;
begin
  for I := 0 to Pred(AControl.ControlsCount) do
  begin
    if AControl.Controls[I] is TSpeedButton then
    begin
      TSpeedButton(AControl.Controls[I]).OnClick := AEvent;
      break;
    end
    else
      AddOnClickEvent(AControl.Controls[I], AEvent);
  end;
end;

procedure TViewComprar.DoClickEvent(Sender: TObject);
var
  LPoltrona:    TListBoxItem;
  LStatus:      Double;
  LStrPoltrona: string;
begin
  LPoltrona    := TListBoxItem(TSpeedButton(Sender).Owner);
  LStatus      := TListBoxItem(LPoltrona).TagFloat;
  LStrPoltrona := TListBoxItem(LPoltrona).TagString;

  if (LStatus = 1) and not(FPoltronas.IndexOfObject(LPoltrona) > -1) then
    ShowMessage('Poltrona já ocupada. Selecione outra.')
  else if (FPoltronas.IndexOfObject(LPoltrona) > -1) then

    RemoverPoltrona(LPoltrona)
  else
    AdicionarPoltrona(LPoltrona);
end;

procedure TViewComprar.LimparPoltronas(AListBox: TListBox);
begin
  for var I: Integer := Pred(AListBox.Content.ChildrenCount) downto 0 do
    if AListBox.Content.Children[I] is TListBoxItem then
      TListBoxItem(AListBox.Content.Children[I]).DisposeOf;
end;

procedure TViewComprar.AdicionarPoltrona(APoltrona: TFMXObject);
begin
  FPoltronas.AddObject(TListBoxItem(APoltrona).TagString, APoltrona);
  TListBoxItem(APoltrona).TagFloat := 1;
  AtualizarLabelSelecionadas;
  AtualizarCorPoltrona(TListBoxItem(APoltrona), C_Cor_Selecionada);
end;

procedure TViewComprar.ClonarPoltrona(AID: Integer; AGrupoCadeiras: TListBox;
  AStatus: Integer; AStrPoltrona: string = '');
var
  LPoltrona: TListBoxItem;
begin
  TThread.Synchronize(
    TThread.CurrentThread,
    procedure()
    begin
      LPoltrona := TListBoxItem(LPoltronaLivreTemplate.Clone(AGrupoCadeiras));
      LPoltrona.Parent := AGrupoCadeiras;
      LPoltrona.Height := 40;
      LPoltrona.Width := 32;
    end
    );
  LPoltrona.Tag       := AID;
  LPoltrona.TagFloat  := AStatus;
  LPoltrona.TagString := AStrPoltrona;

  AddOnClickEvent(LPoltrona, DoClickEvent);
end;

procedure TViewComprar.SortearOcupada(AContador: Integer; out AStatus: Integer);
begin
  randomize;
  AStatus                := 0;
  pathCadeira.Fill.Color := C_Cor_Livre;
  var
    X: Integer := Random(154);
  if Odd(X) then
  begin
    TThread.Synchronize(
      TThread.CurrentThread,
      procedure()
      begin
        pathCadeira.Fill.Color := C_Cor_Ocupada;
      end
      );
    AStatus := 1;
  end;
end;

procedure TViewComprar.PreencherPoltronas;
begin
  TLib.CustomThread(
    procedure()
    begin
{$REGION 'OnStart'}
      TLoading.Show('Checando lugares...Aguarde!');
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        begin
          LimparPoltronas(lstBoxEsqSup);
          LimparPoltronas(lstBoxDirSup);
          LimparPoltronas(lstBoxDirInf);
          LimparPoltronas(lstBoxEsqInf);

          // Telão
          flowCadeirasFundo.Height := 350;
          flowCadeirasFundo.Margins.Top := 80;

          lytAlignBotoes.Margins.Top := 50;
          lytAlignBotoes.Margins.Bottom := 50;

          flowCadeirasTela.Height := 250;
          flowCadeirasTela.Margins.Top := -70;

          Self.lstBoxEsqSup.Height := flowCadeirasTela.Height;
          Self.lstBoxDirSup.Height := flowCadeirasTela.Height;

          // Fundo
          Self.lstBoxEsqInf.Height := flowCadeirasFundo.Height;
          Self.lstBoxDirInf.Height := flowCadeirasFundo.Height;

          Self.lstBoxDirInf.BeginUpdate;
          Self.lstBoxEsqInf.BeginUpdate;

          Self.lstBoxEsqSup.BeginUpdate;
          Self.lstBoxDirSup.BeginUpdate;
        end
        );
{$ENDREGION}
    end,
    procedure()
    var
      LStatus: Integer;
      LStrPoltrona: string;
      LLetra: string;
    begin
      // OnProcess
      for var iGeral: Integer := C_Num_Cadeiras downto 1 do
      begin
        Self.SortearOcupada(iGeral, LStatus);

        case iGeral of
          // Esquerda Inferior (Telao)
          Low(C_Num_Grupo1) + 1 .. C_Num_Grupo1: // 1 a 28
            begin
              case iGeral of
                 1..07: LLetra := 'A';
                08..14: LLetra := 'B';
                15..21: LLetra := 'C';
                22..28: LLetra := 'D';
              end;

              LStrPoltrona := Format('%s%2.2d', [LLetra,iGeral]);
              Self.ClonarPoltrona(iGeral, lstBoxEsqSup, LStatus, LStrPoltrona);
            end;

          // Direita Inferior (Telao)
          C_Num_Grupo1 + 1 .. C_Num_Grupo1 + C_Num_Grupo2: // 29 até 56
            begin
              case iGeral of
                29..35: LLetra := 'A';
                36..42: LLetra := 'B';
                43..49: LLetra := 'C';
                50..56: LLetra := 'D';
              end;

              LStrPoltrona := Format('%s%2.2d', [LLetra, iGeral]);

              Self.ClonarPoltrona(iGeral, lstBoxDirSup, LStatus, LStrPoltrona);
            end;

          // Esquerda Superior (Fundo)
          C_Num_Grupo1 + C_Num_Grupo2 + 1 .. C_Num_Grupo1 + C_Num_Grupo2 + C_Num_Grupo3: // 73 até 153
            begin
              case iGeral of
                57.. 63: LLetra := 'E';
                64.. 70: LLetra := 'F';
                71.. 77: LLetra := 'G';
                78.. 84: LLetra := 'H';
                85.. 91: LLetra := 'I';
                95.. 98: LLetra := 'J';
                99..105: LLetra := 'K';
              end;

              LStrPoltrona := Format('%s%2.2d', [LLetra, iGeral]);

              Self.ClonarPoltrona(iGeral, lstBoxEsqInf, LStatus, LStrPoltrona);
            end;

          // Direita Superior (Fundo)
          C_Num_Grupo1 + C_Num_Grupo2 + C_Num_Grupo3 + 1 .. C_Num_Cadeiras: // 154 até 234
            begin
              // Ajustar números
              case iGeral of
                106..112: LLetra := 'E';
                113..119: LLetra := 'F';
                120..126: LLetra := 'G';
                127..133: LLetra := 'H';
                134..140: LLetra := 'I';
                141..147: LLetra := 'J';
                148..154: LLetra := 'K';
              end;

              LStrPoltrona := Format('%s%2.2d', [LLetra, iGeral]);

              Self.ClonarPoltrona(iGeral, lstBoxDirInf, LStatus, LStrPoltrona);
            end;
        end;
      end;
    end,
    procedure()
    begin
      // OnComplete
      TLoading.Hide;

      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        begin
          Self.lstBoxDirInf.EndUpdate;
          Self.lstBoxEsqInf.EndUpdate;

          Self.lstBoxEsqSup.EndUpdate;
          Self.lstBoxDirSup.EndUpdate;

          pathCadeira.Fill.Color := C_Cor_Livre;// $FFEAEAEB;
        end
        );
    end,
    procedure(const AException: string)
    begin
      // OnError
    end,
    True
    );
end;

procedure TViewComprar.Props(AValue: TProps);
begin
  // if AValue.Key = 'COMPRAR' then
  //
end;

procedure TViewComprar.recBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    OcultarTotalizador;
  {$ENDIF}
end;

procedure TViewComprar.recBackTap(Sender: TObject; const Point: TPointF);
begin
  {$IFDEF ANDROID}
    OcultarTotalizador;
  {$ENDIF}
end;

procedure TViewComprar.RemoverPoltrona(APoltrona: TFMXObject);
begin
  FPoltronas.Delete(FPoltronas.IndexOfObject(APoltrona));
  TListBoxItem(APoltrona).TagFloat := 0;
  AtualizarLabelSelecionadas;
  AtualizarCorPoltrona(TListBoxItem(APoltrona), C_Cor_Livre);
end;

function TViewComprar.Render: TFMXObject;
begin
  Result := LytMain;
  PreencherPoltronas;
  CriarListaSelecionadas;
  LblSelecionadas.Text := EmptyStr;
  OcultarBack;
  OcultarTotalizador;
end;

procedure TViewComprar.speCancelarClick(Sender: TObject);
begin
  TRouter4D.Link.&To(C_View_Detalhes);
end;

procedure TViewComprar.speConfirmarClick(Sender: TObject);
begin
  Totalizador;
end;

procedure TViewComprar.SpeedButton2Click(Sender: TObject);
begin
  TDialogService.MessageDialog(
    'Insira o cartão no terminal ao lado e siga as instruções.' + #13#10 +
    'Obrigado pela sua compra! Bom filme.',
    TMsgDlgType.mtInformation,
    [TMsgDlgBtn.mbOK],
    TMsgDlgBtn.mbOK,
    0,
    procedure (const AModalResult: TModalResult)
    begin
      if AModalResult = mrOk then
      begin
        ServiceDados.QryFilmes.Filter := EmptyStr;
        ServiceDados.QryFilmes.Filtered := False;
        TRouter4D.Link.&To(C_View_Menu);
      end;
    end
  );
end;

procedure TViewComprar.SpeedButton3Click(Sender: TObject);
begin
  OcultarTotalizador;
end;

procedure TViewComprar.Totalizador;
var
  LTotal : Double;
  LUnitario: Double;
begin
  LTotal := 0.0;
  LUnitario := 27.45;
  if FPoltronas.Count > 0 then
  begin
    for var I: Integer := 0 to Pred(FPoltronas.Count) do
    begin
      LTotal := LTotal + LUnitario;
      lstItem.Items.Add(Format('Poltrona: %s', [FPoltronas[I]]));
      lsValor.Items.Add(FormatFloat('R$ ###,###.#0', LUnitario))
    end;
    lblTotal.Text := FormatFloat('R$ ###,###.#0', LTotal);
    MostrarTotalizador;
  end
  else
    ShowMessage('Escolha as poltronas.');

end;

procedure TViewComprar.MostrarTotalizador;
begin
  MostrarBack;
  LytPagameto.Visible := True;
  LytPagameto.BringToFront;
end;

procedure TViewComprar.OcultarTotalizador;
begin
  OcultarBack;
  lstItem.Items.Clear;
  lsValor.Items.Clear;
  lblTotal.Text := EmptyStr;
  LytPagameto.Visible := False;
end;

procedure TViewComprar.MostrarBack;
begin
  recBack.Visible := True;
  recBack.Align := TAlignLayout.Contents;
  recBack.BringToFront;
end;

procedure TViewComprar.OcultarBack;
begin
  recBack.Visible := False;
end;

procedure TViewComprar.UnRender;
begin
  DestruirListaSelecionadas;
end;

procedure TViewComprar.CriarListaSelecionadas;
begin
  if not Assigned(FPoltronas) then
    FPoltronas := TStringList.Create;
  FPoltronas.Sort;
end;

procedure TViewComprar.DestruirListaSelecionadas;
begin
  if Assigned(FPoltronas) then
    FPoltronas.Free;
end;

procedure TViewComprar.AtualizarCorPoltrona(APoltrona: TControl; ACor: TAlphaColor);
begin
  for var I: Integer := 0 to Pred(APoltrona.ControlsCount) do
  begin
    if APoltrona.Controls[I] is TPath then
    begin
      TPath(APoltrona.Controls[I]).Fill.Color := ACor;
      break;
    end
    else
      AtualizarCorPoltrona(APoltrona.Controls[I], ACor);
  end;
end;

procedure TViewComprar.AtualizarLabelSelecionadas;
begin
  LblSelecionadas.Text := EmptyStr;
  for var I: Integer   := 0 to Pred(FPoltronas.Count) do
  begin
    if I = 0
    then
      LblSelecionadas.Text := FPoltronas[I]
    else
      LblSelecionadas.Text := Format('%s, %s', [LblSelecionadas.Text, FPoltronas[I]]);
  end;
end;

end.
