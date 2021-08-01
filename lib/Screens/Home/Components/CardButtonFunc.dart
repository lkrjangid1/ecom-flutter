import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Screens/Cart/CartPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'CartButtonUI.dart';

class CardButtonFunc extends StatelessWidget {
  int totalPrize = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(
              totalPrize: totalPrize,
            ),
          ),
        );
      },
      icon: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseAuth.instance.currentUser.uid + 'cart')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return CartButton(
                textColor: Colors.red,
                badgeBackColor: Colors.white,
                itemCount: '*',
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CartButton(
                textColor: Colors.white,
                badgeBackColor: Colors.blueAccent,
                itemCount: '0',
              );
            }
            for (int index = 0; index < snapshot.data.docs.length; index++) {
              totalPrize += int.parse(snapshot.data.docs[index]['prize']);
            }
            return CartButton(
              textColor: Colors.white,
              badgeBackColor: Colors.blueAccent,
              itemCount: snapshot.data.docs.length.toString(),
            );
          }),
    );
  }
}
