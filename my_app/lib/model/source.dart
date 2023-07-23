class Source {
  String? type;
  String? text;
  String? relatedType;
  int? relatedId;

  Source({this.type, this.text, this.relatedType, this.relatedId});

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        type: json['type'] as String?,
        text: json['text'] as String?,
        relatedType: json['related_type'] as String?,
        relatedId: json['related_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text,
        'related_type': relatedType,
        'related_id': relatedId,
      };
}
