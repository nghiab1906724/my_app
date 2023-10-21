import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable()
class Item {
  final int id;
  final String name;
  final String day;
  final bool debt;
  final String item;
  int money;
  Item(
      {required this.id,
      required this.name,
      required this.day,
      required this.debt,
      required this.item,
      this.money = 0});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
