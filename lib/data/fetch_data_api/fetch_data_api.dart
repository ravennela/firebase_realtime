import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_db/models/database_model.dart';

import 'fetch_data_repo.dart';

class FetchDataApi implements FetchDataRepo {
  @override
  Future<List<UserDataBaseModel>> onFetchDataRepo() async {
    print("Inside fetch API");
    List<UserDataBaseModel> userList = [];
    final fire = FirebaseDatabase.instance;
    final snapshot = await fire.ref("users").once();
    if (snapshot.snapshot.exists) {
      // Iterate over each child snapshot and map it to the model
      for (var childSnapshot in snapshot.snapshot.children) {
        // Firebase returns the value as Map<Object?, Object?>, we need to safely cast it
        var modelData = childSnapshot.value;

        // Ensure it's a Map<String, dynamic> before proceeding
        if (modelData is Map<Object?, Object?>) {
          // Safely convert Map<Object?, Object?> to Map<String, dynamic>
          var userMap = Map<String, dynamic>.from(modelData.cast<String, dynamic>());

          // Map the data to a UserDataBaseModel instance
          UserDataBaseModel user = UserDataBaseModel.fromMap(userMap);

          // Add the user model to the list
          userList.add(user);
        } else {
          // Handle cases where the data isn't in the expected format (e.g., not a Map)
          print("Unexpected data format for user: ${childSnapshot.key}");
        }
      }
      print("Data successfully fetched and mapped to models.");
    } else {
      print("No users found.");
    }

    return userList;
  }
}
