import 'package:firebase_db/bussiness_logic/fetch_data_bloc/fetch_data_event.dart';
import 'package:firebase_db/bussiness_logic/fetch_data_bloc/fetch_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/fetch_data_api/fetch_data_repo.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataRepo repo;
  FetchDataBloc({required this.repo}) : super(FetchDataInitState()) {
    on<FetchDataEvent>((event, emit) async {
      emit(FetchDataLoadingState());
      try {
        final fetchDbList = await repo.onFetchDataRepo();
        emit(FetchDataLoadedState(model: fetchDbList));
      } catch (e) {
        emit(FetchDataErrorModel(error: e));
      }
    });
  }
}
