// ignore_for_file: prefer_const_constructors, dead_code, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'dart:math';

main() {
  runApp(MaterialApp(
    title: 'Scratch and Win',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage unlucky = AssetImage('assets/images/sadFace.png');
  AssetImage lucky = AssetImage('assets/images/rupee.png');
  AssetImage circle = AssetImage('assets/images/circle.png');

  List<String> face = [];
  var luckyNumber;

  @override
  void initState() {
    super.initState();
    setState(() {
      face = List<String>.generate(25, (inedx) => "empty");
    });
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25) + 1;
    luckyNumber = random;
  }

  resetAll() {
    setState(() {
      face = List<String>.filled(25, "empty");
    });
    generateRandomNumber();
  }

  getImage(int value) {
    String currentIndex = face[value];
    switch (currentIndex) {
      case 'lucky':
        return lucky;
        break;
      case 'unlucky':
        return unlucky;
        break;
    }
    return circle;
  }

  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        face[index] = "lucky";
      });
    } else {
      setState(() {
        face[index] = "unlucky";
      });
    }
  }

  showAll() {
    setState(() {
      face = List<String>.filled(25, 'unlucky');
      face[luckyNumber] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Scratch and Win!',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 20,
      ),
      body: Container(
        padding: EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(20.0),
                  itemCount: face.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          playGame(index);
                        },
                        child: SizedBox(
                          child: Container(
                            padding: EdgeInsets.all(3),
                            color: Colors.black,
                            child: Center(
                              child: Image(
                                image: getImage(index),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                Colors.grey,
                Colors.black,
              ])),
              child: ElevatedButton(
                onPressed: resetAll,
                child: Text(
                  'Reset all',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  elevation: 0,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                Colors.grey,
                Colors.black,
              ])),
              child: ElevatedButton(
                onPressed: showAll,
                child: Text(
                  'Show all',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
