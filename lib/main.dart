import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/Screens/login_screen.dart';
import 'package:flutter_social/Screens/signup_screen.dart';
import 'package:flutter_social/responsive/mobile_layout.dart';
import 'package:flutter_social/responsive/responsive_layout_screen.dart';
import 'package:flutter_social/responsive/web_layout.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBc65cItFRiI_j_sdpAVZNDblEyLH-zkHQ",
      appId: "1:431796869988:web:0be328e7a59a36dcde3871",
      messagingSenderId: "431796869988",
      projectId: "social-4a516",
      storageBucket: "social-4a516.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          //   home: ResponsiveLayout(
          //       mobileLayout: MobileLayout(), webLayout: WebLayout()),
          // );
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData &&
                  FirebaseAuth.instance.currentUser!.emailVerified) {
                return const ResponsiveLayout(
                  mobileLayout: MobileLayout(),
                  webLayout: WebLayout(),
                );
              }
              return const LoginScreen();
            },
          )),
    );
  }
}
