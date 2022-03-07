
class User {
  final String id;
  final String email;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'] as String,
        username: json['username'] as String,
        email: json['email'] as String);
  }
}
