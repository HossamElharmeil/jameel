import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userID;
  final String email;
  final String displayName;
  final String phoneNumber;

  User({this.displayName, this.phoneNumber, this.userID, this.email});
  @override
  List<Object> get props => [userID, email, displayName, phoneNumber];
}
