import 'package:auth/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailForm extends StatelessWidget {
  final onSaved;

  const EmailForm({
    Key? key,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: kBoxDecoration(BorderRadius.circular(10)),
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
        onSaved: onSaved,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(10, 13, 0, 0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            hintText: 'Enter your e-mail',
            hintStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class PasswordForm extends StatelessWidget {
  final onSaved;

  const PasswordForm({
    Key? key,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: kBoxDecoration(BorderRadius.circular(10)),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.length < 6) {
            return ('Password must be at least 6 characters long.');
          } else {
            return null;
          }
        },
        onSaved: onSaved,
        obscureText: true,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(10, 13, 0, 0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            hintText: 'Enter your password',
            hintStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}

Widget buildAuthButton(Function onPressed, bool isLogin) {
  return ElevatedButton(
    onPressed: () {
      onPressed();
    },
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
    child: Ink(
      color: Colors.black
          .withOpacity(0), //set this opacity as per your requirement
      // decoration: kBoxDecoration(),
      child: Container(
        decoration: kBoxDecoration(BorderRadius.circular(41.0)),
        width: double.infinity,
        height: 70,
        alignment: Alignment.center,
        child: Text(
          isLogin ? 'Log In' : 'Sign Up',
          style: GoogleFonts.pacifico(color: Colors.white, fontSize: 25),
        ),
      ),
    ),
  );
}

class createAccBtn extends StatelessWidget {
  final onPressed;
  final bool _isLogin;

  const createAccBtn({
    Key? key,
    required bool isLogin,
    required this.onPressed,
  })  : _isLogin = isLogin,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
          primary: Colors.black.withOpacity(0)),
      child: Ink(
        color: Colors.black.withOpacity(0),
        child: Container(
          child: Text(
            _isLogin
                ? 'New here ? Create an account !'
                : "I'm a regular here, log me in",
            textAlign: TextAlign.center,
            style: GoogleFonts.pacifico(color: Colors.black, fontSize: 15),
          ),
          decoration: kBoxDecoration(BorderRadius.circular(10.0)),
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
