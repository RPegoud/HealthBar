import 'package:auth/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui_components/ui_components.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen(this.submitForm);
  final void Function(
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitForm;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  var _isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // close the keyboard on submit
    if (isValid) {
      // print(_userEmail);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isLogin ? 'Loging in ...' : 'Signing up ...',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
      _formKey.currentState
          ?.save(); // goes to all formfields and triggers onSaved
      widget.submitForm(
        _userEmail,
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildTopEllipse('assets/images/Orange.png'),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 70,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildTitle('Welcome !', TextAlign.left),
                  insertSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 70),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            buildText('E-mail :',TextAlign.start),
                            insertSpace(10),
                            Stack(
                              children: <Widget>[
                                buildGradientContainer(Alignment.centerLeft, [lightBlue, darkBlue]),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    color: Colors.white,
                                  ),
                                  height: 60,
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null ||
                                          !value.contains('@') ||
                                          !value.contains('.com')) {
                                        return ('Please enter a valid email adress.');
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      _userEmail = value!;
                                    },
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 13, 0, 0),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        hintText: 'Enter your e-mail',
                                        hintStyle:
                                            TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                            buildText('Password :', TextAlign.start),
                            insertSpace(10),
                            Stack(
                              children: <Widget>[
                                buildGradientContainer(Alignment.centerLeft, [lightBlue, darkBlue]),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    color: Colors.white,
                                  ),
                                  height: 60,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.length < 6) {
                                        return ('Password must be at least 6 characters long.');
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      _userPassword = value!;
                                    },
                                    obscureText: true,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 13, 0, 0),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        hintText: 'Enter your password',
                                        hintStyle:
                                            TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                            buildForgotPassword(),
                            insertSpace(30),
                            buildAuthButton(_trySubmit, _isLogin),
                            insertSpace(40),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shadowColor: Colors.white),
                              child: Text(
                                _isLogin
                                    ? 'New here ? Create an account !'
                                    : "I'm a regular here, log me in",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.pacifico(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
