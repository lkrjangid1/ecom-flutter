import 'dart:async';

import 'package:ecom/Screens/Home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../validators.dart';

class RegisterBloC with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  ///Getters (who get data) (listen stream)
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);

  Stream<bool> get isValidForm =>
      Rx.combineLatest2(email, password, (a, b) => true);

  ///Setters (Who is doing changes) (put input in stream)
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  ///Transformer
  //these transformers on validators page

  submit(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.value, password: _password.value);
      if (userCredential != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}
