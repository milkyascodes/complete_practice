// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:using_flutter_firebase/auth/auth.dart';
import 'package:using_flutter_firebase/pages/home_page.dart';
import 'package:using_flutter_firebase/pages/login_page.dart';

import '../models/splash_model.dart';

class GuardPage extends StatefulWidget {
  RootAuth auth;
  GuardPage({Key? key, required this.auth}) : super(key: key);
  @override
  State<GuardPage> createState() => _GuardPageState();
}

enum AuthStatus { signedIn, notSignedIn }

class _GuardPageState extends State<GuardPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  var loading;
  @override
  void initState() {
    super.initState();
    loading = true;
    splashLoader();
    widget.auth.currentUser().then((value) {
      setState(() {
        _authStatus =
            value == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void signIn() async {
    await splashLoader();
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void signOut() async {
    await splashLoader();
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  splashLoader() {
    loading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_authStatus == AuthStatus.notSignedIn) {
      return !loading
          ? LogInPage(
              auth: widget.auth,
              onSignIn: signIn,
            )
          : Scaffold(
              body: Center(
                child: SpinKitThreeBounce(
                  size: 50,
                  color: Colors.amber,
                ),
              ),
            );
    } else {
      return !loading
          ? MyHomePage(
              signOut: signOut,
              auth: widget.auth,
            )
          : Scaffold(
              body: Center(
                child: SpinKitThreeBounce(
                  size: 50,
                  color: Colors.amber,
                ),
              ),
            );
    }
  }
}
