class ModelMapel {
  final String idKelas, idMapel, namaMapel, jadwal;

  ModelMapel({
    required this.idKelas,
    required this.idMapel,
    required this.namaMapel,
    required this.jadwal,
  });

  factory ModelMapel.formJson(Map<String, dynamic> json) {
    return ModelMapel(
      idKelas: json['id_kelas'],
      idMapel: json['id_mapel'],
      namaMapel: json['nama_mapel'],
      jadwal: json['jadwal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idKelas': idKelas,
      'id_mapel': idMapel,
      'namaMapel': namaMapel,
      'jadwal': jadwal,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      "id_kelas": "",
      "id_mapel": "",
      "nama_mapel": "",
      "jadwal": "",
    };
    return ModelMapel.formJson(hapus);
  }
}
