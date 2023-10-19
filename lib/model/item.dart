import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable()
class Item {
  final String name;
  final String day;
  final bool debt;
  int money;
  Item(
      {required this.name,
      required this.day,
      required this.debt,
      this.money = 0});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
