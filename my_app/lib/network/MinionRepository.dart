import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_app/model/query_result.dart';

import '../model/minion.dart';

abstract class IMinionRepository {
  Future<Minion> getMinion();
  Future<List<Minion>> getMinions(String name);
}

class MinionRepository extends IMinionRepository {
  late var url;
  late var url2;

  MinionRepository() {
    //https://ffxivcollect.com/api/minions?name_en_start=wind-up
    url = Uri.https('ffxivcollect.com', '/api/mounts/1?language=en');
  }

  @override
  Future<Minion> getMinion() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 3));
      return Minion.fromJson(convert.jsonDecode(response.body));
    } else
      throw Exception('someting wrong?');
  }

  @override
  Future<List<Minion>> getMinions(String name) async {
    final queryParameters = {'name_en_start': name};
    url2 = Uri.https('ffxivcollect.com', '/api/minions', queryParameters);

    var response = await http.get(url2);

    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 1));

      QueryResult queryResult =
          QueryResult.fromJson(convert.jsonDecode(response.body));
      List<Minion> resultList = [];
      queryResult.results?.forEach((element) {
        resultList.add(element);
      });
      return resultList;
    } else
      throw Exception('someting wrong?');
  }
}
