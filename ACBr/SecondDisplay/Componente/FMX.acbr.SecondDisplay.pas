unit FMX.acbr.SecondDisplay;

interface

Uses

{$IFDEF ANDROID}
  FMX.Helpers.Android,
  FMX.Platform.Android,
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
{$ENDIF}
  System.Types,
  System.UITypes,
  System.Classes,
  System.SysUtils,
  System.Math,
  System.Messaging,
  System.Generics.Collections,
  FMX.Platform,
  FMX.Types,
  FMX.Forms,
  FMX.Controls,
  FMX.Layouts,
  FMX.Surfaces,
  FMX.Graphics;

Type

{$IFDEF ANDROID}
  JPresentation = interface;

  JPresentationClass = interface(JObjectClass)
    ['{FB6C1483-BDE7-423F-97F9-76A8D785EF36}']
    { class } function init(outerContext: JContext; display: JDisplay;
      theme: Integer): JPresentation; cdecl; overload;
    { class } function init(outerContext: JContext; display: JDisplay)
      : JPresentation; cdecl; overload;
  end;

  [JavaSignature('android/app/Presentation')]
  JPresentation = interface(JObject)
    ['{30399E72-C19C-4EE5-AADB-3777803F7849}']
    Function getDisplay: JDisplay; cdecl;
    Function getResources: JResources; cdecl;
    Procedure onDisplayChanged; cdecl;
    Procedure onDisplayRemoved; cdecl;
    Procedure show; cdecl;
  end;

  TJPresentation = class(TJavaGenericImport<JPresentationClass, JPresentation>)
  end;

  JVideoView = Interface;

  JVideoViewClass = interface(JObjectClass)
    ['{E44C0200-8A4A-4577-8E71-7BDA35120A86}']
    { class } function init(context: JContext): JVideoView; cdecl;
  end;

  [JavaSignature('android/widget/VideoView')]
  JVideoView = interface(JObject)
    ['{91BEAE9B-7BA1-4D23-A0C8-AD6B5D68D509}']
    Function canPause: Boolean;
    Function canSeekBackward: Boolean;
    Function canSeekForward: Boolean;
    Function getAudioSessionId: Integer;
    Function getBufferPercentage: Integer;
    Function getCurrentPosition: Integer;
    Function getDuration: Integer;
    Function isPlaying: Boolean;
    Procedure addSubtitleSource(ais: JInputStream; aFormat: JMediaFormat);
    Procedure seekTo(msec: Integer);
    Procedure setAudioAttributes(aAttributes: JAudioAttributes);
    Procedure setAudioFocusRequest(focusGain: Integer);
    Procedure setVideoPath(path: JString);
    Procedure setVideoURI(Uri: Jnet_Uri);
    Procedure start;
    Procedure pause;
    Procedure resume;
    Procedure stopPlayback;
    Procedure suspend;
  end;

  TJVideoView = class(TJavaGenericImport<JVideoViewClass, JVideoView>)
  end;

  JSecondDisplayPresentation = Interface;

  JSecondDisplayPresentationClass = interface(JPresentationClass)
    ['{FFEA9F1B-36AA-4AFC-BD30-78BA51B4728C}']
    { class } function init(context: JContext; display: JDisplay)
      : JSecondDisplayPresentation; cdecl;
  end;

  [JavaSignature('com/acbr/secondDisplay/SecondDisplayPresentation')]
  JSecondDisplayPresentation = interface(JPresentation)
    ['{FDAD12A1-7A03-4FA5-A409-FCF391ABAFF3}']
    Function GetView: JView;
    Procedure setBitmap(aBitmap: JBitmap; aX, aY: Integer);
  end;

  TJSecondDisplayPresentation = class
    (TJavaGenericImport<JSecondDisplayPresentationClass,
    JSecondDisplayPresentation>)
  end;

  JPlayVideo = Interface;

  JPlayVideoClass = interface(JObjectClass)
    ['{53F71CCD-D006-4BBB-9EED-974202915C89}']
    { class } function init(context: JContext): JPlayVideo; cdecl;
  end;

  [JavaSignature('com/acbr/playVideo/PlayVideo')]
  JPlayVideo = interface(JVideoView)
    ['{22A8492B-A183-4BB0-9E1B-17588E9F1712}']
    Procedure SetPositionAndSize(aX, aY, aW, aH: Integer);
  end;

  TJPlayVideo = class(TJavaGenericImport<JPlayVideoClass, JPlayVideo>)
  end;

