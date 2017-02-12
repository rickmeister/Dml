unit DmlShape;
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
    Classes,SysUtils,DmlTransformable,DmlDrawable,DmlTexture,DmlColor,DmlUtil,SDL2;

type
    TDmlShape = class(TDmlDrawable)
    protected
        dmlTexture : TDmlTexture;
        dmlColor : TDmlColor;
        vertices : array of TDmlVertex;
        sdlClipRect : TSDL_Rect;
    public
        procedure SetTexture(var t:TDmlTexture);
        procedure ClearTexture;
        procedure SetFillColor(c:TDmlColor);
        procedure Render(sdlRenderer:PSDL_Renderer); override;
        function GetVertexCount: integer;
        function GetNativeClipRect: TDmlClipRect;
        function GetSDLClipRect : TSDL_Rect;
    end;

implementation
procedure TDmlShape.SetTexture(var t:TDmlTexture);
begin
    dmlTexture:=t;
end;

procedure TDmlShape.ClearTexture;
begin
    dmlTexture:=nil;
end;

procedure TDmlShape.SetFillColor(c:TDmlColor);
begin
    dmlColor:=c;
end;

function TDmlShape.GetNativeClipRect: TDmlClipRect;
begin
    result:=dmlClipRect;
end;

function TDmlShape.GetSDLClipRect: TSDL_Rect;
begin
    result:=sdlClipRect;
end;

function TDmlShape.GetVertexCount: integer;
begin
    result:=Length(vertices);
end;

procedure TDmlShape.Render(sdlRenderer:PSDL_Renderer);
begin
    if assigned(dmlTexture) then begin
        SDL_RenderCopy(sdlRenderer, dmlTexture.Texture, nil, nil);
    end;
end;
end.

