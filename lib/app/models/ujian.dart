class ModelUjian {
  final String idMapel, idKelas, namaMapel, hari, jamAwal, jamAkhir, kelas;

  ModelUjian({
    required this.idMapel,
    required this.idKelas,
    required this.namaMapel,
    required this.hari,
    required this.jamAwal,
    required this.jamAkhir,
    required this.kelas,
  });

  factory ModelUjian.formJson(Map<String, dynamic> json) {
    return ModelUjian(
      idMapel: json['id_mapel'],
      idKelas: json['id_kelas'],
      namaMapel: json['nama_mapel'],
      hari: json['hari'],
      jamAwal: json['jam_awal'],
      jamAkhir: json['jam_akhir'],
      kelas: json['kelas'],
    );
  }
}
