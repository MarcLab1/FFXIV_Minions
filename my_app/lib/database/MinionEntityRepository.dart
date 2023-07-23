import 'dart:async';

import 'package:my_app/database/minion_entity.dart';
import 'package:my_app/database/minion_entity_dao.dart';

import '../model/minion.dart';
import 'database.dart';

abstract class IMinionEntityRepository {
  MinionEntityDao getDao();
  Future<List<Minion>> getAllMinions();
  Stream<List<Minion>> getAllMinionsAsStream();
  Stream<int?> getMinionsCountAsStream();
  Stream<Minion?> findMinionByIdAsStream(int id);
  Future<void> insertMinion(Minion minion);
  Future<void> removeAllMinions();
  Future<void> removeMinion(Minion minion);
  Future<void> updateMinion(Minion minion);
}

class MinionEntityReository extends IMinionEntityRepository {
  late MinionEntityDao dao;

  MinionEntityReository() {
    initDatabase();
  }

  @override
  MinionEntityDao getDao() {
    return dao;
  }

  void initDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('minions_db1.db').build();

    dao = database.minionEntityDao;
  }

  @override
  Future<List<Minion>> getAllMinions() async {
    List<MinionEntity> result = await dao.getAllMinions();
    List<Minion> minionsList = [];
    result.forEach((element) {
      minionsList.add(element.toMinion());
    });
    return minionsList;
  }

  @override
  Stream<List<Minion>> getAllMinionsAsStream() async* {
    final oldStream = dao.getAllMinionsAsStream();

    var newStream = oldStream.map(
      (list) => list
          .map(
            (minionEntity) => minionEntity.toMinion(),
          )
          .toList(),
    );

    yield* newStream;
  }

  @override
  Stream<int?> getMinionsCountAsStream() async* {
    yield* dao.getMinionsCountAsStream();
  }

  @override
  Stream<Minion?> findMinionByIdAsStream(int id) async* {
    var oldStream = dao.findMinionByIdAsStream(id);
    var newStream = oldStream.map((minionEntity) => minionEntity?.toMinion());
    yield* newStream;
  }

  @override
  Future<void> insertMinion(Minion minion) async {
    await dao.insertMinion(minion.toMinionEntity());
  }

  @override
  Future<void> removeAllMinions() async {
    await dao.removeAllMinions();
  }

  @override
  Future<void> removeMinion(Minion minion) async {
    await dao.deleteMinion(minion.toMinionEntity());
  }

  @override
  Future<void> updateMinion(Minion minion) async {
    await dao.updateMinion(minion.toMinionEntity());
  }
}
