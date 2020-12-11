//
//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../httpexception.dart';

class Auth with ChangeNotifier {
  String _id;
  DateTime _exparytime;
  String _token;

  bool get isAuth{
    return _token!=null;
  }
  String get getToken{
    if(_exparytime !=null && _exparytime.isAfter(DateTime.now()) && _token!=null){
      return _token;
    }
    return null;
  }

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
      _token = extertedData['idToken'];
      _exparytime = DateTime.now()
          .add(Duration(seconds: int.parse(extertedData['expiresIn'])));
      _id = extertedData['localId'];
      notifyListeners();

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
      _token = extertedData['idToken'];
      _exparytime = DateTime.now()
          .add(Duration(seconds: int.parse(extertedData['expiresIn'])));
      _id = extertedData['localId'];
      notifyListeners();

      if (extertedData['error'] != null) {
        final errorData = extertedData['error']['message'];
        throw HttpException(errorData);
      }
    } catch (error) {
      throw error;
    }
  }
}
