import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://flutter-log-6ec68-default-rtdb.europe-west1.firebasedatabase.app/)'));
}
