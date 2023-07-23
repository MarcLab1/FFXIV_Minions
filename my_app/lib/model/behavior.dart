class Behavior {
  int? id;
  String? name;

  Behavior({this.id, this.name});

  factory Behavior.fromJson(Map<String, dynamic> json) => Behavior(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
