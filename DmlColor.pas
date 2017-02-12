unit DmlColor;
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
 {$M+}
interface

uses
    Classes,SysUtils;

type
    TDmlColor = class(TObject)
    private
        red,green,blue,alpha : byte;
    public
        class var dmlRED,dmlBLUE,dmlGREEN,dmlGREY,dmlWHITE,dmlBLACK : TDmlColor;
        constructor Create(r,g,b,a:byte); overload;
        constructor Create(rgba:cardinal); overload;
    published
        property r : byte read red write red;
        property g : byte read green write green;
        property b : byte read blue write blue;
        property a : byte read alpha write alpha;
    end;

implementation

constructor TDmlColor.Create(r,g,b,a:byte);
begin
    red:=r;
    green:=g;
    blue:=b;
    alpha:=a;
end;

//TODO: Fix this!
constructor TDmlColor.Create(rgba:cardinal);
begin
    r:=Byte(rgba shl 3);
    g:=Byte(rgba shl 2);
    b:=Byte(rgba shl 1);
    a:=Byte(rgba and $000000FF);
end;

initialization
TDmlColor.dmlRED:=TDmlColor.Create(255,0,0,255);
TDmlColor.dmlGREEN:=TDmlColor.Create(0,255,0,255);
TDmlColor.dmlBLUE:=TDmlColor.Create(0,0,255,255);
TDmlColor.dmlGREY:=TDmlColor.Create(128,128,128,255);
TDmlColor.dmlWHITE:=TDmlColor.Create(255,255,255,255);
TDmlColor.dmlBLACK:=TDmlColor.Create(0,0,0,255);

finalization
TDmlColor.dmlRED.Free;
TDmlColor.dmlGREEN.Free;
TDmlColor.dmlBLUE.Free;
TDmlColor.dmlGREY.Free;
TDmlColor.dmlWHITE.Free;
TDmlColor.dmlBLACK.Free;
end.

