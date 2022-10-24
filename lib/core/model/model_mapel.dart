class ModelMapel {
  final String idMapel, namaMapel, hari, idKelas;

  ModelMapel({
    required this.idMapel,
    required this.namaMapel,
    required this.hari,
    required this.idKelas,
  });

  factory ModelMapel.formJson(Map<String, dynamic> json) {
    return ModelMapel(
      idMapel: json['id_mapel'],
      namaMapel: json['nama_mapel'],
      hari: json['hari'],
      idKelas: json['id_kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_mapel': idMapel,
      'namaMapel': namaMapel,
      'hari': hari,
      'idKelas': idKelas,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      "id_mapel": "",
      "nama_mapel": "",
      "hari": "",
      "id_kelas": ""
    };
    return ModelMapel.formJson(hapus);
  }
}
