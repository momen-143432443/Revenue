import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? password;
  final String firstName;
  final String lastName;

  const UserModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
  }

  static UserModel userDataEmpty() => const UserModel(
      id: '', email: '', password: '', firstName: '', lastName: '');

  factory UserModel.fromSnapshot(Map<String, dynamic> json) {
    return UserModel(
        id: AuthenticationRepo.instance.authUser?.uid,
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json['lastName']);
  }
}
