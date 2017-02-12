unit DmlGraphicsWindow;
{*********************************************************************}
{        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE                  }
{                Version 2, December 2004                             }
{     Copyright (C) 2017 Rickard "Rickmeister" Isaksson               }
{               rickmeister@programmer.net                            }
{                                                                     }
{ Everyone is permitted to copy and distribute verbatim or modified   }
{ copies of this license document, and changing it is allowed as long }
{ as the name is changed.                                             }
{                                                                     }
{            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE              }
{   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION   }
{                                                                     }
{  0. You just DO WHAT THE FUCK YOU WANT TO.                          }
{*********************************************************************}
{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
    Classes,SysUtils,DmlWindow,DmlRenderer,DmlColor,DmlDrawable,DmlTexture,
    DmlTextureManager,SDL2;

type
    TDmlGraphicsWindow = class(TDmlWindow)
    protected
        dmlRenderer : TDmlRenderer;
        dmlTextureManager : TDmlTextureManager;
        renderWidth,renderHeight : integer;
    public
        constructor Create(title:AnsiString;w,h,rw,rh:integer;fullscreen:boolean);
        destructor Free;
        function Renderer:TDmlRenderer;
        procedure Draw(drawable:TDmlDrawable);
        procedure Clear;
        procedure Show;
    end;
implementation

constructor TDmlGraphicsWindow.Create(title:AnsiString;w,h,rw,rh:integer;fullscreen:boolean);
begin
    inherited Create(title,w,h,fullscreen);
    renderWidth:=rw;
    renderHeight:=rh;
    dmlRenderer:=TDmlRenderer.Create(self,[rmRENDER_HARDWARE, rmRENDER_TOTEXTURE]);
    dmlRenderer.SetScale(renderWidth,renderHeight);
    writeln(renderWidth,'x',renderHeight);
    dmlTextureManager:=TDmlTextureManager.Create(dmlRenderer.Renderer);
    dmlRenderer.SetDrawColor(TDmlColor.dmlBLUE);
    dmlRenderer.Show;
end;

function TDmlGraphicsWindow.Renderer:TDmlRenderer;
begin
    result:=dmlRenderer;
end;

procedure TDmlGraphicsWindow.Draw(drawable:TDmlDrawable);
begin
    dmlRenderer.Draw(drawable);
end;

procedure TDmlGraphicsWindow.Clear;
begin
    dmlRenderer.Clear;
end;

procedure TDmlGraphicsWindow.Show;
begin
    dmlRenderer.Show;
end;

destructor TDmlGraphicsWindow.Free;
begin
    dmlRenderer.Free;
    dmlTextureManager.Free;
    inherited;
end;
end.
