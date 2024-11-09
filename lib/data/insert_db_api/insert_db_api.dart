import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_db/data/insert_db_api/insert_db_repo.dart';
import 'package:firebase_db/utils/helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/user_database.dart';
import '../../utils/connectivity_service.dart';

class InsertDbApi implements InsertDbRepo{
  @override
  Future<String> onDbInsertRepo(String userId, String firstName, String lastName, String status) async{

    String randomString=generateRandomString(7);
    var connectivityResult = await ConnectivityService().connectivity.checkConnectivity();
    Database? db = await DatabaseHelper.instance.database;

    if (connectivityResult == ConnectivityResult.none) {
      Map<String, dynamic> event = {
        DatabaseHelper.status: "false",
        DatabaseHelper.firstName: firstName,
        DatabaseHelper.lastName: lastName,
        DatabaseHelper.userId:randomString,
      };
      var id = await db!.insert(DatabaseHelper.table, event,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }else{
    final fire=FirebaseDatabase.instance;
    Map<String, dynamic> event = {
      DatabaseHelper.status: "true",
      DatabaseHelper.firstName: firstName,
      DatabaseHelper.lastName: lastName,
      DatabaseHelper.userId:randomString,
    };
     fire.ref("users").child(randomString).set(event);
    }
    return "";
  }
}