import 'skill_type.dart';

class Verminion {
  int? cost;
  int? attack;
  int? defense;
  int? hp;
  int? speed;
  bool? areaAttack;
  String? skill;
  String? skillDescription;
  int? skillAngle;
  int? skillCost;
  bool? eye;
  bool? gate;
  bool? shield;
  SkillType? skillType;

  Verminion({
    this.cost,
    this.attack,
    this.defense,
    this.hp,
    this.speed,
    this.areaAttack,
    this.skill,
    this.skillDescription,
    this.skillAngle,
    this.skillCost,
    this.eye,
    this.gate,
    this.shield,
    this.skillType,
  });

  factory Verminion.fromJson(Map<String, dynamic> json) => Verminion(
        cost: json['cost'] as int?,
        attack: json['attack'] as int?,
        defense: json['defense'] as int?,
        hp: json['hp'] as int?,
        speed: json['speed'] as int?,
        areaAttack: json['area_attack'] as bool?,
        skill: json['skill'] as String?,
        skillDescription: json['skill_description'] as String?,
        skillAngle: json['skill_angle'] as int?,
        skillCost: json['skill_cost'] as int?,
        eye: json['eye'] as bool?,
        gate: json['gate'] as bool?,
        shield: json['shield'] as bool?,
        skillType: json['skill_type'] == null
            ? null
            : SkillType.fromJson(json['skill_type'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'cost': cost,
        'attack': attack,
        'defense': defense,
        'hp': hp,
        'speed': speed,
        'area_attack': areaAttack,
        'skill': skill,
        'skill_description': skillDescription,
        'skill_angle': skillAngle,
        'skill_cost': skillCost,
        'eye': eye,
        'gate': gate,
        'shield': shield,
        'skill_type': skillType?.toJson(),
      };
}
