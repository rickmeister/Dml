unit DmlTexture;
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
    Classes,SysUtils,SDL2,DmlTextureManager,DmlUtil, DmlResource;

type
    TDmlTexture = class(TDmlResource<PSDL_Texture>)
        sdlTexture : PSDL_Texture;
        w,h : integer;
        id : integer;
        constructor Create(filename:string); overload;
        constructor Create(width,height:integer); overload;
        function Texture:PSDL_Texture;
    end;
implementation

constructor TDmlTexture.Create(filename:string);
var
    ti : TDmlTextureInfo;
begin
    ti:=TDmlTextureManager.GetInstance.Load(filename);
    sdlTexture:=ti.sdlTexture;
    w:=ti.width;
    h:=ti.height;
    id:=ti.id;
end;

constructor TDmlTexture.Create(width,height:integer);
var
    ti : TDmlTextureInfo;
begin
    ti:=TDmlTextureManager.GetInstance.CreateTexture(width,height);
    sdlTexture:=ti.sdlTexture;
    w:=ti.width;
    h:=ti.height;
    id:=ti.id;
end;

function TDmlTexture.Texture:PSDL_Texture;
begin
    result:=sdlTexture;
end;

end.
