import 'package:firebase_auth/firebase_auth.dart';

class User {
  User({this.email, this.password});

  String email;
  String password;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> createUser() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //insert data to database: user biodata
      return "User Created";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  String get getEmail {
    return email;
  }

  String get getPassword {
    return password;
  }

  void setEmail(String newEmail) {
    email = newEmail;
  }

  void setPassword(String newPassword) {
    password = newPassword;
  }
}
