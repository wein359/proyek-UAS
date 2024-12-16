program SewaMobil;
uses crt;

type
  TSewa = record
    jenisMobil: string;
    hari: integer;
    jarak: integer;
    biayaHarian: real;
    biayaPerKm: real;
    totalBiaya: real;
  end;

var
  DaftarSewa: array[1..10] of TSewa;
  jumlahSewa, i: integer;
  ulangi: char;

function HitungBiayaHarian(jenisMobil: string): real;
begin
  case jenisMobil of
    'Ekonomi': HitungBiayaHarian := 300000;
    'Sedan': HitungBiayaHarian := 400000;  //untuk menghitung tarif harian mobil.
    'SUV': HitungBiayaHarian := 500000;
  else
    HitungBiayaHarian := 0; // jika inputan tidak valid.
  end;
end;

function HitungBiayaPerKm(jenisMobil: string): real;
begin
  case jenisMobil of
    'Ekonomi': HitungBiayaPerKm := 1500;
    'Sedan': HitungBiayaPerKm := 2000; //untuk menghitung tarif perjalan per km mobil.
    'SUV': HitungBiayaPerKm := 2500;
  else
    HitungBiayaPerKm := 0; // jika inputan tidak valid.
  end;
end;

procedure HitungTotalBiaya(hari: integer; jarak: integer; biayaHarian: real; biayaPerKm: real; var totalBiaya: real);
var
  i: integer;
begin
  totalBiaya := 0;
  for i := 1 to hari do
    totalBiaya := totalBiaya + biayaHarian;  //rumus untuk menghitung tarif biaya hariannya.

  while jarak > 0 do
  begin
    if jarak <= 100 then
    begin
      totalBiaya := totalBiaya + (jarak * biayaPerKm); //untuk menghitung total biaya sewa jika jarak tempuh kurang dar 100km.
      jarak := 0;
    end
    else
    begin
      totalBiaya := totalBiaya + (100 * biayaPerKm); //untuk menghitung total biaya sewa jika jarak tempuh lebih dari 100km.
      jarak := jarak - 100;
      if biayaPerKm > 1000 then
        biayaPerKm := biayaPerKm - 500;  
    end;
  end;
end;

procedure TampilkanDaftarSewa(jumlah: integer);
begin
  writeln('Data Sewa Mobil:');
  for i := 1 to jumlah do
  begin
    writeln('Sewa ', i, ':');
    writeln('  Jenis Mobil  : ', DaftarSewa[i].jenisMobil);
    writeln('  Jumlah Hari  : ', DaftarSewa[i].hari);
    writeln('  Jarak Tempuh : ', DaftarSewa[i].jarak, ' km');
    writeln('  Biaya Harian : Rp', DaftarSewa[i].biayaHarian:0:2);
    writeln('  Biaya per Km : Rp', DaftarSewa[i].biayaPerKm:0:2);
    writeln('  Total Biaya  : Rp', DaftarSewa[i].totalBiaya:0:2);
    writeln;
  end;
end;

begin
  clrscr;
  jumlahSewa := 0;

  repeat
    inc(jumlahSewa);

    write('Masukkan jenis mobil (Ekonomi/Sedan/SUV): ');
    readln(DaftarSewa[jumlahSewa].jenisMobil);

    if (DaftarSewa[jumlahSewa].jenisMobil <> 'Ekonomi') and 
       (DaftarSewa[jumlahSewa].jenisMobil <> 'Sedan') and 
       (DaftarSewa[jumlahSewa].jenisMobil <> 'SUV') then
    begin
      writeln('Jenis mobil tidak valid.');
      dec(jumlahSewa);
      continue; // langsung selesai
    end;

    write('Masukkan jumlah hari sewa: ');
    readln(DaftarSewa[jumlahSewa].hari);
    write('Masukkan jarak tempuh (km): ');
    readln(DaftarSewa[jumlahSewa].jarak);

    DaftarSewa[jumlahSewa].biayaHarian := HitungBiayaHarian(DaftarSewa[jumlahSewa].jenisMobil);
    DaftarSewa[jumlahSewa].biayaPerKm := HitungBiayaPerKm(DaftarSewa[jumlahSewa].jenisMobil);

    HitungTotalBiaya(DaftarSewa[jumlahSewa].hari, DaftarSewa[jumlahSewa].jarak, 
                     DaftarSewa[jumlahSewa].biayaHarian, DaftarSewa[jumlahSewa].biayaPerKm, 
                     DaftarSewa[jumlahSewa].totalBiaya);

    writeln('Total biaya sewa: Rp', DaftarSewa[jumlahSewa].totalBiaya:0:2);
    writeln('Apakah Anda ingin menginput ulang? (y/n)');
    readln(ulangi);
  until (ulangi <> 'y') or (jumlahSewa >= 10);

  clrscr;
  TampilkanDaftarSewa(jumlahSewa);

  writeln('Program selesai. Terima kasih!');
  readln;
end.