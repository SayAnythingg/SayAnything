class User {
  final String userId;
  final String name;
  final String gender;
  final String email;
  final String password;

  User({required this.name, required this.gender, required this.email, required this.password,required this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      gender: json['gender'],
      email: json['email'],
      password:json['password'],
      userId: json['userId'],
    );
  }
}

class Message {
  
}