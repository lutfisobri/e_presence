import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> tabItems = [
  {
    "id": 1,
    "day": "senin",
  },
  {
    "id": 2,
    "day": "selasa",
  },
  {
    "id": 3,
    "day": "rabu",
  },
  {
    "id": 4,
    "day": "kamis",
  },
  {
    "id": 5,
    "day": "jumat",
  },
  {
    "id": 6,
    "day": "sabtu",
  },
];

const colorGreen = Color.fromARGB(255, 114, 182, 108);
const textColor = Color.fromARGB(255, 87, 87, 87);
const selectedColor = Colors.black;
const unSelectedColor = Color(0XFF777777);

enum Pelajaran { presensi, mapel, ujian }

Widget iconMapel(PelajaranProvider pelProv, int index, {Pelajaran? jenis}) {
  var nama = (jenis == Pelajaran.mapel)
      ? pelProv.listMapel[index].namaMapel
      : (jenis == Pelajaran.presensi)
          ? pelProv.listPresensi[index].namaMapel
          : pelProv.listUjian[index].namaMapel;
  switch (nama!.toLowerCase()) {
    case "agama":
      return Image.asset("assets/mapel/agama.png");
    case "bahasa indonesia":
      return Image.asset("assets/mapel/bahasaIndonesia.png");
    case "bahasa inggris":
      return Image.asset("assets/mapel/bahasaInggris.png");
    case "bahasa daerah madura":
      return Image.asset("assets/mapel/bahasaMadura.png");
    case "bahasa sastra arab":
      return Image.asset("assets/mapel/bahasaSastraArab.png");
    case "bahasa sastra indonesia":
      return Image.asset("assets/mapel/bahasaSastraIndonesia.png");
    case "bimbingan konseling":
      return Image.asset("assets/mapel/bimbinganKonseling.png");
    case "biologi":
      return Image.asset("assets/mapel/biologi.png");
    case "ekonomi":
      return Image.asset("assets/mapel/ekonomi.png");
    case "fisika":
      return Image.asset("assets/mapel/fisika.png");
    case "geografi":
      return Image.asset("assets/mapel/geografi.png");
    case "kimia":
      return Image.asset("assets/mapel/kimia.png");
    case "matematika":
      return Image.asset("assets/mapel/matematika.png");
    case "matematika peminatan":
      return Image.asset("assets/mapel/matematikaPeminatan.png");
    case "pendidikan jasmani, olahraga, dan kesehatan":
      return Image.asset("assets/mapel/pjok.png");
    case "pendidikan pancasila dan kewarganegaraan":
      return Image.asset("assets/mapel/pkn.png");
    case "pendidikan prakarya dan kewirausahaan ":
      return Image.asset("assets/mapel/pkwu.png");
    case "sejarah":
      return Image.asset("assets/mapel/sejarah.png");
    case "sejarah indonesia":
      return Image.asset("assets/mapel/sejarahIndonesia.png");
    case "seni budaya":
      return Image.asset("assets/mapel/seniBudaya.png");
    case "seni teater":
      return Image.asset("assets/mapel/seniTeater.png");
    case "sosiologi":
      return Image.asset("assets/mapel/sosiologi.png");
    case "teknik informatika":
      return Image.asset("assets/mapel/ti.png");
    default:
      return Container(color: colorGreen);
  }
}
