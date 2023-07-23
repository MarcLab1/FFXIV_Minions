import 'package:get_it/get_it.dart';
import 'package:my_app/network/MinionRepository.dart';

import '../database/MinionEntityRepository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<IMinionRepository>(() => MinionRepository());
  getIt.registerLazySingleton<IMinionEntityRepository>(
      () => MinionEntityReository());
}
