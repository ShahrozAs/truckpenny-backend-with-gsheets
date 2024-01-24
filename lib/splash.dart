// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:truckpenny/homepage.dart';
// import 'package:truckpenny/permissionpage.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {

//     super.initState();
//     Timer(const Duration(seconds: 3), () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(child: Image.asset('assets/images/truckSplash1.gif',width: 300,height: 300,),),
//     );
//   }
// }