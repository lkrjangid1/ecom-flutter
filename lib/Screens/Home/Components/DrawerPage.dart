import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: SafeArea(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    SystemNavigator.pop();
                  },
                  child: Text('Logout'))
            ],
          ),
        ),
      ),
    );
  }
}
