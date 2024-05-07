import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:SayAnything/services/Model.dart';

class SignupApiService {
  Future<void> registerUser(String username, String email, String password, String gender) async {  
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/register'), // add flask API.
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'gender': gender,  
      }),
    );

    if (response.statusCode == 200) {
      print('User registered successfully');
    } else {
      throw Exception('Failed to register user');
    }
  }
}

class LoginApiService {
  Future<User> login(String email, String password) async {
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/auth/login'); // add flask api.

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

 if (response.statusCode == 200) {
  var jsonResponse = jsonDecode(response.body);
  print('Server response: ${response.body}');
  User user = User.fromJson(jsonResponse);
  return user;
} else {
  throw Exception('Failed to log in');
}
  }
}

class MatchApiService {

  Future<void> requestMatch(String userId) async {
    var url = Uri.parse(''); // add flask api.
    print('requestMatch called with userId: $userId');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      print('Match successfully');
    } else {
      throw Exception('Failed');
    }
  }

  Future<void> cancelMatch(String userId) async {
    var url = Uri.parse(''); // add flask api.

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      print('Match canceled successfully');
    } else {
      throw Exception('Failed to cancel match');
    }
  }
}

class ForgetPasswordApiService {
  Future<void> resetPassword(String email) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/forgetPassword'), // add flask API 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('Password reset email sent successfully');
    } else {
      throw Exception('Failed to send password reset email');
    }
  }
}

class OtpVerificationApiService {
  Future<int> verifyOtp(String otp) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/verifyOTP'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      print('OTP verified successfully');
    } else {
      print('Failed to verify OTP');
    }

    return response.statusCode;
  }
}

class PasswordResetApiService {
  Future<int> resetPassword(String newPassword) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/passwordReset'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      print('Password reset successfully');
    } else {
      print('Failed to reset password');
    }

    return response.statusCode;
  }
}

class NewsApiService {
  Future<List<News>> getAllNews() async {
    final response = await http.get(
      Uri.parse('https://sayanythingapi.sdpmlab.org/news/news_all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('News fetched successfully');
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      print('Failed to fetch news');
      throw Exception('Failed to load news');
    }
  }
}