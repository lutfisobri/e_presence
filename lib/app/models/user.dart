class ModelUser {
  final String username, nama, kelas, idKelas, tglLahir;
  String? foto, email, deviceId;

  // {username: 12345678, nama: Lutfi Sobri, kelas: X 1, id_kelas: 3, tanggal_lahir: 2022-12-02, foto: null, email: lutfisobri@gmail.com, no_hp: null, alamat: null, isLogin: 1, deviceId: f2dbdf048b7f4422, nama_kelas: X 1}

  ModelUser({
    required this.username,
    required this.nama,
    required this.kelas,
    required this.idKelas,
    required this.tglLahir,
    this.foto,
    this.email,
    this.deviceId,
  });

  factory ModelUser.formJson(Map<String, dynamic> json) {
    return ModelUser(
      username: json['nis'],
      nama: json['nama'],
      kelas: json['kelas'],
      idKelas: json['id_kelas'],
      tglLahir: json['tanggal_lahir'],
      foto: json['foto'],
      email: json['email'],
      deviceId: json['deviceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nama': nama,
      'kelas': kelas,
      'id_kelas': idKelas,
      'tanggal_lahir': tglLahir,
      'foto': foto,
      'email': email,
      'deviceId': deviceId,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      'username': '',
      'nama': '',
      'kelas': '',
      'id_kelas': '',
      'tanggal_lahir': '',
      'foto': null,
      'email': null,
      'deviceId': null,
    };
    return ModelUser.formJson(hapus);
  }
}
