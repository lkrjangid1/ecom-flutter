import 'package:ecom/Screens/Home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Welcome/welcome_screen.dart';
import 'bloc/Login.dart';
import 'bloc/Register.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => RegisterBloC()),
        Provider(create: (context) => LoginBLoC()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ECOM',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: FirebaseAuth.instance.currentUser != null
            ? HomePage()
            : WelcomeScreen(),
      ),
    );
  }
}
