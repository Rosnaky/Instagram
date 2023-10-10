import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_flutter/screens/LoginScreen.dart';
import 'package:instagram_flutter/screens/SignUpScreen.dart';
import 'FirebaseOptions.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/responsive/MobileLayout.dart';
import 'package:instagram_flutter/responsive/ResponsiveLayoutTheme.dart';
import 'package:instagram_flutter/responsive/WebLayout.dart';
import 'package:instagram_flutter/utils/Colours.dart';
import "dart:ui_web";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: ResponsiveLayout(
        //     mobileLayout: MobileLayout(), webLayout: WebLayout()),
        home: SignUpScreen());
  }
}
