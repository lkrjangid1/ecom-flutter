import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../validators.dart';

class RegisterBloC with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  ///Getters (who get data) (listen stream)
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);


  Stream<bool> get isValidForm => Rx.combineLatest2(
      email, password,  (a, b) => true);

  ///Setters (Who is doing changes) (put input in stream)
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  ///Transformer
  //these transformers on validators page


  void submit(){
    print(_email.value);
    print(_password.value);
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}
