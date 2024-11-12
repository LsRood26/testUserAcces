class User {
  final String name;
  final String lastName;
  final String email;
  final bool isAdmin;

  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.isAdmin,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        name: map['name'],
        lastName: map['lastname'],
        email: map['email'],
        isAdmin: map['isAdmin']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastName,
      'email': email,
      'isAdmin': isAdmin,
    };
  }
}
