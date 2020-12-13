import 'package:curesdokan/httpexception.dart';
import 'package:curesdokan/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../provider_info/auth.dart';
import 'package:provider/provider.dart';

class LoginDesign extends StatefulWidget {
  @override
  _LoginDesignState createState() => _LoginDesignState();
}

class _LoginDesignState extends State<LoginDesign> {
  final _formKey = GlobalKey<FormState>();
  var _passwordFocus = FocusNode();

  String _email;
  String _password;
  bool isShowing = false;
  bool isLoading = false;
  String errorMessage;

  showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An error occurred!'),
              content: Text(errorMessage),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Ok'),
                ),
              ],
            ));
  }

 Future<void> _saveData(BuildContext context) async {
    _formKey.currentState.save();
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      // valid email and password here
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .logIn(_email, _password);
      } on HttpException catch (error) {
        if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage =
              'There is no user record corresponding to this identifier. The user may have been deleted.';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage =
              'The password is invalid or the user does not have a password.';
        } else if (error.toString().contains('USER_DISABLED')) {
          errorMessage =
              'The user account has been disabled by an administrator.';
        }
        showErrorDialog(context);
      } catch (error) {
        errorMessage = 'An error occurred by Internet connection';
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your email';
                }
                if ((!value.endsWith('@gmail.com'))) {
                  return 'Please enter valid email';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
              onSaved: (value) {
                _email = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  child: isShowing
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.remove_red_eye_outlined),
                  onTap: () {
                    setState(() {
                      isShowing = !isShowing;
                    });
                  },
                ),
              ),
              obscureText: isShowing,
              focusNode: _passwordFocus,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter password';
                }
                if (value.length < 6) {
                  return 'Password must be in 6 character long';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
              onFieldSubmitted: (_) {
                _saveData(context);
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 50),
              child: GestureDetector(
                onTap: () {
                  //
                  _saveData(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
