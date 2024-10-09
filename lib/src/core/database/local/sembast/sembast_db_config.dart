import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDbConfig {
  late DatabaseClient db;

  init() async {
    db = await _openDatabase();
  }

  Future<Database> _openDatabase() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String dbPath = "${appDirectory.path}/enigma.db";
    final Database database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}
