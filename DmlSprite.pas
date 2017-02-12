unit DmlSprite;
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
    Classes,SysUtils,SDL2,DmlRectangleShape,DmlTexture,DmlColor;

type
    TDmlSprite = class(TDmlRectangleShape)
        constructor Create(x,y:double;texture:TDmlTexture);
    end;
implementation

constructor TDmlSprite.Create(x,y:double;texture:TDmlTexture);
begin
    inherited Create(x,y,texture.w,texture.h);
    SetTexture(texture);
end;

end.
