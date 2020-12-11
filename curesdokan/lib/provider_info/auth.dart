//
//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../httpexception.dart';

class Auth with ChangeNotifier {
  String email;
  String password;
  String token;

  Future<void> SignUp(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCz6DwGwFKf04cLSFULki5uChKxygz1JIc';
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      //print(json.decode(response.body));
      final extertedData = json.decode(response.body);

      if (extertedData['error'] != null) {
        final errorData = extertedData['error']['message'];
        throw HttpException(errorData);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> logIn(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCz6DwGwFKf04cLSFULki5uChKxygz1JIc';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final extertedData = json.decode(response.body);
      if (extertedData['error'] != null) {
        final errorData = extertedData['error']['message'];
        throw HttpException(errorData);
      }
    } catch (error) {
      throw error;
    }
  }
}
