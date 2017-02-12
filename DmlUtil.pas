unit DmlUtil;
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
    Classes,SysUtils,SDL2;

type

    TDmlTextureInfo = class(TObject)
        width,height : integer;
        name : string;
        refCount : integer;
        id : integer;
        sdlTexture : PSDL_Texture;
        constructor Create(var t:PSDL_Texture;w,h,i:integer;n:string);
    end;

    TDmlPoint = class(TObject)
        x,y:double;
    end;

    TDmlVertex = TDmlPoint; //TODO: Fix this?
    TDmlVector2d = TDmlPoint;

    TDmlVector2s = class(TObject)
        x,y : single;
    end;

    TDmlEllipse = class(TObject)
        x,y,w,h : double;
    end;

    TDmlClipRect = class(TObject)
        x,y,w,h : double;
        constructor Create(a,b,c,d:double);
    end;

function Convert(clip:TDmlClipRect):TSDL_Rect; overload;
function Convert(point:TDmlPoint):TSDL_Point; overload;

implementation
constructor TDmlTextureInfo.Create(var t:PSDL_Texture;w,h,i:integer;n:string);
begin
    sdlTexture:=t;
    width:=w;
    height:=h;
    id:=i;
    name:=n;
    refCount:=0;
end;

constructor TDmlClipRect.Create(a,b,c,d:double);
begin
    x:=a; y:=b; w:=c; h:=d;
end;

function Convert(clip:TDmlClipRect):TSDL_Rect;
begin
    result.x:=round(clip.x);
    result.y:=round(clip.y);
    result.w:=round(clip.w);
    result.h:=round(clip.h);
end;

function Convert(point:TDmlPoint):TSDL_Point;
begin
    result.x:=round(point.x);
    result.y:=round(point.y);
end;
end.
