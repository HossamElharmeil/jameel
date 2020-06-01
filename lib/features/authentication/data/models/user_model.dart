import 'package:firebase_auth/firebase_auth.dart';
import 'package:jameel/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  final String userID;
  final String email;
  final String displayName;
  final String phoneNumber;

  UserModel({this.userID, this.email, this.displayName, this.phoneNumber}): super(userID: userID, email: email, displayName: displayName, phoneNumber: phoneNumber);

  factory UserModel.fromFirebaseUser(FirebaseUser firebaseUser) {
    return UserModel(
      userID: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }
}
