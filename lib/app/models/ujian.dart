class ModelUjian {
  final String? id, name, days, date, type;

  ModelUjian({
    this.id,
    this.name,
    this.days,
    this.date,
    this.type,
  });

  factory ModelUjian.formJson(Map<String, dynamic> json) {
    return ModelUjian(
      id: json['id'],
      name: json['name'],
      days: json['days'],
      date: json['date'],
      type: json['type'],
    );
  }
}
