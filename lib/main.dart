// import 'dart:js';
import 'dart:async';

import 'package:auth/screens/selected_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _auth = FirebaseAuth.instance;

  late StreamSubscription<User?> _sub;

  int dailyCal = 0;

  @override
  void initState() {
    super.initState();
    _sub = FirebaseAuth.instance.authStateChanges().listen(
      (event) {
        _navigatorKey.currentState!.pushReplacementNamed(
          event != null ? 'home' : 'login',
        );
      },
    );
    // initialize();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  String userId = '';

  void _submitAuth(
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'Email': email,
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'DailyCal': 0
        });

      }
    } on PlatformException {
      var message = 'An error occured, please check your credentials!';
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
            content: Text(
              message,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red),
      );
    } catch (e) {
      // catches other errors
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'home' : 'login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const SelectedScreen(),
            );
          case 'login':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => AuthScreen(_submitAuth),
            );
        }
        return null;
      },
    );
  }
}
