class ModelInformasi {
  final String id, judul, desc, createdAt, updatedAt;
  final String? image;

  ModelInformasi({
    required this.id,
    required this.judul,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory ModelInformasi.formJson(Map<String, dynamic> json) {
    return ModelInformasi(
      id: json['id'],
      judul: json['judul'],
      desc: json['desc'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['thumbnail'],
    );
  }
}