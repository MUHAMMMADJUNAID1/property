import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:property/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Provider/Auth_Provider.dart';
import 'Provider/Send_Post_Provider.dart';
import 'Screens/Home/Home_screen.dart';
import 'Screens/Welcome/Welcome_Screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");

    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something Went Wrong", );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ScreenUtilInit(
            builder: (context, child) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => SendPostProvider()),
                ChangeNotifierProvider(create: (context) => AuthProvider()),
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: FutureBuilder(
                    future: checkLoginStatus(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data == true) {
                        return const HomeScreen();
                      }

                      return const WelcomeScreen();
                    },
                  )),
            ),
            designSize: const Size(414, 896),
          );
        });
  }
}
