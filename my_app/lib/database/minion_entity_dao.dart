import 'package:floor/floor.dart';
import 'package:my_app/database/minion_entity.dart';

@dao
abstract class MinionEntityDao {
  @Query('SELECT * FROM MinionEntity')
  Future<List<MinionEntity>> getAllMinions();

  @Query('SELECT * FROM MinionEntity')
  Stream<List<MinionEntity>> getAllMinionsAsStream();

  @Query('SELECT DISTINCT COUNT(id) FROM MinionEntity')
  Stream<int?> getMinionsCountAsStream();

  @Query('SELECT * FROM MinionEntity WHERE id = :id')
  Stream<MinionEntity?> findMinionByIdAsStream(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMinion(MinionEntity minionEntity);

  @Query('DELETE FROM MinionEntity')
  Future<void> removeAllMinions();

  @delete
  Future<void> deleteMinion(MinionEntity minionEntity);

  @update
  Future<void> updateMinion(MinionEntity minionEntity);
}
