import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final String itemCount;
  final Color textColor;
  final Color badgeBackColor;
  CartButton({this.badgeBackColor, this.itemCount, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Icon(Icons.add_shopping_cart_rounded),
        new Positioned(
          right: 0,
          child: new Container(
            padding: EdgeInsets.all(1),
            decoration: new BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: new Text(
              itemCount,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
