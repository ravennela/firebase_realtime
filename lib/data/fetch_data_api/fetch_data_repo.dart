import '../../models/database_model.dart';

abstract class FetchDataRepo {
  Future<List<UserDataBaseModel>> onFetchDataRepo();
}
