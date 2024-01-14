// import 'package:flutter/material.dart';

// class PlusButton extends StatelessWidget {
//   const PlusButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.grey[500],
//       ),
//       height: 75,
//       width: 75,
//       child: Center(
//           child: Text(
//         '+',
//         style: TextStyle(color: Colors.white, fontSize: 25),
//       )),
//     ); 
//   }
// }


import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;

  PlusButton({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '+',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}