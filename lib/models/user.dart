// user.dart
class User {
  late int id;
  late String name;
  late String username;
  late String email;
  late String password;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  // Convert the User object to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
