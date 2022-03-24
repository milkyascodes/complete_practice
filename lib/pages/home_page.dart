// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:using_flutter_firebase/auth/auth.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  final VoidCallback signOut;
  RootAuth auth;
  MyHomePage({Key? key, required this.signOut, required this.auth})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var index;
  @override
  void initState() {
    index = 2;
    super.initState();
  }

// return ProfilePage(
//       auth: widget.auth,
//       signOut: widget.signOut,
//     );

  @override
  Widget build(BuildContext context) {
    var screens = [
      HomeScreen(),
      AboutScreen(),
      ProfilePage(),
      SettingsScreen(
        auth: widget.auth,
        signOut: widget.signOut,
      ),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: index,
        unselectedItemColor: Colors.grey[600],
        onTap: (i) => setState(() => index = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// About
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.phone),
            title: Text("Contacts"),
            selectedColor: Colors.pink,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.userGear),
            title: Text("Profile"),
            selectedColor: Colors.orange,
          ),

          /// Settings
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.gear),
            title: Text("Settings"),
            selectedColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}





// bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (index) {
      //     setState(() {
      //       this.index = index;
      //     });
      //   },
      //   destinations: const [
      //     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      //     NavigationDestination(icon: Icon(Icons.newspaper), label: 'About'),
      //     NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
      //   ],
      // ),