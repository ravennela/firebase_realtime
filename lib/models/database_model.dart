import 'package:equatable/equatable.dart';

class UserDataBaseModel extends Equatable {
  String? userId;
  String? firstName;
  String? lastName;
  String? status;
  @override
  List<Object?> get props => [userId, firstName, lastName, status];
  UserDataBaseModel(
      {required this.userId,
      required this.status,
      required this.lastName,
      required this.firstName});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'status': status,
    };
    return map;
  }
  UserDataBaseModel.fromMap(Map<String, dynamic> map) {
    userId = map['user_id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    status = map['status'];
  }
}