{$ENDIF}

  TACBrCustomSecondDisplayLayout = Class;

  TBufferedScene = class(TFMXObject, IScene, IAlignRoot, IContent)
  private
    class var FScreenService: IFMXScreenService;
    class destructor Destroy;
  private
    [Weak]
    FScene: TACBrCustomSecondDisplayLayout;
    FBuffer: TBitmap;
    FControls: TControlList;
    FWidth: Integer;
    FHeight: Integer;
    FUpdateRects: array of TRectF;
    FLastWidth: Single;
    FLastHeight: Single;
    FDisableAlign: Boolean;
    { IScene }

{$IF CompilerVersion <= 34}
    procedure AddUpdateRect(R: TRectF);
    function LocalToScreen(P: TPointF): TPointF;
    function ScreenToLocal(P: TPointF): TPointF;
{$ELSE}
    procedure AddUpdateRect(const R: TRectF);
    function LocalToScreen(const P: TPointF): TPointF;
    function ScreenToLocal(const P: TPointF): TPointF;
{$ENDIF}
    function GetUpdateRectsCount: Integer;
    function GetUpdateRect(const Index: Integer): TRectF;
    function GetObject: TFMXObject;
    function GetCanvas: TCanvas;
    function GetSceneScale: Single;
    procedure ChangeScrollingState(const AControl: TControl;
      const Active: Boolean);
    procedure DisableUpdating;
    procedure EnableUpdating;

    function GetStyleBook: TStyleBook;
    procedure SetStyleBook(const Value: TStyleBook);
    { IAlignRoot }
    procedure Realign;
    procedure ChildrenAlignChanged;
    { IContent }
    function GetParent: TFMXObject;
    function GetChildrenCount: Integer;
    procedure Changed;
    procedure Invalidate;
    procedure UpdateBuffer;
  protected
    procedure ScaleChangedHandler(const Sender: TObject;
      const Msg: System.Messaging.TMessage); virtual;
    procedure DrawTo;
    procedure DoAddObject(const AObject: TFMXObject); override;
    procedure DoRemoveObject(const AObject: TFMXObject); override;
    function ObjectAtPoint(P: TPointF): IControl;
  public
    constructor Create(const AScene: TACBrCustomSecondDisplayLayout);
      reintroduce;
    destructor Destroy; override;
    procedure SetSize(const AWidth, AHeight: Integer);
    property Buffer: TBitmap read FBuffer;
    property Scene: TACBrCustomSecondDisplayLayout read FScene;
  end;

  TACBrCustomSecondDisplayLayout = Class(TLayout)
  Private
{$IFDEF ANDROID}
    FObject: JObject;
    FDisplay: JDisplay;
    FContext: JContext;
    FView: JView;
    FMedia: JMediaRouter;
    FRoute: JMediaRouter_RouteInfo;
    FBitmap: JBitmap;
    FSecDis: JSecondDisplayPresentation;
    FMPlayer: JVideoView;
    FMPUri: Jnet_Uri;
    FListVideos: TList<JVideoView>;
{$ENDIF}
    FScene: TBufferedScene;
    FBackgroundColor: TAlphaColor;
    procedure SetBackgroundColor(const Value: TAlphaColor);
    procedure ShowInThread;
{$IFDEF ANDROID}
    function BitmapToJBitmap(const aBitmap: TBitmap): JBitmap;
{$ENDIF}
  Protected
    Procedure Loaded; Override;
    Procedure Paint; Override;
    procedure DoAddObject(const AObject: TFMXObject); override;
    procedure DoResized; override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    function CanRepaint: Boolean; Override;
  Public
    Constructor Create(aOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure show; Reintroduce;
    Procedure Clear;
    Procedure PlayVideo(aPath: String; aRect: TRect);
    Property BackgroundColor: TAlphaColor Read FBackgroundColor
      Write SetBackgroundColor;
  End;

  TACBrSecondDisplayLayout = Class(TACBrCustomSecondDisplayLayout)
  Published
    Property BackgroundColor;
  End;

Procedure Register;

implementation

Procedure Register;
Begin
  RegisterComponents('ACBr Mobile', [TACBrSecondDisplayLayout]);
End;

{ TACBrSecondDisplayLayout }

{$IFDEF ANDROID}

function TACBrCustomSecondDisplayLayout.BitmapToJBitmap(const aBitmap
  : TBitmap): JBitmap;
var
  LSurface: TBitmapSurface;
begin
  Result := TJBitmap.JavaClass.createBitmap(aBitmap.Width, aBitmap.Height,
    TJBitmap_Config.JavaClass.ARGB_8888);
  LSurface := TBitmapSurface.Create;
  try
    LSurface.Assign(aBitmap);
    SurfaceToJBitmap(LSurface, Result);
  finally
    LSurface.Free;
  end;
end;
{$ENDIF}

function TACBrCustomSecondDisplayLayout.CanRepaint: Boolean;
begin
  Result := False;
  show;
end;

constructor TACBrCustomSecondDisplayLayout.Create(aOwner: TComponent);
Begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    FScene := TBufferedScene.Create(Self As TACBrCustomSecondDisplayLayout);
    FScene.Parent := Self;
    FScene.Stored := False;
  end;
{$IFDEF ANDROID}
  FObject := MainActivity.getBaseContext.getSystemService
    (TJContext.JavaClass.MEDIA_ROUTER_SERVICE);
  FMedia := TJMediaRouter.Wrap(FObject);
  FRoute := FMedia.getDefaultRoute;
  FDisplay := FRoute.getPresentationDisplay;
  FContext := MainActivity.createDisplayContext(FDisplay);
  FSecDis := TJSecondDisplayPresentation.JavaClass.init(FContext, FDisplay);
  FBitmap := TJBitmap.JavaClass.createBitmap(FDisplay.getWidth,
    FDisplay.getHeight, TJBitmap_Config.JavaClass.ARGB_8888);
  FView := FSecDis.GetView;
  FListVideos := TList<JVideoView>.Create;
  TThread.CreateAnonymousThread(
    Procedure
    Begin
      Sleep(50);
      TThread.Queue(Nil,
        Procedure
        Begin
          Width := FDisplay.getWidth;
          Height := FDisplay.getHeight;
          FSecDis.show;
        End);
    End).start;
{$ELSE}
  Width := 800;
  Height := 600;
{$ENDIF}
  BackgroundColor := TAlphaColors.White;
end;

procedure TACBrCustomSecondDisplayLayout.Loaded;
begin
  inherited;
  ShowInThread;
end;

destructor TACBrCustomSecondDisplayLayout.Destroy;
begin
{$IFDEF ANDROID}
  FListVideos.Clear;
  FListVideos.DisposeOf;
{$ENDIF}
  inherited;
end;

procedure TACBrCustomSecondDisplayLayout.DoAddObject(const AObject: TFMXObject);
begin
  if (FScene <> nil) and (AObject <> FScene) then
    FScene.AddObject(AObject)
  else
    inherited;
end;

procedure TACBrCustomSecondDisplayLayout.DoResized;
begin
  inherited;
  if FScene <> nil then
    FScene.SetSize(Round(Width), Round(Height));
{$IFDEF ANDROID}
  if Not(csDesigning In ComponentState) then
  Begin
    if (FBitmap.getWidth <> Width) Or (FBitmap.getHeight <> Height) then
    Begin
      FBitmap.SetWidth(Trunc(Width));
      FBitmap.SetHeight(Trunc(Height));
    End;
  End;
{$ENDIF}
end;

procedure TACBrCustomSecondDisplayLayout.Clear;
begin
  FScene.Buffer.Clear(TAlphaColors.Null);
  show;
end;

function TACBrCustomSecondDisplayLayout.ObjectAtPoint(P: TPointF): IControl;
begin
  Result := nil;
  if FScene <> nil then
    Result := FScene.ObjectAtPoint(P);
  if Result = nil then
    Result := inherited ObjectAtPoint(P);
end;

procedure TACBrCustomSecondDisplayLayout.Paint;
begin
  inherited;
  if (csDesigning In ComponentState) then
  Begin
    Canvas.Fill.Color := FBackgroundColor;
    Canvas.Fill.Kind := TBrushKind.Solid;
    Canvas.FillRect(TRectF.Create(0, 0, Width, Height), 0, 0, [],
      AbsoluteOpacity);
  End;
end;

procedure TACBrCustomSecondDisplayLayout.PlayVideo(aPath: String; aRect: TRect);
begin
{$IFDEF ANDROID}
  // FMPUri   := TAndroidHelper.StrToJURI(aPath);

  FMPlayer := TJVideoView.JavaClass.init(FContext);
  FMPlayer.setVideoPath(StringToJstring('file://' + aPath));
  FMPlayer.start;


  // FListVideos.Add(TJVideoView.JavaClass.init(FContext));
  // FListVideos.Last.SetPositionAndSize(aRect.Left, aRect.Top, aRect.Width, aRect.Height);
  // FListVideos.Last.setVideoPath(StringToJString(aPath));
  // FListVideos.Last.setVideoURI(Uri);
  // 1FListVideos.Last.start;
{$ENDIF}
end;

procedure TACBrCustomSecondDisplayLayout.SetBackgroundColor
  (const Value: TAlphaColor);
begin
  FBackgroundColor := Value;
{$IFDEF ANDROID}
  FView.SetBackgroundColor(Integer(FBackgroundColor));
{$ENDIF}
end;

procedure TACBrCustomSecondDisplayLayout.show;
begin
  inherited;
  if FScene <> nil then
  begin
{$IFDEF ANDROID}
    FScene.DrawTo;
    FBitmap := BitmapToJBitmap(FScene.Buffer);
    FSecDis.setBitmap(FBitmap, Trunc((FView.getWidth - FBitmap.getWidth) / 2),
      Trunc((FView.getHeight - FBitmap.getHeight) / 2));
{$ENDIF}
  end;
end;

procedure TACBrCustomSecondDisplayLayout.ShowInThread;
begin
  TThread.CreateAnonymousThread(
    Procedure
    Begin
      Sleep(10);
      TThread.Queue(Nil,
        Procedure
        Begin
          show;
        End);
    End).start;
end;

{ TBufferedScene }

constructor TBufferedScene.Create(const AScene: TACBrCustomSecondDisplayLayout);
begin
  inherited Create(nil);
  if FScreenService = nil then
    TPlatformServices.Current.SupportsPlatformService(IFMXScreenService,
      FScreenService);
  FScene := AScene;
  FWidth := Round(AScene.Width);
  FHeight := Round(AScene.Height);
  FBuffer := TBitmap.Create;
  UpdateBuffer;
  FControls := TControlList.Create;
  FControls.Capacity := 10;
  TMessageManager.DefaultManager.SubscribeToMessage(TScaleChangedMessage,
    ScaleChangedHandler);
end;

destructor TBufferedScene.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TScaleChangedMessage,
    ScaleChangedHandler);
  DeleteChildren;
  FreeAndNil(FControls);
  FBuffer.Free;
  inherited;
