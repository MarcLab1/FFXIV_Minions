import 'dart:async';
import 'package:floor/floor.dart';
import 'package:my_app/database/minion_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'minion_entity_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [MinionEntity])
abstract class AppDatabase extends FloorDatabase {
  MinionEntityDao get minionEntityDao;
}
