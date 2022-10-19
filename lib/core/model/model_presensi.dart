class ModelPresensi {
  late final String data;
  ModelPresensi(
    this.data,
  );

  ModelPresensi.formJson(Map<String, dynamic> json) : data = json['data'];

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}