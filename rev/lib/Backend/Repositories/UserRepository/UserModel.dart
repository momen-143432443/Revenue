import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? hrID;
  final String? email;
  final String? password;
  final String firstName;
  final String lastName;

  const UserModel(
      {required this.id,
      required this.hrID,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      "HR_ID": hrID,
      "CS Email": email,
      "Password": password,
      "First name": firstName,
      "Last name": lastName
    };
  }

  static UserModel userDataEmpty() => const UserModel(
      id: '', hrID: '', email: '', password: '', firstName: '', lastName: '');

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    if (documentSnapshot.data() != null) {
      final data = documentSnapshot.data()!;
      return UserModel(
          id: documentSnapshot.id,
          hrID: data["HR_ID"] ?? '',
          email: data["CS Email"] ?? '',
          password: data["Password"] ?? '',
          firstName: data["First name"] ?? '',
          lastName: data['Last name'] ?? '');
    } else {
      return UserModel.userDataEmpty();
    }
  }
}
