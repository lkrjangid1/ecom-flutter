import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bottom extends StatefulWidget {
  final data;
  Bottom({this.data});
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  String _subscriptionValue;

  _submit(data) {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser.uid + 'cart')
          .doc(data.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item Already Exist')));
        } else {
          FirebaseFirestore.instance
              .collection(FirebaseAuth.instance.currentUser.uid + 'cart')
              .doc(data.id)
              .set({
                'data': [
                  data['name'],
                  data['image'],
                  data['company'],
                  data['link'],
                ],
                'subscription': _subscriptionValue,
                'prize': _subscriptionValue == '1 Year' ? '1000' : '500'
              })
              .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item added successfully'))))
              .catchError((error) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$error'))));
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                    height: 150,
                    width: 100,
                    child: Image.network(widget.data['image'])),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['name'],
                      overflow: TextOverflow.fade,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.data['company'],
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            Text(
              'Subscription',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Radio(
                          value: '6 Month',
                          groupValue: _subscriptionValue,
                          onChanged: (v) {
                            setState(() {
                              _subscriptionValue = v;
                            });
                          }),
                      Text(
                        '6 Month',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '500 Rs',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Radio(
                          value: '1 Year',
                          groupValue: _subscriptionValue,
                          onChanged: (v) {
                            setState(() {
                              _subscriptionValue = v;
                            });
                          }),
                      Text(
                        '1 Year',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '1000 Rs',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                _submit(widget.data);
              },
              child: Text('Add to cart'),
            )
          ],
        ),
      ),
    );
  }
}
