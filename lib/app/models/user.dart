class ModelUser {
  final String username, nama;
  String? foto, email, kelas, idKelas, deviceId, tglLahir, idKelasAjaran;

  ModelUser({
    required this.username,
    required this.nama,
    this.idKelas,
    this.tglLahir,
    this.kelas,
    this.foto,
    this.email,
    this.deviceId,
    this.idKelasAjaran,
  });

  factory ModelUser.formJson(Map<String, dynamic> json) {
    return ModelUser(
      username: json['nis'].toString(),
      nama: json['nama'].toString(),
      kelas: json['kelas'].toString(),
      idKelas: json['id_kelas'].toString(),
      tglLahir: json['tanggal_lahir'].toString(),
      foto: json['foto'].toString(),
      email: json['email'],
      deviceId: json['deviceId'].toString(),
      idKelasAjaran: json['id_kelas_ajaran'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': username,
      'nama': nama,
      'kelas': kelas,
      'id_kelas': idKelas,
      'tanggal_lahir': tglLahir,
      'foto': foto,
      'email': email,
      'deviceId': deviceId,
      'id_kelas_ajaran': idKelasAjaran,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      'nis': '',
      'nama': '',
      'kelas': '',
      'id_kelas': '',
      'tanggal_lahir': '',
      'foto': null,
      'email': null,
      'deviceId': null,
      'id_kelas_ajaran': null,
    };
    return ModelUser.formJson(hapus);
  }
}
