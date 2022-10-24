class ModelUser {
  final String email,
      photo,
      username,
      password,
      idKelas,
      id,
      nis,
      nama,
      kelamin,
      kelas;

  ModelUser({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.photo,
    required this.idKelas,
    required this.nis,
    required this.nama,
    required this.kelamin,
    required this.kelas,
  });

  factory ModelUser.formJson(Map<String, dynamic> json) {
    return ModelUser(
      id: json['id_siswa'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      photo: json['photo'],
      idKelas: json['id_kelas'],
      nis: json['nis'],
      nama: json['nama_siswa'],
      kelamin: json['jenis_kelamin'],
      kelas: json['kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'photo': photo,
      'idKelas': idKelas,
      'nis': nis,
      'nama': nama,
      'jenisKelamin': kelamin,
      'kelas': kelas,
    };
  }

  clear() {
    Map<String, dynamic> hapus = {
      "id_siswa": "",
      "username": "",
      "password": "",
      "email": "",
      "photo": "",
      "id_kelas": "",
      "nis": "",
      "nama_siswa": "",
      "jenis_kelamin": "",
      "kelas": "",
    };
    return ModelUser.formJson(hapus);
  }
}
