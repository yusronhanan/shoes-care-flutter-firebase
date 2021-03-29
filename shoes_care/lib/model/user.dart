class User {
  User({this.email, this.password});

  String email;
  String password;

  String get getEmail {
    return email;
  }

  String get getPassword {
    return password;
  }

  set setEmail(String newEmail) {
    email = newEmail;
  }

  set setPassword(String newPassword) {
    password = newPassword;
  }
}
