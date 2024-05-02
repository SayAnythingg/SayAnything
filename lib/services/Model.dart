class User {
  final String name;
  final String gender;
  final String email;
  final String password;

  User({required this.name, required this.gender, required this.email, required this.password});

  static User? currentUser;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] != null && json['name'].isNotEmpty ? json['name'] : 'Default Name',
      gender: json['gender'] != null && json['gender'].isNotEmpty ? json['gender'] : 'Default Gender',
      email: json['email'] != null && json['email'].isNotEmpty ? json['email'] : 'Default Email',
      password: json['password'] != null && json['password'].isNotEmpty ? json['password'] : 'Default Password',
    );
  }
}

class Message {
  
}