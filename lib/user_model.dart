class UserModel {
  String id;
  String name;
  String email;
  String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> convertToMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  static UserModel convertFromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
