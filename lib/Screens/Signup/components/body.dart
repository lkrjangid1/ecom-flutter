import 'package:ecom/Screens/Login/login_screen.dart';
import 'package:ecom/Screens/Signup/components/background.dart';
import 'package:ecom/Screens/Signup/components/or_divider.dart';
import 'package:ecom/Screens/Signup/components/social_icon.dart';
import 'package:ecom/bloc/Register.dart';
import 'package:ecom/components/already_have_an_account_acheck.dart';
import 'package:ecom/components/rounded_button.dart';
import 'package:ecom/components/rounded_input_field.dart';
import 'package:ecom/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloc = Provider.of<RegisterBloC>(context, listen: false);

    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
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
                      text: "SIGNUP",
                      press: snapshot.hasError || !snapshot.hasData
                          ? null
                          : () {
                              bloc.submit();
                            },
                    );
                  }),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
