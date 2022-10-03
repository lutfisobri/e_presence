class modelPresensi {
  late final String data;
  modelPresensi(
    this.data,
  );

  modelPresensi.formJson(Map<String, dynamic> json) : data = json['data'];

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}