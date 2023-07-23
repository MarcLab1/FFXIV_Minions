import 'minion.dart';
import 'query.dart';
import 'minion.dart';

class QueryResult {
  Query? query;
  int? count;
  List<Minion>? results;

  QueryResult({this.query, this.count, this.results});

  factory QueryResult.fromJson(Map<String, dynamic> json) => QueryResult(
        query: json['query'] == null
            ? null
            : Query.fromJson(json['query'] as Map<String, dynamic>),
        count: json['count'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Minion.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'query': query?.toJson(),
        'count': count,
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
