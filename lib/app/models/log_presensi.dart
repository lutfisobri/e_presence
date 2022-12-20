class LogPresensi {
  final String? id, nis, nama, tanggal, jam, keterangan;
  LogPresensi({
    this.id,
    this.nis,
    this.nama,
    this.tanggal,
    this.jam,
    this.keterangan,
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
