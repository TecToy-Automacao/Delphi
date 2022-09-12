unit Service.Base;

interface

uses
  System.SysUtils, System.Classes;

type
  TServiceBase = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceBase: TServiceBase;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
