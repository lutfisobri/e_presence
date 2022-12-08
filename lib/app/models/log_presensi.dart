class LogPresensi {
  final String id, nis, nama, tanggal, jam, keterangan;
  LogPresensi({
    required this.id,
    required this.nis,
    required this.nama,
    required this.tanggal,
    required this.jam,
    required this.keterangan,
  });

  factory LogPresensi.fromJson(Map<String, dynamic> json) {
    return LogPresensi(
      id: json['id'],
      nis: json['nis'],
      nama: json['nama'],
      tanggal: json['tanggal'],
      jam: json['jam'],
      keterangan: json['keterangan'],
    );
  }
}
