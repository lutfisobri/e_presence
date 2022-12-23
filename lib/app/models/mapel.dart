class ModelMapel {
  String? hari, pelajaran, jamMulai, jamSelesai;

  ModelMapel({
    this.hari,
    this.pelajaran,
    this.jamMulai,
    this.jamSelesai,
  });

  factory ModelMapel.formJson(Map<String, dynamic> json) {
    return ModelMapel(
      hari: json['hari'].toString(),
      pelajaran: json['pelajaran'].toString(),
      jamMulai: json['jam_mulai'].toString(),
      jamSelesai: json['jam_selesai'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hari': hari,
      'pelajaran': pelajaran,
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      'hari': null,
      'pelajaran': null,
      'jam_mulai': null,
      'jam_selesai': null,
    };
    return ModelMapel.formJson(hapus);
  }
}
