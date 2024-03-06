// ignore: depend_on_referenced_packages
// ignore_for_file: prefer_const_constructors, prefer_const_declarations, annotate_overrides, use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:igrzyska2023/firebaseAuth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igrzyska2023/firebaseAuth/utils.dart';
import 'package:igrzyska2023/firebaseAuth/verify_email_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static final String title = 'Igrzyska 2023';

  const MyApp({super.key});

  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.tealAccent),
        ),
        home: MainPage(),
      );
  // This widget is the root of your application.
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              return VerifyEmailPage();
              //return HomePage();
            } else {
              return AuthPage();
            }
          },
        ),
      );
}
