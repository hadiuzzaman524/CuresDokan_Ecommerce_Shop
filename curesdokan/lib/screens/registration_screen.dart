import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/signupdesign.dart';
import '../widgets/logindesign.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isSignup = false;

  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.redAccent,
                Colors.blue,
              ])),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'CuresDokan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      transform: Matrix4.rotationZ(0.1),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    isSignup = true;
                                    isLogin = false;
                                  });
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: isSignup ? Colors.green : Colors.black,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    isSignup = false;
                                    isLogin = true;
                                  });
                                },
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: isLogin ? Colors.green : Colors.black,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            child: isSignup
                                ? SignUpDesign()
                                : LoginDesign(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
