import 'package:firebase_auth/firebase_auth.dart';
import 'package:jameel/features/authentication/data/models/user_model.dart';
import 'package:jameel/features/authentication/domain/entities/user.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_phone.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_sms_code.dart';

abstract class AuthenticationService {
  final auth;

  AuthenticationService(this.auth);

  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User> getCurrentUser();
  Future<User> verifyPhone(VerifyPhoneParams params);
  Future<User> verifySmsCode(VerifySmsCodeParams params);
  Future<User> signInWithCredential(dynamic credential);
  Future<bool> isSignedIn();
}

class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) {
    return auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return auth.signOut();
  }

  Future<User> getCurrentUser() async {
    final firebaseUser = await auth.currentUser();
    return UserModel.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<bool> isSignedIn() async {
    final user = await auth.currentUser();
    return user != null;
  }

  @override
  Future<User> verifyPhone(VerifyPhoneParams params) async {
    await auth.verifyPhoneNumber(
      phoneNumber: params.phoneNumber,
      timeout: params.timeout,
      codeAutoRetrievalTimeout: params.autoRetrievalTimeout,
      verificationCompleted: params.verificationCompleted,
      verificationFailed: params.verificationFailed,
      codeSent: params.codeSent,
    );
    return await getCurrentUser();
  }

  @override
  Future<User> signInWithCredential(credential) async {
    await auth.signInWithCredential(credential);

    return await getCurrentUser();
  }

  @override
  Future<User> verifySmsCode(VerifySmsCodeParams params) async {
    final credential = PhoneAuthProvider.getCredential(
        verificationId: params.verificationID, smsCode: params.smsCode);
    await auth.signInWithCredential(credential);

    return await getCurrentUser();
  }
}
