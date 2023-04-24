import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<Album> createUser( 
//   String emailController, String passwordController) async {
//   final response = await http.post(
//     Uri.parse(
//         'https://flutter-log-6ec68-default-rtdb.europe-west1.firebasedatabase.app/'),
//     headers: <String, String>{
//       'Content-type': 'application/json',
//     },
//     body: jsonEncode(<String, String>{
//       'email': emailController,
//       'password': passwordController,
//     }),
//   );

//   if (response.statusCode == 201) {
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to create album.');
//   }
//   }

   //Flutter form data 
    Future<User>createUser(String username, String password) async {
      var map = 
      <String, dynamic>{};
      map['username'] = username;
      map ['password'] = password;

      http.Response response = await http.post(
         Uri.parse('http://3.69.137.223/api/login_user.php'),
        body:map,
        headers: {
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 201) {
          return User.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to create album.');
        }

    }

    class User {
      final String username;
      final String password;

      User({
        required this.username,
        required this.password,
      });

      factory User.fromJson(Map<String, dynamic> json) {
        return User(
          username: json['username'],
          password: json['password'],
        );
      }
    }
