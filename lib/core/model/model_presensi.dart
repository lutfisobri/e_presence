class ModelPresensi {
  String idPresensi, idMapel, namaMapel, jamAwal, jamAkhir, kelas;
  ModelPresensi({
    required this.idPresensi,
    required this.idMapel,
    required this.namaMapel,
    required this.jamAwal,
    required this.jamAkhir,
    required this.kelas,
  });

  factory ModelPresensi.formJson(Map<String, dynamic> json) {
    return ModelPresensi(
      idPresensi: json['id_presensi'],
      idMapel: json['id_mapel'],
      namaMapel: json['nama_mapel'],
      jamAwal: json['jam_awal'],
      jamAkhir: json['jam_akhir'],
      kelas: json['kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_presensi': idPresensi,
      'id_mapel': idMapel,
      'nama_mapel': namaMapel,
      'jam_awal': jamAwal,
      'jam_akhir': jamAkhir,
      'kelas': kelas,
    };
  }
}
