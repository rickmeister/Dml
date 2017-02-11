unit DmlRenderer;
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
    Classes,SysUtils,SDL2,DmlWindow,DmlColor,DmlDrawable,DmlTexture;

type
    TDmlRenderModes = (rmRENDER_SOFTWARE,rmRENDER_HARDWARE,rmRENDER_TOTEXTURE,rmRENDER_VSYNC);
    TDmlRenderMode = set of TDmlRenderModes;

    TDmlRenderer = class(TObject)
    private
        class var instance : TDmlRenderer;
        sdlRenderer : PSDL_Renderer;
        sdlWindow : PSDL_Window;
        dmlWindow : TDmlWindow;
        dmlRenderMode : TDmlRenderMode;
        function CreateRenderer():boolean;
    public
        //constructor Create(wnd:PSDL_Window;mode:TDmlRenderMode);
        constructor Create(wnd:TDmlWindow;mode:TDmlRenderMode);
        destructor Free;
        procedure SetRenderTarget(target:TDmlTexture);
        procedure SetDrawColor(color:TDmlColor);
        procedure Clear;
        procedure Show;
        procedure Draw(drawable:TDmlDrawable); overload;
        procedure Draw(texture:TDmlTexture); overload;
        function CreateTexture(w,h:integer):TDmlTexture;
        function Renderer:PSDL_Renderer;
        class function GetSdlRenderer:PSDL_Renderer;
    end;

implementation

constructor TDmlRenderer.Create(wnd:TDmlWindow;mode:TDmlRenderMode);
begin
    dmlWindow:=wnd;
    dmlRenderMode:=mode;
    sdlWindow:=wnd.GetSDLWindow;
    CreateRenderer;
end;

//constructor TDmlRenderer.Create(wnd:PSDL_Window;mode:TDmlRenderMode);
function TDmlRenderer.CreateRenderer():boolean;
var
    sdlRenderFlags : cardinal;
    m : TDmlRenderModes;
begin
    sdlRenderFlags:=0;

    if (rmRENDER_SOFTWARE in dmlRenderMode) and (rmRENDER_HARDWARE in dmlRenderMode) then
        raise Exception.Create('Cannot specify both HW and SW renderer');
    for m in dmlRenderMode do begin
        if m=rmRENDER_SOFTWARE then sdlRenderFlags:=sdlRenderFlags or SDL_RENDERER_SOFTWARE;
        if m=rmRENDER_HARDWARE then sdlRenderFlags:=sdlRenderFlags or SDL_RENDERER_ACCELERATED;
        if m=rmRENDER_VSYNC then sdlRenderFlags:=sdlRenderFlags or SDL_RENDERER_PRESENTVSYNC;
        if m=rmRENDER_TOTEXTURE then sdlRenderFlags:=sdlRenderFlags or SDL_RENDERER_TARGETTEXTURE;
    end;

    sdlRenderer:=SDL_CreateRenderer(sdlWindow,-1,sdlRenderFlags);
    SDL_SetRenderDrawBlendMode(sdlRenderer,SDL_BLENDMODE_MOD);
    instance:=self;
end;

procedure TDmlRenderer.SetRenderTarget(target:TDmlTexture);
begin
    if assigned(target) then
        SDL_SetRenderTarget(sdlRenderer,target.Texture)
    else
        SDL_SetRenderTarget(sdlRenderer, nil);
end;

procedure TDmlRenderer.SetDrawColor(color:TDmlColor);
begin
    SDL_SetRenderDrawColor(sdlRenderer,color.r,color.g,color.b,color.a);
end;

procedure TDmlRenderer.Clear;
begin
    SDL_RenderClear(sdlRenderer);
end;

procedure TDmlRenderer.Show;
begin
    SDL_RenderPresent(sdlRenderer);
end;

procedure TDmlRenderer.Draw(drawable:TDmlDrawable);
begin
    drawable.Render(sdlRenderer);
end;

procedure TDmlRenderer.Draw(texture:TDmlTexture);
begin
    SDL_RenderCopy(sdlRenderer,texture.Texture,nil,nil);
end;

function TDmlRenderer.CreateTexture(w,h:integer):TDmlTexture;
begin
    result:=TDmlTexture.Create(w,h);
end;

function TDmlRenderer.Renderer:PSDL_Renderer;
begin
    result:=sdlRenderer;
end;

class function TDmlRenderer.GetSdlRenderer:PSDL_Renderer;
begin
    result:=instance.sdlRenderer;
end;

destructor TDmlRenderer.Free;
begin
    SDL_DestroyRenderer(sdlRenderer);
end;

end.
