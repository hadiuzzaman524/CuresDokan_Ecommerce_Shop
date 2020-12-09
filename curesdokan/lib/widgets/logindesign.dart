import 'package:flutter/material.dart';

class LoginDesign extends StatefulWidget {
  @override
  _LoginDesignState createState() => _LoginDesignState();
}

class _LoginDesignState extends State<LoginDesign> {
  final _formKey = GlobalKey<FormState>();
  var _passwordFocus = FocusNode();

  String _email;
  String _password;

  _saveData() {
    _formKey.currentState.save();
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      // valid email and password here
      print(_email);
      print(_password);
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
              validator: (value){
                if (value.isEmpty) {
                  return 'Please enter your email';
                }
                if ((!value.endsWith('@gmail.com'))) {
                  return 'Please enter valid email';
                }
                return null;
              },
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
              onSaved: (value){
                _email=value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              focusNode: _passwordFocus,
              validator: (value){
                if(value.isEmpty){
                  return 'Please enter password';
                }
                if(value.length<6){
                  return 'Password must be in 6 character long';
                }
                return null;
              },
              onSaved: (value){
                _password=value;
              },
              onFieldSubmitted: (_){
                _saveData();
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 50),
              child: GestureDetector(
                onTap: () {
                  //
                  _saveData();
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
                    child: Text(
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
