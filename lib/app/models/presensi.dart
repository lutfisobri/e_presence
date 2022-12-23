class ModelPresensi {
  String? namaMapel, idPresensi, mulaiPresensi, akhirPresensi, hari, jamKe, idKelas;

  ModelPresensi({
    this.namaMapel,
    this.idPresensi,
    this.mulaiPresensi,
    this.akhirPresensi,
    this.hari,
    this.jamKe,
    this.idKelas,
  });

  factory ModelPresensi.formJson(Map<String, dynamic> json) {
    return ModelPresensi(
      namaMapel: json['namaMapel'],
      idPresensi: json['idPresensi'],
      mulaiPresensi: json['mulaiPresensi'],
      akhirPresensi: json['akhirPresensi'],
      hari: json['hari'],
      jamKe: json['jamKe'],
      idKelas: json['idKelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPresensi': idPresensi,
      'mulaiPresensi': mulaiPresensi,
      'akhirPresensi': akhirPresensi,
      'hari': hari,
      'jamKe': jamKe,
      'idKelas': idKelas,
    };
  }
}
