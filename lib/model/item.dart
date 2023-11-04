import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  final int id;
  final String name;
  final String date;
  final bool debt;
  final String item;
  int money;
  static late int index;
  Item(
      {required this.id,
      required this.name,
      required this.date,
      required this.debt,
      required this.item,
      this.money = 0});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
