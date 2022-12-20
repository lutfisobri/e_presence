class ModelInformasi {
  final String? id, judul, desc, createdAt, image;

  ModelInformasi({
    this.id,
    this.judul,
    this.desc,
    this.createdAt,
    this.image,
  });

  factory ModelInformasi.formJson(Map<String, dynamic> json) {
    return ModelInformasi(
      id: json['id_informasi'].toString(),
      judul: json['judul_informasi'].toString(),
      desc: json['isi_informasi'].toString(),
      createdAt: json['created_at'].toString(),
      image: json['thumbnail'].toString(),
    );
  }
}
