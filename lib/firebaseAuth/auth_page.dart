import 'package:flutter/material.dart';
import 'package:igrzyska2023/firebaseAuth/login_widget.dart';
import 'package:igrzyska2023/firebaseAuth/sign_up_widget.dart';

// ignore: use_key_in_widget_constructors
class AuthPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
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
