import 'package:curesdokan/httpexception.dart';
import 'package:flutter/material.dart';
import '../provider_info/auth.dart';
import 'package:provider/provider.dart';

class SignUpDesign extends StatefulWidget {
  @override
  _SignUpDesignState createState() => _SignUpDesignState();
}

class _SignUpDesignState extends State<SignUpDesign> {
  final formKey = GlobalKey<FormState>();
  var _emailFocus = FocusNode();
  var _passwordFocus = FocusNode();
  var _confirmFocus = FocusNode();
  bool isStarted = false;

  String _email;
  String _password;
  String _confirmPassword;
  String errorMessage;

  void errorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx)=>AlertDialog(
          title: Text('An error occured!'),
          content: Text(errorMessage),
          actions: [
            FlatButton(onPressed: (){
              Navigator.of(ctx).pop();
            }, child: Text('Ok'))
          ],
        ));
  }

  _saveData(BuildContext context) async {
    formKey.currentState.save();
    bool isValid = formKey.currentState.validate();
    if (isValid) {
      // valid email and password here
      setState(() {
        isStarted = true;
      });

      try {
        await Provider.of<Auth>(context, listen: false)
            .SignUp(_email, _password);
      } on HttpException catch (error) {
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage =
              "The email address is already in use by another account";
        } else if (error.toString().contains('OPERATION_NOT_ALLOWED')) {
          errorMessage = 'Password sign-in is disabled for this project.';
        } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
          errorMessage =
              ' We have blocked all requests from this device due to unusual activity. Try again later.';
        }
        errorDialog(context);
      } catch (error) {
        errorMessage='An error occurred by Internet connection';
        print(error);
      }
    }
    setState(() {
      isStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Form(
          key: formKey,
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
                onSaved: (value) {
                  _email = value;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Password must be 6 character long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_confirmFocus);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                textInputAction: TextInputAction.done,
                focusNode: _confirmFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Password must be 6 character long';
                  }
                  if (_password != value) {
                    return 'Your password can\'t match';
                  }
                  return null;
                },
                onSaved: (value) {
                  _confirmPassword = value;
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
                      child: isStarted
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white)
                          : Text(
                              'Register',
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
      ),
    );
  }
}
