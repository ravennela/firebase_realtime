import 'package:firebase_db/bussiness_logic/inser_db_bloc/insert_db_event.dart';
import 'package:firebase_db/bussiness_logic/inser_db_bloc/insert_db_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/insert_db_api/insert_db_repo.dart';

class InsertDbBloc extends Bloc<InsertDbEvent, InsertDbState> {
  InsertDbRepo repo;
  InsertDbBloc({required this.repo}) : super(const InsertDbState(id: "")) {
    on<InsertDbEvent>((event, emit) async {
      print(event.firstName);
      try {
        final insertDbBloc = await repo.onDbInsertRepo(
            event.userId, event.firstName, event.lastName, event.status);
        emit(InsertDbState(id: insertDbBloc.toString()));
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
