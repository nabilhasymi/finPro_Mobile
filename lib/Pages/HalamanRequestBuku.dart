import 'package:ebook_shop/Model/RequestBukuModel.dart';

import 'package:ebook_shop/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

//import 'package:hive_project/main.dart';

class HalamanRequestBuku extends StatefulWidget {
  const HalamanRequestBuku({super.key});

  @override
  State<HalamanRequestBuku> createState() => _HalamanRequestBukuState();
}

class _HalamanRequestBukuState extends State<HalamanRequestBuku> {
  late Box<RequestBuku> _myBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myBox = Hive.box(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REQUEST BUKU"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: _myBox.listenable(),
        builder: (BuildContext, value, child) {
          if (_myBox.values.isEmpty) {
            return Center(
              child: Text("File Empty"),
            );
          }
          return ListView.builder(
              itemCount: _myBox.values.length,
              itemBuilder: (context, index) {
                RequestBuku? res = _myBox.getAt(index);
                return Dismissible(
                    onDismissed: (direction) {
                      _myBox.deleteAt(index);
                    },
                    key: UniqueKey(),
                    child: ListTile(
                      title: Text("Judul: ${res!.Title}", style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text("Author: ${res.author}"),
                    ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return tambahBuku();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class tambahBuku extends StatefulWidget {
  const tambahBuku({super.key});

  @override
  State<tambahBuku> createState() => _tambahBukuState();
}

class _tambahBukuState extends State<tambahBuku> {
  final TextEditingController _TitleController = TextEditingController();
  final TextEditingController _DescController = TextEditingController();

  late Box<RequestBuku> _myBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myBox = Hive.box(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Buku"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _TitleController,
              decoration: InputDecoration(label: Text("Judul")),
            ),
            TextFormField(
              controller: _DescController,
              decoration: InputDecoration(label: Text("Author")),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
              onPressed: () {
                _myBox.add(
                  RequestBuku(
                    Title: _TitleController.text,
                    author: _DescController.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
