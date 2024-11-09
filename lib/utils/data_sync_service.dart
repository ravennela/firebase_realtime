import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_db/utils/fetch_db_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../database/user_database.dart';
import 'connectivity_service.dart';

Future<void> syncDbData() async {
  // Check Internet Connectivity
  var connectivityResult =
      await ConnectivityService().connectivity.checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    Fluttertoast.showToast(msg: "No Internet connection");
    return;
  }
  // Fetch Markups Data
  var res = await FetchDataDbApi().onFetchDataDbRepo();

  // Process each data element
  for (var element in res) {
    final fire = FirebaseDatabase.instance;
    Map<String, dynamic> event = {
      DatabaseHelper.status: "true",
      DatabaseHelper.firstName: element.firstName,
      DatabaseHelper.lastName: element.lastName,
      DatabaseHelper.userId: element.userId,
    };
    fire
        .ref("users")
        .child(element.userId.toString())
        .set(event) // Pass the event data directly, not a function
        .then((_) async {
      Database? db = await DatabaseHelper.instance.database;
      Map<String, dynamic> event = {DatabaseHelper.status: "true"};
       db!.update(DatabaseHelper.table, event,
          where: 'user_id =? AND status =?',
          whereArgs: [element.userId, "false"]);
    }).catchError((error) {
      Fluttertoast.showToast(msg: error);
    });
  }
}
