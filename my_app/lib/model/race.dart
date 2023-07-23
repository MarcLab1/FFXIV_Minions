class Race {
  int? id;
  String? name;

  Race({this.id, this.name});

  factory Race.fromJson(Map<String, dynamic> json) => Race(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
