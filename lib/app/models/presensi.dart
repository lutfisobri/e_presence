class ModelPresensi {
  String idPresensi, namaGuru, namaMapel, jamAwal, jamAkhir, namaKelas;
  ModelPresensi({
    required this.idPresensi,
    required this.namaGuru,
    required this.namaMapel,
    required this.jamAwal,
    required this.jamAkhir,
    required this.namaKelas,
  });

  factory ModelPresensi.formJson(Map<String, dynamic> json) {
    return ModelPresensi(
      idPresensi: json['id_presensi'],
      namaGuru: json['nama_guru'],
      namaMapel: json['nama_mapel'],
      jamAwal: json['jam_awal'],
      jamAkhir: json['jam_akhir'],
      namaKelas: json['nama_kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_presensi': idPresensi,
      'nama_guru': namaGuru,
      'nama_mapel': namaMapel,
      'jam_awal': jamAwal,
      'jam_akhir': jamAkhir,
      'nama_kelas': namaKelas,
    };
  }
}
