class SkillType {
  int? id;
  String? name;

  SkillType({this.id, this.name});

  factory SkillType.fromJson(Map<String, dynamic> json) => SkillType(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
