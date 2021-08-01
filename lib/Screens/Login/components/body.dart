import 'package:ecom/Screens/Signup/signup_screen.dart';
import 'package:ecom/bloc/Login.dart';
import 'package:ecom/components/already_have_an_account_acheck.dart';
import 'package:ecom/components/rounded_button.dart';
import 'package:ecom/components/rounded_input_field.dart';
import 'package:ecom/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloc = Provider.of<LoginBLoC>(context, listen: false);
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            StreamBuilder<String>(
                stream: bloc.email,
                builder: (context, snapshot) {
                  return RoundedInputField(
                    errorText: snapshot.error,
                    hintText: "Your Email",
                    onChanged: bloc.changeEmail,
                  );
                }),
            StreamBuilder<String>(
                stream: bloc.password,
                builder: (context, snapshot) {
                  return RoundedPasswordField(
                    errorText: snapshot.error,
                    onChanged: bloc.changePassword,
                  );
                }),
            StreamBuilder(
                stream: bloc.isValidForm,
                builder: (context, snapshot) {
                  return RoundedButton(
                    color: snapshot.hasError || !snapshot.hasData
                        ? kPrimaryLightColor
                        : kPrimaryColor,
                    text: "LOGIN",
                    press: snapshot.hasError || !snapshot.hasData
                        ? null
                        : () {
                            var user = bloc.submit(context);
                            if (user ==
                                    'Wrong password provided for that user.' ||
                                user == 'No user found for that email.') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(user)));
                            }
                          },
                  );
                }),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
