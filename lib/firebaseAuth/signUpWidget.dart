import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igrzyska2023/firebaseAuth/Utils.dart';
import 'package:igrzyska2023/firebaseAuth/google/provider/googleSignIn.dart';
import 'package:igrzyska2023/main.dart';
import 'package:provider/provider.dart';


class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
    }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Form(
      key:  formKey,

      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
        SizedBox(height: 60),
        FlutterLogo(size: 50),
        SizedBox(height: 20),
        Text('Hey There, \n Welbome Back',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32,
          fontWeight: FontWeight.normal)
          ),
        SizedBox(height: 40),
        TextFormField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Email'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (email) =>
          email != null && !EmailValidator.validate(email)
          ? 'Enter a valid email'
          : null,
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(labelText: 'Enter password'),
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) =>
          value != null && value.length < 6
              ? 'Enter min. 6 characters'
              : null,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),
          ),
          icon: Icon(Icons.lock_open, size: 32),
          label: Text(
            'Sign Up',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: signUp,
        ),
        SizedBox(height: 4),
        //Button signUp with
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),
          ),
          child: Text('Sign Up with...',
              style: TextStyle(fontSize: 24),
          ),
          onPressed: (){
            final provider = Provider.of<GoogleSingInProvider>(context, listen: false);
            provider.googleLogin();
          },
        ),
        SizedBox(height: 24),
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 20),
                text: 'Already have an account?  ',
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text:  'Log In',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                   ),
                ],
             ),
            ),
          ],
        ),
      ),
  );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch (e){
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
