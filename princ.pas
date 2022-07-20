unit princ;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, UniProvider,
  SQLiteUniProvider, Data.DB, DBAccess, Uni, FMX.Edit, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Edit2: TEdit;
    PasswordEditButton1: TPasswordEditButton;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    UniConnection1: TUniConnection;
    SQLiteUniProvider1: TSQLiteUniProvider;
    ComboBox1: TComboBox;
    StyleBook1: TStyleBook;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tipo:string;

implementation
uses system.IOUtils;
{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
begin
if OpenDialog1.FileName='' then begin
ShowMessage('Devi selezionare un database...');
Button2.Enabled:=false;
Button3.Enabled:=false;
Combobox1.Enabled:=false;
exit
end
else begin
Edit1.Text:=TPath.GetFullPath(OPenDialog1.FileName);
Button2.Enabled:=true;
Button3.Enabled:=true;
Combobox1.Enabled:=true;
end;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if (Edit1.Text.Length)>8 then
begin
UniConnection1.Database:=OpenDialog1.FileName;
UniConnection1.SpecificOptions.Values['EncryptionAlgorithm'] :=tipo;
UniConnection1.Open;
try
TLiteUtils.EncryptDatabase(UniConnection1,Edit1.Text);
finally
UniConnection1.Close;
ShowMessage('Protezione del db applicata con successo!');
end;
end
else ShowMessage('Devi digitare una password superiore a 8 caratteri!');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
UniConnection1.Database:=OpenDialog1.FileName;
UniConnection1.SpecificOptions.Values['EncryptionAlgorithm'] :=tipo;
UniConnection1.SpecificOptions.Values['EncryptionKey'] :=Edit1.Text;
UniConnection1.Open;
try
TLiteUtils.EncryptDatabase(UniConnection1,'');
finally
UniConnection1.Close;
ShowMessage('Protezione rimossa');
end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
tipo:='le'+combobox1.Selected.Text;
end;

end.
