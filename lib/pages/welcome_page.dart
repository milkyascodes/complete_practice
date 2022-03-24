// ignore_for_file: prefer_const_constructors, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:using_flutter_firebase/auth/auth.dart';
import 'package:using_flutter_firebase/pages/guard_page.dart';
import 'on_board_page.dart';

// class WelcomePage extends StatefulWidget {
//   RootAuth? auth;
//   WelcomePage({Key? key, this.auth}) : super(key: key);

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// enum AuthStatus { signedIn, notSignedIn }

// class _WelcomePageState extends State<WelcomePage> {
//   var currentPage;
//   AuthStatus _authStatus = AuthStatus.signedIn;

//   @override
//   void initState() {
//     super.initState();
//     print('current user ....${widget.auth?.currentUser()}');

//     widget.auth?.currentUser().then((value) {
//       setState(() {
//         _authStatus =
//             value == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
//       });
//     });
//     currentPage = 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_authStatus == AuthStatus.notSignedIn) {
//       return Scaffold(
//           body: Center(
//         child: Column(
//           children: [
//             Spacer(),
//             // splash content
//             Expanded(
//               flex: 4,
//               child: PageView.builder(
//                 onPageChanged: (value) {
//                   setState(() {
//                     currentPage = value;
//                   });
//                 },
//                 itemCount: splashData.length,
//                 itemBuilder: (context, index) {
//                   return Center(
//                       child: buildSplashContent(
//                     splashData[index].title,
//                     splashData[index].info,
//                     splashData[index].imgUrl,
//                   ));
//                 },
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                     splashData.length, (index) => buildDots(index: index)),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                   primary: Colors.grey[200],
//                   elevation: 1,
//                 ),
//                 onPressed: () {
//                   // await splashLoader();
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => GuardPage()),
//                   );
//                 },
//                 child: Text(
//                   'Get Started',
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ),
//             ),
//             Spacer(),
//           ],
//         ),
//       ));

//     } else {
//       return GuardPage();
//     }
//   }

//   Widget buildDots({int? index}) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//       margin: EdgeInsets.only(right: 5),
//       height: 10,
//       width: currentPage == index ? 35 : 10,
//       decoration: BoxDecoration(
//         color: currentPage == index ? Colors.amber : Colors.grey[300],
//         borderRadius: BorderRadius.circular(100),
//       ),
//     );
//   }

//   Widget buildSplashContent(title, info, imageUrl) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SvgPicture.asset(
//           imageUrl,
//           fit: BoxFit.contain,
//           height: 300,
//         ),
//         Column(
//           children: [
//             buildTitle(title.toString(), 30),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//               child: Text(
//                 info,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }

//   Widget buildTitle(String text, double size) {
//     return Text(
//       text,
//       style: TextStyle(
//           color: Colors.black, fontWeight: FontWeight.bold, fontSize: size),
//     );
//   }

// }

class WelcomePage extends StatefulWidget {
  RootAuth? auth;
  WelcomePage({Key? key, this.auth}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

enum AuthStatus { signedIn, notSignedIn }

class _WelcomePageState extends State<WelcomePage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  var loading;
  @override
  void initState() {
    super.initState();
    loading = true;
    splashLoader();
    widget.auth?.currentUser().then((value) {
      setState(() {
        _authStatus =
            value == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  splashLoader() {
    loading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_authStatus == AuthStatus.notSignedIn) {
      return OnBoard();
    } else {
      return GuardPage(
        auth: Auth(),
      );
    }
  }
}
