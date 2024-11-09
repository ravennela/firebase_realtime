


import 'package:firebase_db/models/database_model.dart';
import 'package:sqflite/sqflite.dart';

import '../database/user_database.dart';

class FetchDataDbApi {
  Future<List<UserDataBaseModel>> onFetchDataDbRepo() async{
    List<UserDataBaseModel> cartItems = [];
    Database? db = await DatabaseHelper.instance.database;
    var result = await db!.query(
      DatabaseHelper.table,
      columns: [
        DatabaseHelper.userId,
        DatabaseHelper.firstName,
        DatabaseHelper.lastName,
        DatabaseHelper.status,
      ],
      where: 'status =?',
      whereArgs: ["false"],
    );
    for (var element in result) {
       print("inside elemets"+element.toString());
      UserDataBaseModel cartModel = UserDataBaseModel.fromMap(element);
      cartItems.add(cartModel);
    }
    return cartItems;
  }
}