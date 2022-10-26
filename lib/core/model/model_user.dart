class ModelUser {
  final String nis,
      username,
      password,
      email,
      foto,
      idKelas,
      nama,
      kelamin,
      kelas;

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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': nis,
      'username': username,
      'password': password,
      'email': email,
      'photo': foto,
      'idKelas': idKelas,
      'nama': nama,
      'jenisKelamin': kelamin,
      'kelas': kelas,
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
    };
    return ModelUser.formJson(hapus);
  }
}
