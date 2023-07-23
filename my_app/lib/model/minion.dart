import 'package:my_app/database/minion_entity.dart';

import 'behavior.dart';
import 'race.dart';
import 'source.dart';
import 'verminion.dart';

class Minion {
  int? id;
  String? name;
  String? description;
  String? enhancedDescription;
  String? tooltip;
  String? patch;
  dynamic itemId;
  bool? tradeable;
  Behavior? behavior;
  Race? race;
  String? image;
  String? icon;
  String? owned;
  List<Source>? sources;
  Verminion? verminion;

  Minion({
    this.id,
    this.name,
    this.description,
    this.enhancedDescription,
    this.tooltip,
    this.patch,
    this.itemId,
    this.tradeable,
    this.behavior,
    this.race,
    this.image,
    this.icon,
    this.owned,
    this.sources,
    this.verminion,
  });

  factory Minion.fromJson(Map<String, dynamic> json) => Minion(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        enhancedDescription: json['enhanced_description'] as String?,
        tooltip: json['tooltip'] as String?,
        patch: json['patch'] as String?,
        itemId: json['item_id'] as dynamic,
        tradeable: json['tradeable'] as bool?,
        behavior: json['behavior'] == null
            ? null
            : Behavior.fromJson(json['behavior'] as Map<String, dynamic>),
        race: json['race'] == null
            ? null
            : Race.fromJson(json['race'] as Map<String, dynamic>),
        image: json['image'] as String?,
        icon: json['icon'] as String?,
        owned: json['owned'] as String?,
        sources: (json['sources'] as List<dynamic>?)
            ?.map((e) => Source.fromJson(e as Map<String, dynamic>))
            .toList(),
        verminion: json['verminion'] == null
            ? null
            : Verminion.fromJson(json['verminion'] as Map<String, dynamic>),
      );

  MinionEntity toMinionEntity() {
    return MinionEntity(
        id: id,
        name: name,
        description: description,
        enhancedDescription: enhancedDescription,
        tooltip: tooltip,
        patch: patch,
        image: image);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'enhanced_description': enhancedDescription,
        'tooltip': tooltip,
        'patch': patch,
        'item_id': itemId,
        'tradeable': tradeable,
        'behavior': behavior?.toJson(),
        'race': race?.toJson(),
        'image': image,
        'icon': icon,
        'owned': owned,
        'sources': sources?.map((e) => e.toJson()).toList(),
        'verminion': verminion?.toJson(),
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'enhanced_description': enhancedDescription,
      'tooltip': tooltip,
      'patch': patch,
      'item_id': itemId,
      'tradeable': tradeable,
      'behavior': behavior?.toJson(),
      'race': race?.toJson(),
      'image': image,
      'icon': icon,
      'owned': owned,
      'sources': sources?.map((e) => e.toJson()).toList(),
      'verminion': verminion?.toJson(),
    };
  }

  String toString() {
    return "$id \n$name \n$description";
  }
}
