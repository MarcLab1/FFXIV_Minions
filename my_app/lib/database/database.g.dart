// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MinionEntityDao? _minionEntityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MinionEntity` (`id` INTEGER, `name` TEXT, `description` TEXT, `enhancedDescription` TEXT, `tooltip` TEXT, `patch` TEXT, `image` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MinionEntityDao get minionEntityDao {
    return _minionEntityDaoInstance ??=
        _$MinionEntityDao(database, changeListener);
  }
}

class _$MinionEntityDao extends MinionEntityDao {
  _$MinionEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _minionEntityInsertionAdapter = InsertionAdapter(
            database,
            'MinionEntity',
            (MinionEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'enhancedDescription': item.enhancedDescription,
                  'tooltip': item.tooltip,
                  'patch': item.patch,
                  'image': item.image
                },
            changeListener),
        _minionEntityUpdateAdapter = UpdateAdapter(
            database,
            'MinionEntity',
            ['id'],
            (MinionEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'enhancedDescription': item.enhancedDescription,
                  'tooltip': item.tooltip,
                  'patch': item.patch,
                  'image': item.image
                },
            changeListener),
        _minionEntityDeletionAdapter = DeletionAdapter(
            database,
            'MinionEntity',
            ['id'],
            (MinionEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'enhancedDescription': item.enhancedDescription,
                  'tooltip': item.tooltip,
                  'patch': item.patch,
                  'image': item.image
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MinionEntity> _minionEntityInsertionAdapter;

  final UpdateAdapter<MinionEntity> _minionEntityUpdateAdapter;

  final DeletionAdapter<MinionEntity> _minionEntityDeletionAdapter;

  @override
  Future<List<MinionEntity>> getAllMinions() async {
    return _queryAdapter.queryList('SELECT * FROM MinionEntity',
        mapper: (Map<String, Object?> row) => MinionEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            enhancedDescription: row['enhancedDescription'] as String?,
            tooltip: row['tooltip'] as String?,
            patch: row['patch'] as String?,
            image: row['image'] as String?));
  }

  @override
  Stream<List<MinionEntity>> getAllMinionsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM MinionEntity',
        mapper: (Map<String, Object?> row) => MinionEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            enhancedDescription: row['enhancedDescription'] as String?,
            tooltip: row['tooltip'] as String?,
            patch: row['patch'] as String?,
            image: row['image'] as String?),
        queryableName: 'MinionEntity',
        isView: false);
  }

  @override
  Stream<int?> getMinionsCountAsStream() {
    return _queryAdapter.queryStream(
        'SELECT DISTINCT COUNT(id) FROM MinionEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        queryableName: 'MinionEntity',
        isView: false);
  }

  @override
  Stream<MinionEntity?> findMinionByIdAsStream(int id) {
    return _queryAdapter.queryStream('SELECT * FROM MinionEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MinionEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            enhancedDescription: row['enhancedDescription'] as String?,
            tooltip: row['tooltip'] as String?,
            patch: row['patch'] as String?,
            image: row['image'] as String?),
        arguments: [id],
        queryableName: 'MinionEntity',
        isView: false);
  }

  @override
  Future<void> removeAllMinions() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MinionEntity');
  }

  @override
  Future<void> insertMinion(MinionEntity minionEntity) async {
    await _minionEntityInsertionAdapter.insert(
        minionEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateMinion(MinionEntity minionEntity) async {
    await _minionEntityUpdateAdapter.update(
        minionEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMinion(MinionEntity minionEntity) async {
    await _minionEntityDeletionAdapter.delete(minionEntity);
  }
}