end;

{$IF CompilerVersion <= 34}

procedure TBufferedScene.AddUpdateRect(R: TRectF);
{$ELSE}

procedure TBufferedScene.AddUpdateRect(const R: TRectF);
{$ENDIF}
var
  AbsoluteRect: TRectF;
begin
  if csDestroying in ComponentState then
    Exit;

  SetLength(FUpdateRects, Length(FUpdateRects) + 1);
  FUpdateRects[High(FUpdateRects)] := R;

  AbsoluteRect.TopLeft := FScene.LocalToAbsolute(R.TopLeft);
  AbsoluteRect.BottomRight := FScene.LocalToAbsolute(R.BottomRight);

  FScene.RepaintRect(AbsoluteRect);

  AbsoluteRect := R;
  FScene.RepaintRect(AbsoluteRect);
end;

procedure TBufferedScene.ChangeScrollingState(const AControl: TControl;
const Active: Boolean);
begin
end;

procedure TBufferedScene.ChildrenAlignChanged;
begin
end;

class destructor TBufferedScene.Destroy;
begin
  FScreenService := nil;
end;

procedure TBufferedScene.DisableUpdating;
begin
end;

procedure TBufferedScene.DoAddObject(const AObject: TFMXObject);
var
  ChildControl: TControl;
begin
  inherited;
  if AObject is TControl then
  begin
    ChildControl := TControl(AObject);
    ChildControl.SetNewScene(Self);
    ChildControl.RecalcOpacity;
    ChildControl.RecalcAbsolute;
    ChildControl.RecalcUpdateRect;
    ChildControl.RecalcHasClipParent;
    ChildControl.RecalcEnabled;

    FControls.Add(ChildControl);

    if ChildControl.Align = TAlignLayout.None then
      ChildControl.Repaint
    else
      Realign;
  end;
