import 'dart:io';

import 'package:my_app/model/item.dart';
import 'package:path_provider/path_provider.dart';

class ItemRepository {
  List<Map<String, dynamic>> jsonData = [
    {
      "id": 1,
      "name": "Luân",
      "day": "01/10/23",
      "debt": true,
      "item": "cơm",
      "money": 20000,
    },
    {
      "id": 2,
      "name": "Luân",
      "day": "01/10/23",
      "debt": true,
      "item": "Nước ngọt",
      "money": 10000,
    },
    {
      "id": 3,
      "name": "Luân",
      "day": "01/10/23",
      "debt": false,
      "item": "Kẹo",
      "money": 10000,
    },
    {
      "id": 4,
      "name": "Bảo",
      "day": "01/10/23",
      "debt": false,
      "item": "Giặt sấy",
      "money": 30000,
    },
  ];
  Future<List<Item>> getItem() async {readFile();
    return jsonData.map((item) => Item.fromJson(item)).toList();
  }

  static Future<String> get getFilePath async{
    final Directory dir=await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<File> get getFile async{
    final path=await getFilePath;
    print('$path/items.json');
    return File('$path/items.json');
  }

  Future<void> readFile() async{
try{
  final f=await getFile;
  String data=await f.readAsString();
  print(data);
}catch(e){
  print(e.toString());
}
  }
}
