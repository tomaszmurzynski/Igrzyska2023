import 'package:flutter/material.dart';
import 'package:igrzyska2023/firebaseAuth/loginWidget.dart';
import 'package:igrzyska2023/firebaseAuth/signUpWidget.dart';


class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedSignUp: toogle)
      : SignUpWidget(onClickedSignIn: toogle);
  void toogle() => setState(() => isLogin = !isLogin);
}
