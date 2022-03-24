// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:using_flutter_firebase/auth/auth.dart';

class LogInPage extends StatefulWidget {
  RootAuth? auth;
  final VoidCallback onSignIn;
  LogInPage({Key? key, this.auth, required this.onSignIn}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

enum FormType { login, register }

class _LogInPageState extends State<LogInPage> {
  FormType _formType = FormType.register;
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? errorInfoMsg;

  bool validateAndSave() {
    final formState = formKey.currentState;
    formState!.save();
    if (formState.validate()) {
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        _formType == FormType.login
            ? await widget.auth?.signInWithEmailAndPassword(_email, _password)
            : await widget.auth!
                .createUserWithEmailAndPassword(_email, _password);

        // sign in
        widget.onSignIn();
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorInfoMsg = e.code;
        });
      }
    }
  }

  void switchToLogin() {
    formKey.currentState!.reset();
    errorInfoMsg = null;
    setState(() {
      _formType = FormType.login;
    });
  }

  void switchToRegister() {
    formKey.currentState!.reset();
    errorInfoMsg = null;
    setState(() {
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: buildInputs() + buildButtons() + buildErrorInfo(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widgets
  List<Widget> buildInputs() {
    return [
      buildText(),
      SizedBox(height: 50),
      TextFormField(
        validator: (value) => value!.isEmpty ? 'Email can\'t be empty' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.alternate_email),
            hintText: 'Enter your email'),
        onSaved: (value) => _email = value,
      ),
      SizedBox(height: 20),
      TextFormField(
        obscureText: true,
        validator: (value) =>
            value!.isEmpty ? 'Password can\'t be empty' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
            hintText: 'Enter your password'),
        onSaved: (value) => _password = value,
      ),
      SizedBox(
        height: 30,
      )
    ];
  }

  Widget buildText() {
    return Text(_formType == FormType.login ? 'LOG IN' : 'SIGN UP',
        style: TextStyle(fontSize: 30));
  }

  List<Widget> buildErrorInfo() {
    if (errorInfoMsg != null) {
      return [
        SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.amber,
            child: Text(errorInfoMsg.toString()),
          ),
        ),
        SizedBox(height: 10),
      ];
    } else {
      return [Container()];
    }
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            primary: Colors.black,
          ),
          onPressed: () {
            validateAndSubmit();
          },
          child: Text('LOG IN'),
        ),
        SizedBox(height: 10),
        TextButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            setState(() {
              switchToRegister();
            });
          },
          child: Text('Don\'t have an account? Create Account '),
        ),
      ];
    } else {
      return [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            validateAndSubmit();
          },
          child: Text('SIGN UP'),
        ),
        SizedBox(height: 10),
        TextButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            setState(() {
              switchToLogin();
            });
          },
          child: Text('Aready have an account? Login '),
        ),
      ];
    }
  }
}
