import 'package:shoes_care/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin extends User {
  Admin(
      {this.adminId,
      this.adminName,
      email,
      password,
      this.adminPhone,
      this.adminAddress,
      this.adminPosition})
      : super(email: email, password: password);
  String adminId;
  String adminName;
  // String adminEmail;
  // String adminPassword;
  String adminPhone;
  String adminAddress;
  String adminPosition;

  String get getAdminPosition {
    return adminPosition;
  }

  String get getAdminId {
    return adminId;
  }

  String get getAdminName {
    return adminName;
  }

  // String get getAdminEmail {
  //   return super.email;
  // }

  // String get getAdminPassword {
  //   return super.password;
  // }

  String get getAdminPhone {
    return adminPhone;
  }

  String get getAdminAddress {
    return adminAddress;
  }

  set setAdminPosition(String newAdminPosition) {
    adminPosition = newAdminPosition;
  }

  set setAdminId(String newAdminId) {
    adminId = newAdminId;
  }

  set setAdminName(String newAdminName) {
    adminName = newAdminName;
  }

  // set setAdminEmail(String newAdminEmail) {
  //   super.setEmail
  // }

  // set setAdminPassword(String newAdminPassword) {
  //   adminPassword = newAdminPassword;
  // }

  set setAdminPhone(String newAdminPhone) {
    adminPhone = newAdminPhone;
  }

  set setAdminAddress(String newAdminAddress) {
    adminAddress = newAdminAddress;
  }

//firebase management
  Future<bool> get insert async {
    //insert to firebase (create)
    String createUserWithEmailAndPassword = await super.createUser();
    if (createUserWithEmailAndPassword != null &&
        createUserWithEmailAndPassword == "User Created") {
      // if success create user with email and password: since email and password w/ collection data is in different configuration
      CollectionReference collection =
          FirebaseFirestore.instance.collection('admin');

      collection.add({
        "admin_address": adminAddress,
        "admin_email": super.email,
        "admin_name": adminName,
        "admin_phone": adminPhone,
        "admin_position": adminPosition,
      }).then((value) {
        adminId = value.id;
        print("$value Added");
        return true;
      }).catchError((error) {
        print("Failed to add admin: $error");
        return false;
      });
    } else {
      print("Failed to add admin: $createUserWithEmailAndPassword");
      return false;
    }
    return false;
  }

  void syncDataById(String adminId) {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('admin');
    collection.doc(adminId).get().then((doc) {
      adminAddress = doc['admin_address'];
      super.setEmail(doc['admin_email']);
      // String courierPassword;
      adminName = doc['admin_name'];
      adminPhone = doc['admin_phone'];
      adminPosition = doc['admin_position'];
    });
  }

  void syncDataByEmail(String adminEmail) {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('admin');
    collection
        .where('admin_email', isEqualTo: adminEmail)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                adminId = doc.reference.id; // get document id
                adminName = doc['admin_name'];
                super.setEmail(doc['admin_email']);
                // String adminPassword;
                adminPhone = doc['admin_phone'];
                adminAddress = doc['admin_address'];
                adminPosition = doc['admin_position'];
              })
            });
  }

  bool get update {
    //update current object data to firebase (replace firestore data w/ current object data)
    CollectionReference collection =
        FirebaseFirestore.instance.collection('admin');
    collection.doc(adminId).update({
      "admin_address": adminAddress,
      "admin_email": super.email,
      "admin_name": adminName,
      "admin_phone": adminPhone,
      "admin_position": adminPosition,
    }).then((value) {
      // add this to update password in auth firebase
      if(super.password != ""){
        super.setPassword(super.password);
      }
      print("Updated");
      return true;
    }).catchError((error) {
      print("Failed to update admin: $error");
      return false;
    });
    return false;
  }

  bool get delete {
    //delete data from firebase
    CollectionReference collection =
        FirebaseFirestore.instance.collection('admin');
    collection.doc(adminId).delete().then((value) {
      //TODO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete admin: $error");
      return false;
    });
    return false;
  }
}
