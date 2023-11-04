import 'dart:convert';
import 'dart:io';

import 'package:my_app/model/item.dart';
import 'package:path_provider/path_provider.dart';

class ItemRepository {
  Future<List<Item>> getItem() async {
    String data = await readFile();
    if (data != '') {
      final jsData = List<Map<String, dynamic>>.from(jsonDecode(data));
      Item.index = jsData.length;
      return jsData.map((item) => Item.fromJson(item)).toList();
    } else {
      Item.index = 0;
      return [];
    }
  }

  Future<void> saveAllItems(List<Item> items) async {
    List<Map<String, dynamic>> jsonData = [];
    items.forEach((element) {
      jsonData.add(element.toJson());
    });
    await writeFile(jsonEncode(jsonData));
  }

  Future<List<Item>> saveItem(Item item) async {
    List<Item> items = await getItem();
    items.add(item);
    await saveAllItems(items);
    return items;
  }

  Future<List<Item>> removeItem(List<Item> rmItems) async {
    List<Item> items = await getItem();
    rmItems.forEach((element) {
      items.remove(element);
    });
    await saveAllItems(items);
    return items;
  }

  static Future<String> get getFilePath async {
    final Directory? dir = await getApplicationDocumentsDirectory();
    return dir != null ? dir.path : '';
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/items.json');
  }

  Future<String> readFile() async {
    final f = await getFile;
    if (await f.exists()) {
      try {
        return await f.readAsString();
      } catch (e) {
        return '';
      }
    }
    return '';
  }

  Future<void> writeFile(String js) async {
    final f = await getFile;
    try {
      await f.writeAsString(js.toString());
    } catch (e) {
      print('Bi loi ${e.toString()}');
    }
  }
}
