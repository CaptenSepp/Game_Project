
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Advanced Layout with Glassmorphism'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Center(
              child: GlassmorphicContainer(
                width: 70,
                height: 70,
                borderRadius: 10,
                blur: 5,
                alignment: Alignment.bottomCenter,
                border: 0,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 98, 41, 230).withOpacity(0.3),
                    const Color(0xFFFFFFFF).withOpacity(0.0),
                  ],
                  stops: const [
                    0.1,
                    1,
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.15),
                    const Color((0xFFFFFFFF)).withOpacity(0.9),
                  ],
                ),
                child: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:ui';

// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/bg.png', // Replace with the path to your image asset
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(50.0),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 1.0),
//                 child: Container(
//                   width: 350.0,
//                   padding: EdgeInsets.all(20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(50.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.4),
//                         spreadRadius: 5,
//                         blurRadius: 20,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Glassmorphism Test",
//                         style: TextStyle(
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       SizedBox(height: 20.0),
//                       Text(
//                         "A more complex layout with glassmorphism effect.",
//                         style: TextStyle(fontSize: 16.0, color: Colors.black54),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 20.0),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text("Click Me"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:ui';

// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Image.asset(
//             'assets/bg.png', // Replace with the path to your image asset
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           // Glassmorphic Container
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//                 child: Container(
//                   width: 350.0,
//                   padding: EdgeInsets.all(20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(20.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Advanced Glassmorphism",
//                         style: TextStyle(
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       SizedBox(height: 20.0),
//                       Text(
//                         "A more advanced glassmorphic layout with a button.",
//                         style: TextStyle(fontSize: 16.0, color: Colors.black54),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 20.0),
//                       // Glassmorphic Button
//                       GlassmorphicButton(
//                         onPressed: () {
//                           // Handle button click
//                         },
//                         child: Text(
//                           "Click Me",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Glassmorphic Button Widget
// class GlassmorphicButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Widget child;

//   GlassmorphicButton({required this.onPressed, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0),
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF74EBD5),
//             Color(0xFFACD8AA),
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white.withOpacity(0.2),
//             spreadRadius: -2,
//             blurRadius: 12,
//             offset: Offset(0, 10),
//           ),
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(20.0),
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(20.0),
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//             child: Center(child: child),
//           ),
//         ),
//       ),
//     );
//   }
// }
