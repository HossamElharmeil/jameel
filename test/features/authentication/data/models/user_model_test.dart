import 'package:firebase_auth/firebase_auth.dart';
import 'package:jameel/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseUser extends Mock implements FirebaseUser {}

void main() {
  UserModel tUserModel;
  FirebaseUser firebaseUser;
  setUp(() {
    tUserModel = UserModel(
        email: 'email@gmail.com',
        phoneNumber: '123456689',
        displayName: 'display name',
        userID: '12345');
    firebaseUser = MockFirebaseUser();
  });

  test('should return something', () {
    when(firebaseUser.email).thenReturn('email@gmail.com');
    when(firebaseUser.phoneNumber).thenReturn('123456689');
    when(firebaseUser.displayName).thenReturn('display name');
    when(firebaseUser.uid).thenReturn('12345');

    final result = UserModel.fromFirebaseUser(firebaseUser);

    expect(result, tUserModel);
  });
}
