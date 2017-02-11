unit DmlRectangleShape;
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
    Classes,SysUtils,DmlShape,DmlUtil,SDL2;

type
    TDmlRectangleShape = class(TDmlShape)
        constructor Create(x,y,w,h:double);
        destructor Free;
        procedure Render(sdlRenderer:PSDL_Renderer); override;
    end;

implementation

constructor TDmlRectangleShape.Create(x,y,w,h:double);
begin
    SetLength(vertices, 4);
    vertices[0]:=TDmlVertex.Create; vertices[0].x:=x; vertices[0].y:=y;
    vertices[1]:=TDmlVertex.Create; vertices[1].x:=x; vertices[1].y:=y+h;
    vertices[2]:=TDmlVertex.Create; vertices[2].x:=x+w; vertices[2].y:=y+h;
    vertices[3]:=TDmlVertex.Create; vertices[3].x:=x+w; vertices[3].y:=y;
    sdlClipRect.x:=round(x);
    sdlClipRect.y:=round(y);
    sdlClipRect.w:=round(w);
    sdlClipRect.h:=round(h);
    dmlClipRect:=TDmlClipRect.Create(x,y,w,h);
end;

destructor TDmlRectangleShape.Free;
var
    i : integer;
begin
    dmlClipRect.Free;
    for i:=Low(vertices) to High(vertices) do vertices[i].Free;
    dmlColor.Free;
end;

procedure TDmlRectangleShape.Render(sdlRenderer:PSDL_Renderer);
begin
    if assigned(dmlTexture) then begin
        SDL_RenderCopy(sdlRenderer,dmlTexture.sdlTexture,nil,@sdlClipRect);
    end;

    if assigned(dmlColor) then begin
        SDL_SetRenderDrawColor(sdlRenderer,dmlColor.r,dmlColor.g,dmlColor.b,dmlColor.a);
        SDL_RenderFillRect(sdlRenderer,@sdlClipRect);
    end;
end;

end.

