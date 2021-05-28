import 'package:shoes_care/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Customer extends User {
  Customer(
      {this.customerId,
      this.customerName,
      email,
      password,
      this.customerPhone,
      this.customerAddress})
      : super(email: email, password: password);
  String customerId;
  String customerName;
  // String customerEmail;
  // String customerPassword;
  String customerPhone;
  String customerAddress;

  String get getCustomerId {
    return customerId;
  }

  String get getCustomerName {
    return customerName;
  }

  // String get getCustomerEmail {
  //   return customerEmail;
  // }

  // String get getCustomerPassword {
  //   return customerPassword;
  // }

  String get getCustomerPhone {
    return customerPhone;
  }

  String get getCustomerAddress {
    return customerAddress;
  }

  set setCustomerId(String newCustomerId) {
    customerId = newCustomerId;
  }

  set setCustomerName(String newCustomerName) {
    customerName = newCustomerName;
  }

  // set setCustomerEmail(String newCustomerEmail) {
  //   super.setEmail(newCustomerEmail);
  // }

  // set setCustomerPassword(String newCustomerPassword) {
  //   customerPassword = newCustomerPassword;
  // }

  set setCustomerPhone(String newCustomerPhone) {
    customerPhone = newCustomerPhone;
  }

  set setCustomerAddress(String newCustomerAddress) {
    customerAddress = newCustomerAddress;
  }

//firebase management
  Future<bool> get insert async {
    //insert to firebase (create)
    String createUserWithEmailAndPassword = await super.createUser();
    if (createUserWithEmailAndPassword != null &&
        createUserWithEmailAndPassword == "User Created") {
      // if success create user with email and password: since email and password w/ collection data is in different configuration
      CollectionReference collection =
          FirebaseFirestore.instance.collection('customer');

      collection.add({
        "customer_address": customerAddress,
        "customer_email": super.email,
        "customer_name": customerName,
        "customer_phone": customerPhone,
      }).then((value) {
        customerId = value.id;
        print("$value Added");
        return true;
      }).catchError((error) {
        print("Failed to add customer: $error");
        return false;
      });
    } else {
      print("Failed to add customer: $createUserWithEmailAndPassword");
      return false;
    }
    return false;
  }

  void syncDataById(String customerId) {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('customer');
    collection.doc(customerId).get().then((doc) {
      customerName = doc['customer_name'];
      super.setEmail(doc['customer_email']);
      // String customerPassword;
      customerPhone = doc['customer_phone'];
      customerAddress = doc['customer_address'];
    });
  }

  Future<void> syncDataByEmail(String customerEmail) async {
    //sync data w/ firebase and return all attribute data
    CollectionReference collection =
        FirebaseFirestore.instance.collection('customer');
    await collection
        .where('customer_email', isEqualTo: customerEmail)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                customerId = doc.reference.id; // get document id
                customerName = doc['customer_name'];
                super.setEmail(doc['customer_email']);
                // String customerPassword;
                customerPhone = doc['customer_phone'];
                customerAddress = doc['customer_address'];
              })
            });
  }

  bool get update {
    //update current object data to firebase (replace firestore data w/ current object data)
    CollectionReference collection =
        FirebaseFirestore.instance.collection('customer');
    collection.doc(customerId).update({
      "customer_address": customerAddress,
      "customer_email": super.email,
      "customer_name": customerName,
      "customer_phone": customerPhone,

    }).then((value) {
      // add this to update password in auth firebase
      if(super.password != ""){
        super.setPassword(super.password);
      }
      print("Updated");
      return true;
    }).catchError((error) {
      print("Failed to update customer: $error");
      return false;
    });
    return false;
  }

  bool get delete {
    //delete data from firebase
    CollectionReference collection =
        FirebaseFirestore.instance.collection('customer');
    collection.doc(customerId).delete().then((value) {
      //TODO: need to delete email and password in firebase authentication too
      print("Deleted");
      return true;
    }).catchError((error) {
      print("Failed to delete customer: $error");
      return false;
    });
    return false;
  }

  // creating a Trip object from a firebase snapshot
  Customer.fromSnapshot(DocumentSnapshot snapshot) {
    customerId = snapshot.id;
    customerAddress = snapshot["customer_address"];
    super.setEmail(snapshot["customer_email"]);
    customerName = snapshot["customer_name"];
    customerPhone = snapshot["customer_phone"];
  }
  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    "customer_name": customerName,
    "customer_email": super.getEmail,
    "customer_phone": customerPhone,
    "customer_address": customerAddress,
  };
}
