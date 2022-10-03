import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:igrzyska2023/firebaseAuth/HomePage.dart';
import 'package:igrzyska2023/firebaseAuth/AuthPage.dart';
import 'package:igrzyska2023/firebaseAuth/LoginWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  static final String title = 'Igrzyska 2023';

  Widget build(BuildContext context) => MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData.dark().copyWith(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.tealAccent),
    ),
    home: MainPage(),
  );
  // This widget is the root of your application.
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body:  StreamBuilder<User?>(
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState ==  ConnectionState.waiting ){
          return Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError){
          return Center(child: Text('Something went wrong!'));
        }else if(snapshot.hasData){
          return HomePage();
        }else{
          return AuthPage();
        }
      },
    ),
  );
}




