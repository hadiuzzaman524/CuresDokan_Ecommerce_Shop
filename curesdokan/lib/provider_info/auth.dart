//
//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../httpexception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _id;
  DateTime _exparytime;
  String _token;

  bool get isAuth {
    if (_token != null) {
      return true;
    }
    return false;
  }

  String get getToken {
    if (_exparytime != null &&
        _exparytime.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get getUserId {
    if (_exparytime != null &&
        _exparytime.isAfter(DateTime.now()) &&
        _token != null) {
      return _id;
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
      try {
        _exparytime = DateTime.now()
            .add(Duration(seconds: int.parse(extertedData['expiresIn'])));
      } catch (e) {
        print(e);
      }

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

  Future<void> logOut() async {
    final pref = await SharedPreferences.getInstance();
    print(pref.getString("UserData"));
    pref.clear();
    _token = null;
    _id = null;
    _exparytime = null;
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
      try {
        _exparytime = DateTime.now()
            .add(Duration(seconds: int.parse(extertedData['expiresIn'])));
      } catch (e) {
        print(e);
      }

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
