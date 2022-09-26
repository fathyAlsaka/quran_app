import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuranDB {
  static Database? database;

  static initializeDatabase() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath,'quran.db');
    var exist = await databaseExists(path);
    if (!exist) copyDB(path);
    database = await openDatabase(path);
    print('Database Ready');
  }

  static copyDB(path) async {
     ByteData fileData = await rootBundle.load(join('assets','quran.db'));
     List<int> bytes = fileData.buffer.asUint8List(fileData.offsetInBytes,fileData.lengthInBytes);
     await File(path).writeAsBytes(bytes);
     print("Done");
  }
  
  static Future<List> retrieve() async {
    var data = await database!.query('sora');
    return data;
  }

  static Future<List<Map>> retrieveAyat(int soraID) async {
    var data = await database!.query('aya',
      where: "soraid = ?",
      whereArgs:  [soraID],
    );
    return data;
  }


}