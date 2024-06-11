import 'package:dating_app/authenticationScreen/loginScreen.dart';
import 'package:dating_app/controller/authenticationController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyApAko-LiDiXTFDVrZV2HJJG_9lCmc4Jvo",
        appId: "1:293011831727:android:601ee2b050239488d94d5a",
        messagingSenderId: "293011831727",
        projectId: "dating-app-44e1f",
        storageBucket: "dating-app-44e1f.appspot.com")).then((value){
      Get.put(AuthenticationController());
    });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dating App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

