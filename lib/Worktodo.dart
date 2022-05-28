import 'dart:ui';

import 'package:flutter/material.dart';
import 'notification_setting.dart';
import 'package:getwidget/getwidget.dart';

bool value = false;
int Workcount = 1;
int done = 0;
double res = 0;

class WorkTodo extends StatefulWidget {
  final String title;

  const WorkTodo({
    required this.title,
  });

  @override
  _WorkTodoState createState() => _WorkTodoState();
}

class _WorkTodoState extends State<WorkTodo> {
  bool value = false;
  int Workcount = 0;
  final WorkList = <ListModel>[];
  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() => WorkList.add(ListModel(title: task)));
      Workcount = WorkList.length;
    }
  }
  double  Workpers = 0.0;

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
                    Workpers =  Workpers + 0.05;
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
    Workcount = WorkList.length;
  }


  void _removeTodoItem(int index) {
    setState(() {
      WorkList.removeAt(index);
      Workcount = WorkList.length;
      done = done - 1;
      Workpers = Workpers - 0.05;
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
                backgroundColor: Colors.white, child: Icon(Icons.business_center_rounded)),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${Workcount} Tasks',
                  style:
                  TextStyle(fontSize: 18, color: Colors.grey.shade700),
                ))),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 30),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Work',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ))),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 20, 20),
                child: GFProgressBar(
                  percentage: Workpers,
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
                    child: Text('${(Workpers* 100).round()}%',
                        style: TextStyle(fontSize: 15))))
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              //  buildToggleCheckbox(allowNotifications),

              ...WorkList.map(buildSingleCheckbox).toList(),
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
          WorkList.forEach((notification) {
            notification.value = newValue;
            notification.visible = newValue;
          });
          Workpers = Workpers + 0.05;
        });
      });

  Widget buildSingleCheckbox(ListModel notification) => buildCheckbox(
    notification: notification,
    onClicked: () {
      print(done);
      print(Workcount);
      setState(() {
        final newValue = !notification.value;
        notification.value = newValue;
        notification.visible = newValue;

        if (!newValue) {
          done = done - 1;
        } else {
          done = done + 1;
          final allow =
          WorkList.every((notification) => notification.value);
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
      res = done / Workcount;
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
