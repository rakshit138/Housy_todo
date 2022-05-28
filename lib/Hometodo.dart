import 'dart:ui';

import 'package:flutter/material.dart';
import 'notification_setting.dart';
import 'package:getwidget/getwidget.dart';

bool value = false;
int Homecount = 1;
int done = 0;
double res = 0;

class HomeTodo extends StatefulWidget {
  final String title;

  const HomeTodo({
    required this.title,
  });

  @override
  _HomeTodoState createState() => _HomeTodoState();
}

class _HomeTodoState extends State<HomeTodo> {
  bool value = false;
  int Homecount = 0;
  final HomeList = <ListModel>[];
  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() => HomeList.add(ListModel(title: task)));
      Homecount = HomeList.length;
    }
  }
  double Homepers = 0.0;
  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'New Task',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 15, 15, 15),
                child: Text(
                  'What Task are you planning to perform?',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextField(
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                autofocus: true,
                onSubmitted: (val) {
                  setState(() {
                    _addTodoItem(val);
                    Homepers = Homepers + 0.05;
                  });

                  Navigator.pop(context);
                },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 10, 10, 10)),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.business_center_outlined,color: Colors.grey,),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Work',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 18),
                        ))
                  ],
                ),
              ),
              Divider(thickness: 2,
                indent:30,
                endIndent: 30,),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Today',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 18),
                        ))
                  ],
                ),
              ),
              Divider(thickness: 2,
                indent:30,
                endIndent: 30,),
            ],
          ));
    }));
    Homecount = HomeList.length;
  }


  void _removeTodoItem(int index) {
    setState(() {
      HomeList.removeAt(index);
      Homecount = HomeList.length;
      done = done - 1;
      Homepers = Homepers - 0.05;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: _pushAddTodoScreen,
      child: const Icon(Icons.add),
      backgroundColor: Colors.blue.shade400,
    ),
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.grey),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
        )
      ],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade900,
            child: CircleAvatar(
                backgroundColor: Colors.white, child: Icon(Icons.house)),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${Homecount} Tasks',
                  style:
                  TextStyle(fontSize: 18, color: Colors.grey.shade700),
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 30),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ))),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 20, 20),
                child: GFProgressBar(
                  percentage: Homepers,
                  lineHeight: 4,
                  alignment: MainAxisAlignment.spaceBetween,
                  backgroundColor: Colors.black12,
                  progressBarColor: Colors.orange,
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Text('${(Homepers * 100).round()}%',
                        style: TextStyle(fontSize: 15))))
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              //  buildToggleCheckbox(allowNotifications),

              ...HomeList.map(buildSingleCheckbox).toList(),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildToggleCheckbox(ListModel notification) => buildCheckbox(
      notification: notification,
      onClicked: () {
        final newValue = !notification.value;

        setState(() {
          HomeList.forEach((notification) {
            notification.value = newValue;
            notification.visible = newValue;
          });
          Homepers = Homepers + 0.05;
        });
      });

  Widget buildSingleCheckbox(ListModel notification) => buildCheckbox(
    notification: notification,
    onClicked: () {
      print(done);
      print(Homecount);
      setState(() {
        final newValue = !notification.value;
        notification.value = newValue;
        notification.visible = newValue;

        if (!newValue) {
          done = done - 1;
        } else {
          done = done + 1;
          final allow =
          HomeList.every((notification) => notification.value);
          ;
        }
      });
    },
  );

  double Percent() {
    if (res < 0 || res > 1) {
      res = 0;
      return res;
    } else {
      res = done / Homecount;
      return 1 - res;
    }
  }

  Widget buildCheckbox({
    required ListModel notification,
    required VoidCallback onClicked,
    int index = 0,
  }) =>
      ListTile(
        trailing: Visibility(
            visible: notification.visible,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeTodoItem(index),
            )),
        onTap: onClicked,
        leading: Checkbox(
          value: notification.value,
          onChanged: (value) => onClicked(),
        ),
        title: _strikeThrough(
            todoToggle: notification.value, todoText: notification.title),
      );
}

class _strikeThrough extends StatelessWidget {
  bool todoToggle;
  String todoText;
  _strikeThrough({required this.todoToggle, required this.todoText}) : super();

  Widget _strikewidget() {
    if (todoToggle == false) {
      return Text(
        todoText,
        style: TextStyle(fontSize: 22.0),
      );
    } else {
      return Text(
        todoText,
        style: TextStyle(
            fontSize: 22.0,
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
            fontStyle: FontStyle.italic),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _strikewidget();
  }
}
