class ModelUjian {
  final String idMapel, idKelas, namaMapel, jadwal, kelas;

  ModelUjian({
    required this.idMapel,
    required this.idKelas,
    required this.namaMapel,
    required this.jadwal,
    required this.kelas,
    }
  );

  factory ModelUjian.formJson(Map<String, dynamic> json) {
    return ModelUjian(
      idMapel: json['id_mapel'],
      idKelas: json['id_kelas'],
      namaMapel: json['nama_mapel'],
      jadwal: json['jadwal'],
      kelas: json['kelas'],
    );
  }
}
