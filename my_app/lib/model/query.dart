class Query {
  String? nameEnStart;

  Query({this.nameEnStart});

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        nameEnStart: json['name_en_start'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name_en_start': nameEnStart,
      };
}
