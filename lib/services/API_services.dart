import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:say_anything/services/Model.dart';

class LoginException implements Exception {
  final String message;

  LoginException(this.message);
}

class SignupApiService {


  Future<void> registerUser(
      String username, String email, String password, String gender) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/register'),
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
      if (kDebugMode) {
        print('User registered successfully');
      }
    } else {
      throw Exception(
          'Failed to registered with status code ${response.statusCode} and response body ${response.body}');
    }
  }
}

class LoginApiService {
  Future<User> login(String email, String password) async {
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/login');

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
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/match/');

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
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/match/');

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
      if (kDebugMode) {
        print('Match canceled successfully');
      }
    } else {
      throw Exception('Failed to cancel match');
    }
  }
}

class ForgetPasswordApiService {
  Future<void> resetPassword(String email) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/forgotPassword/sendOtp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Password reset email sent successfully');
      }
    } else {
      throw Exception('Failed to send password reset email');
    }
  }
}

class OtpVerificationApiService {
  Future<int> verifyOtp(String otp) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/forgotPassword/getOtp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('OTP verified successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to verify OTP');
      }
    }

    return response.statusCode;
  }
}

class PasswordResetApiService {
  Future<int> resetPassword(String newPassword) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/forgotPassword/resetPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Password reset successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to reset password');
      }
    }

    return response.statusCode;
  }
}

class NewsApiService {
  Future<List<News>> getAllNews() async {
    final response = await http.get(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/news/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (kDebugMode) {
      print('Status code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response body: ${response.body}');
    }

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['datas'];
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      if (kDebugMode) {
        print('Failed to fetch news');
      }
      throw Exception('Failed to load news');
    }
  }
}

class JokeApi {
  Future<Joke> getJoke(int id) async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    if (kDebugMode) {
      print(response.body);
    }
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
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/forgotPassword/getOtp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': otpCode,
      }),
    );

    final responseBody = jsonDecode(response.body);

    if (kDebugMode) {
      print('Status code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response body: $responseBody');
    }

    return response.statusCode;
  }
}

class OnlineUserCountService {
  Future<int> getOnlineUserCount() async {
    final response = await http.get(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/onlineUserCount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['userCount'];
    } else {
      if (kDebugMode) {
        print('Failed to get online user count');
      }
      return 0;
    }
  }
}

class ResendConfirmationMailService {
  Future<Map<String, dynamic>> resendConfirmationMail(String email) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/resend_confirmMail'),
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
      if (kDebugMode) {
        print('Failed to resend confirmation mail');
      }
      return {'userId': 0, 'confirmStatus': false};
    }
  }
}

class UserConfirmStatusService {
  get response => null;

  Future<String> userConfirmStatus(String email) async {
    final response = await http.post(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/userConfirmStatus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    final responseBody = jsonDecode(response.body);

    if (kDebugMode) {
      print('Status code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response body: $responseBody');
    }

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
    final uri =
        Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/userOnlineStatus')
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
    var url = Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/logout');

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
        if (kDebugMode) {
          print('Logout successful');
        }
      } else {
        if (kDebugMode) {
          print('Failed to logout. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to logout');
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
      throw Exception('Failed to logout due to an error');
    }
  }
}

class UpdateProfileApiService {
  Future<Map<String, dynamic>> updateProfile(
      String userId, String newUsername) async {
    final response = await http.put(
      Uri.parse('https://sayanythingapi.sdpmlab.org/api/v1/auth/updateProfile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'newUsername': newUsername,
      }),
    );
    return jsonDecode(response.body);
  }
}

// class AIService {
//   AIService() {
//     OpenAI.apiKey = '';
//   }

//   Future<String?> sendToOpenAI(String text) async {
//     String prompt = "$text\n請自然的跟我對答聊天";

//     try {
//       final response = await OpenAI.instance.chat.create(
//         model: "",
//         messages: [
//           OpenAIChatCompletionChoiceMessageModel(
//             content: [
//               OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
//             ],
//             role: OpenAIChatMessageRole.user,
//           ),
//         ],
//         maxTokens: 1500,
//       );

//       return response.choices.first.message.content?.first.text;
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint("OpenAI 請求失敗: $e");
//       }
//       return null;
//     }
//   }

//   Future<Joke> getJoke() async {
//     final jokeApi = JokeApi();
//     return await jokeApi.getJoke(1);
//   }
// }
