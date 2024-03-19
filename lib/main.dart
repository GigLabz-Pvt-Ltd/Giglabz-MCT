import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycareteam/screens/entry/login_screen.dart';
import 'package:mycareteam/screens/goal/create_goal_screen.dart';
import 'package:mycareteam/screens/home/home_screen.dart';
import 'package:mycareteam/screens/home/profile_screen.dart';
import 'package:mycareteam/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const SplashScreen(),
    );
  }
}
