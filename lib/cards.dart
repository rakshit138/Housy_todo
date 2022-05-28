
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'Personaltodo.dart';
import 'package:housy_todo/Worktodo.dart';
import 'package:housy_todo/Hometodo.dart';

class ScrollCards extends StatefulWidget {
  const ScrollCards({Key? key}) : super(key: key);

  @override
  State<ScrollCards> createState() => _ScrollCardsState();
}

class _ScrollCardsState extends State<ScrollCards> {
  Container buildKey(
      {required Icon icon, required int count, required String title, required double percent, required page}) {
    return Container(
      child: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
        child: Container(

          height: (MediaQuery.of(context).size.height) / 1.8,
          width: (MediaQuery.of(context).size.width) / 1.15,
          child:GestureDetector(
            onVerticalDragStart: (DragStartDetails dragStartDetails){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>page));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
                elevation: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade900,
                            child: CircleAvatar(
                                backgroundColor: Colors.white, child: icon, radius: 30,),
                          ),
                          Icon(Icons.more_vert)
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${count} Tasks',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey.shade700),
                                ))),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 10, 30),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.black),
                                ))),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 20, 20),
                                child: GFProgressBar(
                                  percentage: percent,
                                  lineHeight: 10,
                                  alignment: MainAxisAlignment.spaceBetween,

                                  backgroundColor: Colors.black12,
                                  progressBarColor: Colors.orange,
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 15, 15),
                                    child: Text('${percent * 100}%',
                                        style: TextStyle(fontSize: 18))))
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          buildKey(icon: Icon(Icons.person), count: 12, title: "Personal",percent: 0.43, page: PersonalTodo(title: 'Personal')),
          buildKey(
              icon: Icon(Icons.business_center_rounded),
              count: 8,
              title: "Work",percent: 0.72,page: WorkTodo(title: 'Work')),

          buildKey(icon: Icon(Icons.house), count: 10, title: "Home",percent: 0.23,page: HomeTodo(title: 'Home'))
        ],
      ),
    );
  }
}
