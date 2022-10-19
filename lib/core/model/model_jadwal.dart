class ModelJadwal {
  final String name, jam, hari, logo, kelas, id;

  ModelJadwal({
    required this.name,
    required this.jam,
    required this.hari,
    required this.logo,
    required this.kelas,
    required this.id,
    }
  );

  factory ModelJadwal.formJson(Map<String, dynamic> json) {
    return ModelJadwal(
      name: json['name'],
      jam: json['jam'],
      hari: json['hari'],
      logo: json['logo'],
      id: json['id'],
      kelas: json['kelas'],
    );
  }
}
