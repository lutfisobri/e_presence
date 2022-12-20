class ModelUjian {
  final String? idMapel, idKelas, namaMapel, hari, jamAwal, jamAkhir, kelas;

  ModelUjian({
    this.idMapel,
    this.idKelas,
    this.namaMapel,
    this.hari,
    this.jamAwal,
    this.jamAkhir,
    this.kelas,
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