end;

procedure TBufferedScene.DoRemoveObject(const AObject: TFMXObject);
var
  ChildControl: TControl;
begin
  inherited;
  if AObject is TControl then
  begin
    ChildControl := TControl(AObject);
    FControls.Remove(ChildControl);
    ChildControl.SetNewScene(nil);
  end;
end;

procedure TBufferedScene.Invalidate;
begin
  AddUpdateRect(TRectF.Create(0, 0, FWidth, FHeight));
end;

type
  TOpenControl = class(TControl);

procedure TBufferedScene.DrawTo;
var
  I: Integer;
  Control: TControl;
begin
  if Length(FUpdateRects) = 0 then
    Exit;

  if FBuffer.Canvas.BeginScene(@FUpdateRects) then
    try
      FBuffer.Canvas.Clear(TAlphaColorRec.Null);

      for I := 0 to FControls.Count - 1 do
      begin
        Control := FControls[I];
        if Control.Visible or Control.ShouldTestMouseHits then
        begin
          if Control.UpdateRect.IsEmpty then
            Continue;
          TOpenControl(Control).PaintInternal;
        end;
      end;
    finally
      FBuffer.Canvas.EndScene;
    end;
  SetLength(FUpdateRects, 0);
end;

procedure TBufferedScene.EnableUpdating;
begin
end;

