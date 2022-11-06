class ModelMapel {
  final String idKelas, idMapel, namaMapel, hari, jamAwal, jamAkhir;

  ModelMapel({
    required this.idKelas,
    required this.idMapel,
    required this.namaMapel,
    required this.hari,
    required this.jamAwal,
    required this.jamAkhir,
  });

  factory ModelMapel.formJson(Map<String, dynamic> json) {
    return ModelMapel(
      idKelas: json['id_kelas'],
      idMapel: json['id_mapel'],
      namaMapel: json['nama_mapel'],
      hari: json['hari'],
      jamAwal: json['jam_awal'],
      jamAkhir: json['jam_akhir'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idKelas': idKelas,
      'id_mapel': idMapel,
      'nama_mapel': namaMapel,
      'hari': hari,
      'jam_awal': jamAwal,
      'jam_akhir': jamAkhir,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      "id_kelas": "",
      "id_mapel": "",
      "nama_mapel": "",
      "hari": "",
      "jam_awal": "",
      "jam_akhir": ""
    };
    return ModelMapel.formJson(hapus);
  }
}
