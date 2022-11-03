class ModelUser {
  final String nis,
      username,
      password,
      email,
      foto,
      idKelas,
      nama,
      kelamin,
      kelas,
      tglLahir,
      isLogin,
      deviceId;

  ModelUser({
    required this.username,
    required this.password,
    required this.email,
    required this.foto,
    required this.idKelas,
    required this.nis,
    required this.nama,
    required this.kelamin,
    required this.kelas,
    required this.tglLahir,
    required this.isLogin,
    required this.deviceId,
  });

  factory ModelUser.formJson(Map<String, dynamic> json) {
    return ModelUser(
      nis: json['nis'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      foto: json['foto'],
      idKelas: json['id_kelas'],
      nama: json['nama_siswa'],
      kelamin: json['jenis_kelamin'],
      kelas: json['kelas'],
      tglLahir: json['tanggal_lahir'],
      isLogin: json['isLogin'],
      deviceId: json['deviceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': nis,
      'username': username,
      'password': password,
      'email': email,
      'foto': foto,
      'id_kelas': idKelas,
      'nama_siswa': nama,
      'jenis_kelamin': kelamin,
      'kelas': kelas,
      'tanggal_lahir': tglLahir,
      'isLogin': isLogin,
      'deviceId': deviceId,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      "nis": "",
      "username": "",
      "password": "",
      "email": "",
      "foto": "",
      "id_kelas": "",
      "nama_siswa": "",
      "jenis_kelamin": "",
      "kelas": "",
      "tanggal_lahir": "",
      "isLogin": "",
      "deviceId": "",
    };
    return ModelUser.formJson(hapus);
  }
}
