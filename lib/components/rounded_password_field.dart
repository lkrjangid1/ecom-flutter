import 'package:ecom/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String errorText;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: isVisible,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          errorText: widget.errorText,
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: isVisible
                ? const Icon(
                    Icons.visibility_off,
                    color: kPrimaryColor,
                  )
                : const Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
