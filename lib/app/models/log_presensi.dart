class LogPresensi {
  // "id_detail_presensi": "6",
  //           "id_presensi": "24",
  //           "nis": "12345678",
  //           "timestamp": "2022-12-24 13:51:00",
  //           "kehadiran": "1",
  //           "koordinat": null,
  //           "bukti_izin": null,
  //           "id_jadwal": "54",
  //           "mulai_presensi": "2022-12-24 13:00:00",
  //           "akhir_presensi": "2022-12-24 15:00:00"
  String? idDetailPresensi,
      idPresensi,
      nis,
      timestamp,
      kehadiran,
      koordinat,
      buktiIzin,
      idJadwal,
      mulaiPresensi,
      akhirPresensi;
  LogPresensi({
    this.idDetailPresensi,
    this.idPresensi,
    this.nis,
    this.timestamp,
    this.kehadiran,
    this.koordinat,
    this.buktiIzin,
    this.idJadwal,
    this.mulaiPresensi,
    this.akhirPresensi,
  });

  factory LogPresensi.fromJson(Map<String, dynamic> json) {
    return LogPresensi(
      idDetailPresensi: json['id_detail_presensi'],
      idPresensi: json['id_presensi'],
      nis: json['nis'],
      timestamp: json['timestamp'],
      kehadiran: json['kehadiran'],
      koordinat: json['koordinat'],
      buktiIzin: json['bukti_izin'],
      idJadwal: json['id_jadwal'],
      mulaiPresensi: json['mulai_presensi'],
      akhirPresensi: json['akhir_presensi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_detail_presensi': idDetailPresensi,
      'id_presensi': idPresensi,
      'nis': nis,
      'timestamp': timestamp,
      'kehadiran': kehadiran,
      'koordinat': koordinat,
      'bukti_izin': buktiIzin,
      'id_jadwal': idJadwal,
      'mulai_presensi': mulaiPresensi,
      'akhir_presensi': akhirPresensi,
    };
  }
}
