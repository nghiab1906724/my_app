part of 'item.dart';

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
    id: json['money'] as int,
    name: json['name'] as String,
    day: json['day'] as String,
    debt: json['debt'] as bool,
    item: json['item'] as String,
    money: json['money'] as int);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'day': instance.day,
      'debt': instance.debt,
      'item': instance.item,
      'money': instance.money,
    };
