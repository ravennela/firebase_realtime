import 'package:equatable/equatable.dart';

class InsertDbEvent extends Equatable{
  final String userId;
  final String firstName;
  final String lastName;
  final String status;
  const InsertDbEvent(
      {required this.userId,
      required this.lastName,
      required this.firstName,
      required this.status});
  @override
  List<Object?> get props => [userId,firstName,lastName,status];
}
