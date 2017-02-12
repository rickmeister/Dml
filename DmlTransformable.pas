unit DmlTransformable;
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
    Classes,SysUtils,DmlUtil;

type
    TDmlTransformable = class(TInterfacedObject)
    protected
        dmlClipRect : TDmlClipRect;
        position : TDmlVector2d;
        origin : TDmlVector2d;
        scale : TDmlVector2d;
    public
        procedure SetPosition(x,y:double);
        procedure Move(x,y:double);
        constructor Create;
        destructor Free;
    end;

implementation

constructor TDmlTransformable.Create;
begin
    inherited;
    position:=TDmlVector2d.Create;
    origin:=TDmlVector2d.Create;
    scale:=TDmlVector2d.Create;
end;

procedure TDmlTransformable.SetPosition(x,y:double);
begin
    position.x:=x;
    position.y:=y;
end;

procedure TDmlTransformable.Move(x,y:double);
begin
    position.x:=position.x+x;
    position.y:=position.y+y;
end;

destructor TDmlTransformable.Free;
begin
    position.Free;
    origin.Free;
    scale.Free;
end;

end.
