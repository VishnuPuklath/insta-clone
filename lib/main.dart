import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
import 'package:insta_clone/responsive/responsive_layout_screen.dart';
import 'package:insta_clone/responsive/web_screen_layout.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/utils/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCbmNY_8bPGOzaREcROHIHb8EvqslXjshE',
          appId: '1:959972885951:web:75bcd1ad88ddf1d388cd0a',
          messagingSenderId: '959972885951',
          projectId: 'instagram-clone-54154',
          storageBucket: 'instagram-clone-54154.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        debugShowCheckedModeBanner: false,
        title: 'instaclone',
        home: SignupScreen()

        // Scaffold(
        //   body: ResponsiveLayout(
        //       mobileScreenLayout: MobileScreenLayout(),
        //       webScreenLayout: WebScreenLayout()),
        // ),

        );
  }
}
