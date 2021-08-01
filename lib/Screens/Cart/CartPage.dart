import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CartPage extends StatelessWidget {
  final int totalPrize;
  CartPage({this.totalPrize});
  List outPutData = [];
  bool checkPurchase;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(totalPrize.toString() + ' Rs'),
            OutlinedButton(
              onPressed: () {
                try {
                  for (var data in outPutData) {
                    FirebaseFirestore.instance
                        .collection(
                            FirebaseAuth.instance.currentUser.uid + 'purchased')
                        .doc(data[0])
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Item Already Purchased')));
                      } else {
                        FirebaseFirestore.instance
                            .collection(FirebaseAuth.instance.currentUser.uid +
                                'purchased')
                            .doc(data[0])
                            .set({
                          'data': [data[1], data[2], data[3], data[4]],
                          'subscription': data[5],
                          'prize': data[6],
                          'purchaseDate': '${DateTime.now().day}' +
                              '/' +
                              '${DateTime.now().month}' +
                              '/' +
                              '${DateTime.now().year}',
                          'purchaseTime': '${DateTime.now().hour}' +
                              ':' +
                              '${DateTime.now().minute}'
                        }).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Item purchase successfully')));
                          FirebaseFirestore.instance
                              .collection(
                                  FirebaseAuth.instance.currentUser.uid +
                                      'cart')
                              .doc(data[0])
                              .delete()
                              .then((value) => print('delete item'))
                              .catchError((error) => print(error));
                        }).catchError((error) => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error))));
                      }
                    });
                  }
                } on Exception catch (e) {
                  print(e);
                }
              },
              child: Text('Purchase'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser.uid + 'cart')
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return ListView.builder(
                itemCount: snapShot.data.docs.length,
                itemBuilder: (context, index) {
                  var data = snapShot.data.docs[index];
                  outPutData.add([
                    data.id,
                    data['data'][0],
                    data['data'][1],
                    data['data'][2],
                    data['data'][3],
                    data['subscription'],
                    data['prize']
                  ]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 150,
                                width: 100,
                                child: Image.network(data['data'][1])),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['data'][0],
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['data'][2],
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      try {
                                        FirebaseFirestore.instance
                                            .collection(FirebaseAuth
                                                    .instance.currentUser.uid +
                                                'cart')
                                            .doc(data.id)
                                            .delete()
                                            .then((value) =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Item removed successfully'))))
                                            .catchError((error) =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text('$error'))));
                                      } on Exception catch (e) {
                                        print(e);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.grey,
                                    )),
                                Row(
                                  children: [
                                    Text('Subscription : '),
                                    Text(
                                      data['subscription'],
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
