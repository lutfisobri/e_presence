class SubmitPresensi {
  String nis, status, koordinat, idPresensi, idMapel, idKelas;
  SubmitPresensi({
    required this.nis,
    required this.status,
    required this.koordinat,
    required this.idPresensi,
    required this.idMapel,
    required this.idKelas,
  });

  factory SubmitPresensi.send(Map<String, dynamic> json) {
    return SubmitPresensi(
      nis: json['nis'],
      status: json['status'],
      koordinat: json['koordinat'],
      idPresensi: json['id_presensi'],
      idMapel: json['id_mapel'],
      idKelas: json['id_kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': nis,
      'status': status,
      'koordinat': koordinat,
      'id_presensi': idPresensi,
      'id_mapel': idMapel,
      'id_kelas': idKelas,
    };
  }
}