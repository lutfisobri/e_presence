class ModelUser {
  final String name, photoUrl, username, password, kelas, id;

  ModelUser({
    required this.name,
    required this.photoUrl,
    required this.username,
    required this.password,
    required this.kelas,
    required this.id,
  });

  factory ModelUser.formJson(Map<String, dynamic> json) {
    return ModelUser(
      name: json['name'],
      photoUrl: json['photoUrl'],
      username: json['username'],
      password: json['password'],
      id: json['id'],
      kelas: json['kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'username': username,
      'password': password,
      'kelas': kelas,
      'id': id,
    };
  }
}
