import 'package:equatable/equatable.dart';
import 'package:firebase_db/models/database_model.dart';

class FetchDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDataInitState extends FetchDataState {}

class FetchDataLoadingState extends FetchDataState {}

class FetchDataLoadedState extends FetchDataState {
  final List<UserDataBaseModel> model;
  FetchDataLoadedState({required this.model});
}

class FetchDataErrorModel extends FetchDataState {
  final error;
  FetchDataErrorModel({required this.error});
}
