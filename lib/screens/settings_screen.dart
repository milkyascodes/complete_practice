// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:using_flutter_firebase/auth/auth.dart';
import 'package:using_flutter_firebase/screens/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  RootAuth? auth;
  var signOut;

  SettingsScreen({
    Key? key,
    this.auth,
    this.signOut,
  }) : super(key: key);

  void _signUserOut() async {
    try {
      await auth!.signOutUser().whenComplete(() => signOut());
    } catch (e) {
      print(e);
    }
  }

  var value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        foregroundColor: Colors.black,
      ),
      body: SettingsList(
        shrinkWrap: true,
        sections: [
          SettingsSection(
            title: 'General',
            tiles: [buildProfileTile(), buildStatusTile()],
          ),
          SettingsSection(
            title: 'System',
            tiles: [
              buildDarkModeTile(),
              buildNotificationTile(),
              buildLanguageTile()
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [buildLogOutTile(), buildDeleteAccountTile()],
          ),
          SettingsSection(
            title: 'Feedack',
            tiles: [buildContactTile(), buildAboutAppTile()],
          ),
        ],
      ),
    );
  }

  void openDialog(context) {
    print('object');
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Log Out?'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            CupertinoDialogAction(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _signUserOut();
              },
            ),
          ],
        );
      },
    );
  }

// SettingTiles
  AbstractTile buildProfileTile() {
    return SettingsTile(
      title: "Miki",
      leading: CircleAvatar(
        radius: 12,
        backgroundImage: AssetImage('assets/bg.jpg'),
      ),
      onPressed: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
    );
  }

  AbstractTile buildStatusTile() {
    return SettingsTile.switchTile(
      switchValue: value,
      title: 'Online Status',
      leading: FaIcon(
        FontAwesomeIcons.user,
        color: Colors.green,
      ),
      onToggle: (context) {},
    );
  }

  AbstractTile buildDarkModeTile() {
    return SettingsTile.switchTile(
      switchValue: value,
      title: 'Dark Mode',
      leading: FaIcon(
        FontAwesomeIcons.moon,
        color: Colors.purple,
      ),
      onToggle: (context) {},
    );
  }

  AbstractTile buildNotificationTile() {
    return SettingsTile(
      title: 'Notifications',
      leading: FaIcon(
        FontAwesomeIcons.bell,
        color: Colors.amber,
      ),
      onPressed: (context) {},
    );
  }

  AbstractTile buildLanguageTile() {
    return SettingsTile(
      title: 'Language',
      subtitle: 'English',
      leading: Icon(Icons.language),
      onPressed: (BuildContext context) {},
    );
  }

  AbstractTile buildLogOutTile() {
    return SettingsTile(
      title: 'Log Out',
      leading: FaIcon(
        FontAwesomeIcons.arrowRightFromBracket,
        color: Colors.lightBlue,
      ),
      onPressed: (context) {
        openDialog(context);
      },
    );
  }

  AbstractTile buildDeleteAccountTile() {
    return SettingsTile(
      title: 'Delete Account',
      leading: FaIcon(
        FontAwesomeIcons.trash,
        color: Colors.red,
      ),
      onPressed: (context) {},
    );
  }

  AbstractTile buildContactTile() {
    return SettingsTile(
      title: 'Feedback',
      leading: FaIcon(
        FontAwesomeIcons.message,
        color: Colors.green,
      ),
      onPressed: (context) {},
    );
  }

  AbstractTile buildAboutAppTile() {
    return SettingsTile(
      title: 'App Info',
      leading: FaIcon(
        FontAwesomeIcons.info,
        color: Colors.black,
      ),
      onPressed: (context) {},
    );
  }
}

// Widget buildlogOut() {
//   return TextButton.icon(
//     style: ButtonStyle(
//       padding: MaterialStateProperty.all(
//         EdgeInsets.all(15),
//       ),
//     ),
//     onPressed: () {
//       _signUserOut();
//     },
//     label: Text('Sign Out'),
//     icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket),
//   );
// }
