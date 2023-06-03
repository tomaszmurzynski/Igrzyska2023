import 'dart:js_interop';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igrzyska2023/page/profile_page.dart';
import 'package:igrzyska2023/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  get title => null;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    // final user = UserPreferences.myUser;

    return ThemeProvider(
      initTheme: user.isNull ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          title: title,
          home: const ProfilePage(),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Welcome Home'),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(32),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Text(
    //           'Singned In as',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //         const SizedBox(height: 8),
    //         Text(
    //           user.email!,
    //           style:
    //               const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    //         ),
    //         const SizedBox(height: 40),
    //         ElevatedButton.icon(
    //           style: ElevatedButton.styleFrom(
    //             minimumSize: const Size.fromHeight(50),
    //           ),
    //           icon: const Icon(Icons.arrow_back, size: 32),
    //           label: const Text(
    //             'Sign Out',
    //             style: TextStyle(fontSize: 24),
    //           ),
    //           onPressed: () => FirebaseAuth.instance.signOut(),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  // isDarkMode(User user) {
  //   var isDarkMode = user.isDarkMode;
  //   return isDarkMode;
  // }
}
