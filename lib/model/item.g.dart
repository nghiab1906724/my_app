part of 'item.dart';

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
    name: json['name'] as String,
    day: json['day'] as String,
    debt: json['debt'] as bool,
    money: json['money'] as int);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'day': instance.day,
      'debt': instance.debt,
      'money': instance.money,
    };
