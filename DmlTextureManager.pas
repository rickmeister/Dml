unit DmlTextureManager;
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
    Classes,SysUtils,DmlUtil,SDL2,SDL2_image;
type
    TDmlResourceLoader<T,R> = class
    protected
        loadedResource : array of T;
    end;

    TDmlTextureManager = class(TObject)
    private
        class var loadedTextures : array of TDmlTextureInfo;
        class var sdlRenderer : PSDL_Renderer;
        class var instance : TDmlTextureManager;

        nextId : cardinal;

        function Find(filename:string):integer;
    public
        constructor Create(r:PSDL_Renderer);
        destructor Free;
        function Load(filename:string):TDmlTextureInfo;
        function CreateTexture(w,h:integer):TDmlTextureInfo;
        class function GetInstance:TDmlTextureManager;
    end;
implementation

constructor TDmlTextureManager.Create(r:PSDL_Renderer);
var
    t : PSDL_Texture;
    ti : TDmlTextureInfo;
begin
    if not assigned(instance) then begin
        instance:=self;
        sdlRenderer:=r;
        SetLength(loadedTextures,1);
        t:=SDL_CreateTexture(sdlRenderer,SDL_PIXELFORMAT_RGBA8888,SDL_TEXTUREACCESS_STATIC,64,64);
        ti:=TDmlTextureInfo.Create(t,64,64,0,'NIL-TEXTURE');
        loadedTextures[0]:=ti;
        nextId:=1;
        end
    else
        self:=instance;
end;

destructor TDmlTextureManager.Free;
var
    i : integer;
begin
    for i:=Low(loadedTextures) to High(loadedTextures) do begin
        if assigned(loadedTextures[i]) then SDL_DestroyTexture(loadedTextures[i].sdlTexture);
        loadedTextures[i].Free;
    end;
    instance:=nil;
    sdlRenderer:=nil;
    SetLength(loadedTextures,0);
end;

function TDmlTextureManager.Find(filename:string):integer;
var
    t : TDmlTextureInfo;
begin
    for t in loadedTextures do begin
        if assigned (t) and (t.name=filename) then begin
            writeln('Texture found ', t.name);
            exit(t.id);
        end;
    end;
    result:=-1;
end;

function TDmlTextureManager.Load(filename:string):TDmlTextureInfo;
var
    index : integer;
    image : PSDL_Surface;
    texture : PSDL_Texture;
begin
    index:=Find(filename);
    if index > 0 then begin 
        result:=loadedTextures[index];
        end
    else begin
        image:=IMG_Load(PAnsiChar(@filename));
        if not assigned(image) then begin
            writeln(IMG_GetError);
            exit(loadedTextures[0]);
        end;
        texture:=SDL_CreateTextureFromSurface(sdlRenderer,image);
        SetLength(loadedTextures, Length(loadedTextures)+1);
        loadedTextures[High(loadedTextures)]:=TDmlTextureInfo.Create(texture,image^.w, image^.h,nextId,filename);
        writeln('Texture loaded: ', filename);
        Inc(nextId);
        SDL_FreeSurface(image);
        result:=loadedTextures[High(loadedTextures)];
    end;
end;

function TDmlTextureManager.CreateTexture(w,h:integer):TDmlTextureInfo;
var
    t : PSDL_Texture;
    ti : TDmlTextureInfo;
    tname : string;
begin
    t:=SDL_CreateTexture(sdlRenderer,SDL_PIXELFORMAT_RGBA8888,SDL_TEXTUREACCESS_TARGET,w,h);
    tname:='Texture'+IntToStr(nextId);
    ti:=TDmlTextureInfo.Create(t,w,h,nextId,tname);
    SetLength(loadedTextures,Length(loadedTextures)+1);
    loadedTextures[High(loadedTextures)]:=ti;
    writeln('Created texture '+tname);
    Inc(nextId);
    result:=ti;
    writeln('DmlTextureManager.pas 113: ', SDL_GetError);
end;

class function TDmlTextureManager.GetInstance:TDmlTextureManager;
begin
    result:=instance;
end;

end.
