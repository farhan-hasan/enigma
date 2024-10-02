import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDbConfig {
  late DatabaseClient db;

  init() async {
    db = await _openDatabase();
  }

  Future<Database> _openDatabase() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final dbPath = "${appDirectory.path}/enigma.db";
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}
