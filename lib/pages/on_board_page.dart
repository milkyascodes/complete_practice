// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:using_flutter_firebase/auth/auth.dart';
import 'package:using_flutter_firebase/pages/guard_page.dart';
import '../models/splash_model.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  var currentPage;
  @override
  void initState() {
    super.initState();
    currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Spacer(),

          // ? .... splash content
          Expanded(
            flex: 5,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) {
                return Center(
                    child: buildSplashContent(
                  splashData[index].title,
                  splashData[index].info,
                  splashData[index].imgUrl,
                ));
              },
            ),
          ),

          //? ... dots
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  splashData.length, (index) => buildDots(index: index)),
            ),
          ),
          // Spacer(),
        ],
      ),
    ));
  }

  Widget buildDots({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: currentPage == index ? 35 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.amber : Colors.grey[300],
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget buildSplashContent(title, info, imageUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          imageUrl,
          fit: BoxFit.contain,
          height: 300,
        ),
        Column(
          children: [
            buildTitle(title.toString(), 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                info,
                textAlign: TextAlign.center,
              ),
            ),
            currentPage == 2 ? buildActionButton() : Container(),
            SizedBox(
              height: 50,
            ),
          ],
        )
      ],
    );
  }

  Widget buildActionButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            primary: Colors.grey[200],
            elevation: 1,
          ),
          onPressed: () {
            // await splashLoader();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => GuardPage(
                        auth: Auth(),
                      )),
            );
          },
          child: const Text(
            'Get Started',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
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
