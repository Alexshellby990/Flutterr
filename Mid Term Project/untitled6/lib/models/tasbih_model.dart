class Tasbih {
  String name;
  int count;
  String updatedAt;

  Tasbih({
    required this.name,
    this.count = 0,
    this.updatedAt = '1970-01-01 00:00:00',
  });

  factory Tasbih.fromJson(Map<String, dynamic> json) {
    return Tasbih(
      name: json['name'],
      count: json['count'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'count': count,
      'updatedAt': updatedAt,
    };
  }
}