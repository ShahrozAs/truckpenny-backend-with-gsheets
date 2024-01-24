import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:truckpenny/firebase_options.dart';
import 'package:truckpenny/google_sheets_api.dart';
import 'package:truckpenny/home_page_firebase.dart';
import 'package:truckpenny/homepage.dart';
import 'package:truckpenny/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truck Penny',
      theme: ThemeData(
  
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home:  HomePageFirebase(),
      debugShowCheckedModeBanner: false,
    );
  }
}




