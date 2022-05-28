import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:math';
import 'cards.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final List<String> Months=["","January", "February", "March", "April","May","June", "July", "August", "September", "October","November","December"];

  final m= DateTime.now().month;
  final d= DateTime.now().day;
  final y=DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.format_align_left),
        leading: Transform.rotate(
          angle: 90 * pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.leaderboard_rounded,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ),
        title: Text(
          'Todo',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              Icons.search,
              size: 28,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.orange.shade300,
                Colors.pink,
              ],
            )),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) / 5.5,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage('assets/webImage.png'),

                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hello, Jane.',
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Looks like feel good.\nyou have 3 tasks today.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Today: ${Months[m]} ${d}, ${y}',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),


                  Expanded(child: ScrollCards())
                ],
              ),
            )),
      ),
    );
  }
}
