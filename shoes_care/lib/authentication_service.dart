import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoes_care/model/customer.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    //ditaruh di onPressed signout context.read<AuthenticationService>().signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {String name,
      String email,
      String phoneNum,
      String address,
      String password}) async {
    try {
      // await _firebaseAuth.createUserWithEmailAndPassword(
      //     email: email, password: password);

      //insert data to database: user biodata
      Customer newCust = Customer(
          customerId: "",
          customerName: name,
          customerAddress: address,
          email: email,
          customerPhone: phoneNum,
          password: password);
      newCust.insert;
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
