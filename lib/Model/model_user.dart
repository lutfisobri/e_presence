class modelUser {
  final String name, photoUrl, username, password, kelas, id;

  modelUser({
    required this.name,
    required this.photoUrl,
    required this.username,
    required this.password,
    required this.kelas,
    required this.id,
  });

  factory modelUser.formJson(Map<String, dynamic> json) {
    return modelUser(
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
