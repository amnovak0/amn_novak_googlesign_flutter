// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<Album> fetchAlbum() async {
//     final response = await http.get(Uri.parse('https://flutter-log-6ec68-default-rtdb.europe-west1.firebasedatabase.app/)'));
//     if(response.statusCode == 200) {
//       return Album.fromJson(jsonDecode(response.body));
//     }else {
//       throw Exception("Failed to load album");
//     }
//   }

// class Album {
//   final String email;
//   final String password;

//   const Album ({
//     required this.email,
//     required this.password,

//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       email: json["email"],
//       password: json["password"]);
//   }

  
// }