unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtDlgs,
  ExtCtrls, LCLIntf;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  // 1. Выполняем диалог открытия файла.
  // Метод Execute показывает окно диалога.
  // Он возвращает True, если пользователь нажал "OK", и False, если "Отмена".
  if OpenPictureDialog1.Execute then
  begin
    // 2. Если файл выбран, загружаем его в Picture компонента Image1.
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  imgWidth, imgHeight: Integer;
  px, py: Integer;
  TempBitmap: TBitmap;
begin

  if Image1.Picture.Bitmap.Width = 0 then
  begin
    ShowMessage('Сначала откройте изображение!');
    Exit;
  end;

  TempBitmap := TBitmap.Create;
  TempBitmap.PixelFormat := pf24bit;
  TempBitmap.Width := Image1.Picture.Bitmap.Width;
  TempBitmap.Height := Image1.Picture.Bitmap.Height;

  TempBitmap.Canvas.Draw(0, 0, Image1.Picture.Bitmap);

  Image1.Picture.Bitmap.Assign(TempBitmap);
  TempBitmap.Free;

  imgWidth := Image1.Picture.Bitmap.Width;
  imgHeight := Image1.Picture.Bitmap.Height;

  with Image1.Picture.Bitmap do
  begin
    // ТОЧКА 1: Верхний левый угол - СИНИЙ (0, 0, 255)
    for py := 0 to 4 do
      for px := 0 to 4 do
        Canvas.Pixels[px, py] := RGB(0, 0, 255);

    // ТОЧКА 2: Центр верхней строки - ЖЕЛТЫЙ (255, 255, 0)
    for py := 0 to 4 do
      for px := -2 to 2 do
        Canvas.Pixels[imgWidth div 2 + px, py] := RGB(255, 255, 0);

    // ТОЧКА 3: Центр изображения - ПУРПУРНЫЙ (255, 0, 255)
    for py := -2 to 2 do
      for px := -2 to 2 do
        Canvas.Pixels[imgWidth div 2 + px, imgHeight div 2 + py] := RGB(255, 0, 255);
  end;

  Image1.Refresh;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

end.
