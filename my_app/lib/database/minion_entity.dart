import 'package:floor/floor.dart';

import '../model/minion.dart';

@entity
class MinionEntity {
  @primaryKey
  int? id;
  String? name;
  String? description;
  String? enhancedDescription;
  String? tooltip;
  String? patch;
  String? image;

  MinionEntity({
    required this.id,
    this.name,
    this.description,
    this.enhancedDescription,
    this.tooltip,
    this.patch,
    this.image,
  });

  Minion toMinion() {
    return Minion(
        id: id,
        name: name,
        description: description,
        enhancedDescription: enhancedDescription,
        tooltip: tooltip,
        patch: patch,
        image: image);
  }
}
