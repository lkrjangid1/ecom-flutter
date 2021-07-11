import 'package:flutter/material.dart';

import '../../constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "ECOM",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Text('Home'),
      ),
    );
  }
}
