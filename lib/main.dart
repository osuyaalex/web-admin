import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_admin/views/screens/main_screen.dart';

void main() async{
  //to initialize firebase on web
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: kIsWeb || Platform.isAndroid?const FirebaseOptions(
         apiKey: "AIzaSyA_2OoVhlidtEM2XogTinVhfnAV2076_20",
         appId: "1:252432202808:web:4904957af1d8de171abacd",
         messagingSenderId: "252432202808",
         projectId: "alex-multistorage",
       storageBucket: "alex-multistorage.appspot.com"
     ):null
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
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}

