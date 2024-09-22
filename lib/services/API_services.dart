import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:SayAnything/services/Model.dart';

class LoginException implements Exception {
  final String message;

  LoginException(this.message);
}

class SignupApiService {
  Future<void> registerUser(
      String username, String email, String password, String gender) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/register'),
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
      throw Exception(
          'Failed to registered with status code ${response.statusCode} and response body ${response.body}');
    }
  }
}

class LoginApiService {
  Future<User> login(String email, String password) async {
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/auth/login');

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
      User user = User.fromJson(jsonResponse);
      return user;
    } else {
      var jsonResponse = jsonDecode(response.body);
      throw LoginException(jsonResponse['Message']);
    }
  }
}

class MatchApiService {
  Future<Map<String, dynamic>> requestMatch(String userId) async {
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/match/');

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
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch match data');
    }
  }

  Future<void> cancelMatch(String userId) async {
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/match/');

    var response = await http.delete(
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
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/forgetPassword'),
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
      Uri.parse('https://sayanythingapi.sdpmlab.org/news/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['datas'];
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      print('Failed to fetch news');
      throw Exception('Failed to load news');
    }
  }
}

class JokeApi {
  Future<Joke> getJoke(int id) async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    print('${response.body}');
    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load joke');
    }
  }
}

class VerifyOTPService {
  Future<int> verifyOTP(String otpCode) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/verifyOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': otpCode,
      }),
    );

    final responseBody = jsonDecode(response.body);

    print('Status code: ${response.statusCode}');
    print('Response body: $responseBody');

    return response.statusCode;
  }
}

class OnlineUserCountService {
  Future<int> getOnlineUserCount() async {
    final response = await http.get(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/onlineUserCount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['userCount'];
    } else {
      print('Failed to get online user count');
      return 0;
    }
  }
}

class ResendConfirmationMailService {
  Future<Map<String, dynamic>> resendConfirmationMail(String email) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/resend_confirmMail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'userId': responseBody['userId'],
        'confirmStatus': responseBody['confirmStatus'],
      };
    } else {
      print('Failed to resend confirmation mail');
      return {'userId': 0, 'confirmStatus': false};
    }
  }
}

class UserConfirmStatusService {
  get response => null;

  Future<String> userConfirmStatus(String email) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/userConfirmStatus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    final responseBody = jsonDecode(response.body);

    print('Status code: ${response.statusCode}');
    print('Response body: $responseBody');

    if (response.statusCode == 200) {
      return responseBody['Message'];
    } else if (response.statusCode == 400) {
      return responseBody['Message'];
    } else {
      return 'Unknown error occurred';
    }
  }
}


class UserOnlineState {
  Future<bool> fetchUserOnlineStatus(String userId) async {
    final uri = Uri.parse('https://sayanythingapi.sdpmlab.org/auth/userOnlineStatus')
        .replace(queryParameters: {'userId': userId});
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['userStatus'];
    } else {
      throw Exception('Failed to load user status');
    }
  }
}
class LogoutService {
  LogoutService();
  Future<void> logout(String userId) async {
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/auth/logout');

    try {
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
        print('Logout successful');
      } else {
        print('Failed to logout. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to logout');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('Failed to logout due to an error');
    }
  }
}


class UpdateProfileApiService {
  Future<Map<String, dynamic>> updateProfile(String userId, String newUsername) async {
    final response = await http.put(
      Uri.parse('https://sayanythingapi.sdpmlab.org/auth/updateProfile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'newUsername': newUsername,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update profile');
    }
  }
}