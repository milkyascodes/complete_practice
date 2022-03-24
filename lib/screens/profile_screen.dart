// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:using_flutter_firebase/auth/auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  double coverHeight = 300;
  double profileHeight = 114;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        foregroundColor: Colors.black,
      ),
      body: Column(
        // padding: EdgeInsets.zero,
        children: [
          buildTop(),
          buildProfileText(),
          buildSocial(),
          Divider(),
          // buildAboutText(),
          Divider(
            color: Colors.transparent,
          ),
          // buildlogOut()
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: profileHeight / 2),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() {
    return Container(
      color: Colors.black,
      child: Image.asset('assets/bg.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
          color: Colors.white.withOpacity(.4),
          colorBlendMode: BlendMode.modulate),
    );
  }

  Widget buildProfileImage() {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundImage: AssetImage('assets/bg.jpg'),
    );
  }

  Widget buildProfileText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Column(
        children: [
          buildTitle('MILKYAS', 20),
          Text(
            'Flutter Developer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildAboutText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle('About', 25),
          SizedBox(height: 10),
          Text(
            'In a professional context it often happens that private or corporate clients corder a publication to be made and presented with the actual content still not being ready.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget buildSocial() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.github)),
          IconButton(
              onPressed: () {}, icon: FaIcon(FontAwesomeIcons.facebookF)),
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.telegram)),
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.slack)),
        ],
      ),
    );
  }

  Widget buildTitle(String text, double size) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: size),
    );
  }
}
