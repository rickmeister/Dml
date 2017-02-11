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
{$MODE DELPHI}

interface

uses
    Classes,SysUtils,DmlWindow,DmlRenderer,DmlColor,DmlTexture,
    DmlTextureManager,SDL2;

type
    TDmlGraphicsWindow = class(TDmlWindow)
    protected
        dmlRenderer : TDmlRenderer;
        dmlTextureManager : TDmlTextureManager;
        renderWidth,renderHeight : integer;
        renderCanvas : TDmlTexture;
    public
        constructor Create(title:pchar;w,h,rw,rh:integer;fullscreen:boolean);
        destructor Free;
    end;
implementation

constructor TDmlGraphicsWindow.Create(title:pchar;w,h,rw,rh:integer;fullscreen:boolean);
begin
    inherited Create(title,w,h,fullscreen);
    renderWidth:=rw;
    renderHeight:=rh;
    dmlRenderer:=TDmlRenderer.Create(self,[rmRENDER_HARDWARE, rmRENDER_TOTEXTURE]);
    writeln(SDL_GetError);
    dmlTextureManager:=TDmlTextureManager.Create(dmlRenderer.Renderer);
    renderCanvas:=TDmlTexture.Create(renderWidth,renderHeight);
    dmlRenderer.SetRenderTarget(renderCanvas);
    dmlRenderer.SetDrawColor(TDmlColor.dmlBLUE);
    dmlRenderer.Clear;
    dmlRenderer.SetRenderTarget(nil);
    dmlRenderer.Draw(renderCanvas);
    dmlRenderer.Show;
end;

destructor TDmlGraphicsWindow.Free;
begin
    inherited;
    dmlRenderer.Free;
    dmlTextureManager.Free;
    renderCanvas.Free;
end;
end.
