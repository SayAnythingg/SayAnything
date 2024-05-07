class User {
  final String name;
  final String gender;
  final String email;
  final String password;
  final String userId; 

  User({required this.name, required this.gender, required this.email, required this.password, required this.userId});

  static User? currentUser;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] != null && json['name'].isNotEmpty ? json['name'] : 'Default Name',
      gender: json['gender'] != null && json['gender'].isNotEmpty ? json['gender'] : 'Default Gender',
      email: json['email'] != null && json['email'].isNotEmpty ? json['email'] : 'Default Email',
      password: json['password'] != null && json['password'].isNotEmpty ? json['password'] : 'Default Password',
      userId: json['userId'] != null && json['userId'].isNotEmpty ? json['userId'] : 'Default UserId', 
    );
  }
}

class News {
  final String id;
  final String title;
  final String content;
  final String createdTime;

  News({required this.id, required this.title, required this.content, required this.createdTime});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['ID'].toString(),
      title: json['title'],
      content: json['content'],
      createdTime: json['created_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'title': title,
      'content': content,
      'created_time': createdTime,
    };
  }
}
