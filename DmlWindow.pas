unit DmlWindow;
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
    Classes,SysUtils,SDL2,DmlTextureManager,DmlColor;

type
    TDmlWindow = class
    protected
        sdlWindow : PSDL_Window;
        windowWidth,windowHeight : integer;
        windowFullscreen : boolean;
        desktopDisplayMode : TSDL_DisplayMode;
    public
        constructor Create(title:pchar;w,h:integer;fullscreen:boolean);
        destructor Free;
        function GetSDLWindow:PSDL_Window;
    end;

implementation

constructor TDmlWindow.Create(title:pchar;w,h:integer;fullscreen:boolean);
begin
    windowFullscreen:=fullscreen;
    if windowFullscreen then begin
        SDL_GetDesktopDisplayMode(0,@desktopDisplayMode);
        windowWidth:=desktopDisplayMode.w;
        windowHeight:=desktopDisplayMode.h;
        sdlWindow:=SDL_CreateWindow(title,0,0,w,h,SDL_WINDOW_FULLSCREEN_DESKTOP or SDL_WINDOW_INPUT_GRABBED);
        end
    else begin
        windowWidth:=w;
        windowHeight:=h;
        sdlWindow:=SDL_CreateWindow(title,SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,w,h,SDL_WINDOW_INPUT_GRABBED);
    end;

    if not assigned(sdlWindow) then raise Exception.Create(SDL_GetError);
    SDL_ShowWindow(sdlWindow);
end;

function TDmlWindow.GetSDLWindow:PSDL_Window;
begin
    result:=sdlWindow;
end;

destructor TDmlWindow.Free;
begin
    SDL_DestroyWindow(sdlWindow);
end;

end.