function TBufferedScene.GetCanvas: TCanvas;
begin
  Result := FBuffer.Canvas;
end;

function TBufferedScene.GetObject: TFMXObject;
begin
  Result := Self;
end;

function TBufferedScene.GetSceneScale: Single;
begin
  Result := FBuffer.BitmapScale;
end;

function TBufferedScene.GetStyleBook: TStyleBook;
begin
  if FScene.Scene = nil then
    Result := nil
  else
    Result := FScene.Scene.StyleBook;
end;

function TBufferedScene.GetUpdateRect(const Index: Integer): TRectF;
begin
  Result := FUpdateRects[Index];
end;

function TBufferedScene.GetUpdateRectsCount: Integer;
begin
  Result := Length(FUpdateRects);
end;

{$IF CompilerVersion <= 34}

function TBufferedScene.LocalToScreen(P: TPointF): TPointF;
{$ELSE}

function TBufferedScene.LocalToScreen(const P: TPointF): TPointF;
{$ENDIF}
begin
  Result := FScene.LocalToScreen(P);
end;

function TBufferedScene.ObjectAtPoint(P: TPointF): IControl;
var
  I: Integer;
  Control: TControl;
  NewObj: IControl;
begin
  if FControls.Count = 0 then
    Exit(nil);

  for I := FControls.Count - 1 downto 0 do
  begin
    Control := FControls[I];
    if not Control.Visible then
      Continue;

    NewObj := IControl(Control).ObjectAtPoint(P);
    if NewObj <> nil then
      Exit(NewObj);
  end;
end;

procedure TBufferedScene.ScaleChangedHandler(const Sender: TObject;
const Msg: System.Messaging.TMessage);
begin
  UpdateBuffer;
end;

{$IF CompilerVersion <= 34}

function TBufferedScene.ScreenToLocal(P: TPointF): TPointF;
{$ELSE}

function TBufferedScene.ScreenToLocal(const P: TPointF): TPointF;
{$ENDIF}
begin
  Result := FScene.ScreenToLocal(P);
end;

procedure TBufferedScene.Realign;
var
  Padding: TBounds;
begin
  Padding := TBounds.Create(TRectF.Empty);
  try
    AlignObjects(Self, Padding, FWidth, FHeight, FLastWidth, FLastHeight,
      FDisableAlign);
  finally
    Padding.Free;
  end;
end;

procedure TBufferedScene.UpdateBuffer;
var
  Scale: Single;
begin
  if FScene.Scene = nil then
    Scale := FScreenService.GetScreenScale
  else
    Scale := FScene.Scene.GetSceneScale;

  FBuffer.BitmapScale := Scale;
  FBuffer.SetSize(FWidth, FHeight);
  Invalidate;
end;

procedure TBufferedScene.SetSize(const AWidth, AHeight: Integer);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then
  begin
    FWidth := AWidth;
    FHeight := AHeight;
    UpdateBuffer;
    Realign;
  end;
end;

procedure TBufferedScene.SetStyleBook(const Value: TStyleBook);
begin
end;

function TBufferedScene.GetChildrenCount: Integer;
begin
  if Children = nil then
    Result := 0
  else
    Result := Children.Count;
end;

procedure TBufferedScene.Changed;
begin
end;

function TBufferedScene.GetParent: TFMXObject;
begin
  Result := FScene;
end;

Initialization

RegisterFMXClasses([TACBrCustomSecondDisplayLayout, TACBrSecondDisplayLayout]);

end.
