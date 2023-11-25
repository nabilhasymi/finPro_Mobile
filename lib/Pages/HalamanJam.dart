import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late Timer _timer;
  late DateFormat _format;
  late String _time = '';
  late String WIB = '';
  late String WITA = '';
  late String WIT = '';
  late String London = '';

  @override
  void initState() {
    super.initState();
    _format = DateFormat.jm();

    _updateTime(); // Call the function once to initialize
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      DateTime now = DateTime.now();
      _time = _format.format(now);

      WIB = _format.format(
          DateTime.now().toUtc().add(Duration(hours: 7))); // WIB is UTC+7
      WITA = _format.format(
          DateTime.now().toUtc().add(Duration(hours: 8))); // WITA is UTC+9
      WIT = _format.format(
          DateTime.now().toUtc().add(Duration(hours: 9))); // WIT is UTC+0
      London = _format.format(
          DateTime.now().toUtc().add(Duration(hours: 0))); // London is UTC+0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pin_drop_outlined),
                          Text(
                            'Local Time:',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Text(
                        _time,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.globe,
                              size: 15,
                            ),
                            Text(
                              ' WIB Time',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          WIB,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.globe,
                              size: 15,
                            ),
                            Text(
                              ' WITA Time',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          WITA,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //SizedBox(width: 4),
              Expanded(
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.globe,
                              size: 15,
                            ),
                            Text(
                              ' WITA Time',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          WIT,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.globe,
                        size: 15,
                      ),
                      Text(
                        ' London Time:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    London,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
