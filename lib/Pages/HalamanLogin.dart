//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:ebook_shop/Pages/HalamanUtama.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences logindata;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    checkedLogin();
  }

  void checkedLogin() async {
    logindata = await SharedPreferences.getInstance();
    newUser = (logindata.getBool('login') ?? true);
    print(newUser);
    if (newUser == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HalamanUtama();
      }));
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  String username = username_controller.text;
                  String password = password_controller.text;
                  if (username.isNotEmpty && password.isNotEmpty) {
                    if (username == "admin" && password == "admin") {
                      logindata.setBool("Login", false);
                      logindata.setString("username", username);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HalamanUtama()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Wrong Username or password.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    // Tampilkan pesan jika input kosong
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Username and password are required.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
