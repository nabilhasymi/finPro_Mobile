import 'package:ebook_shop/Model/RequestBukuModel.dart';
import 'package:ebook_shop/Pages/HalamanProfile.dart';
import 'package:ebook_shop/Pages/HalamanUtama.dart';
import 'package:ebook_shop/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HalamanRequestBuku extends StatefulWidget {
  const HalamanRequestBuku({super.key});

  @override
  State<HalamanRequestBuku> createState() => _HalamanRequestBukuState();
}

class _HalamanRequestBukuState extends State<HalamanRequestBuku> {
  late Box<RequestBuku> _myBox;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 227, 206, 1.0),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Sesuaikan dengan keinginanmu
          ),
        ),
        backgroundColor: Color.fromRGBO(115, 144, 114, 1.0),
        title: Text(
          "REQUEST BUKU",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder(
        valueListenable: _myBox.listenable(),
        builder: (BuildContext context, value, Widget? child) {
          if (_myBox.values.isEmpty) {
            return Center(
              child: Text(
                "Request Kosong",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'BebasNeue',
                  fontSize: 28.0,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: _myBox.values.length,
            itemBuilder: (context, index) {
              RequestBuku? res = _myBox.getAt(index);
              return Card(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      _myBox.deleteAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red, // Warna latar belakang saat digeser
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      "Judul: ${res!.Title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Author: ${res.author}"),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return tambahBuku();
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(115, 144, 114, 1.0),
      ),
      bottomNavigationBar: bottomNavBar(context),
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
    super.initState();
    _myBox = Hive.box(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 227, 206, 1.0),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Sesuaikan dengan keinginanmu
          ),
        ),
        backgroundColor: Color.fromRGBO(115, 144, 114, 1.0),
        title: Text(
          "Request Buku",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Icon(Icons.book_outlined,
                  size: 150, color: Color.fromRGBO(115, 144, 114, 1.0)),
              SizedBox(height: 20),
              TextFormField(
                controller: _TitleController,
                decoration: InputDecoration(
                  labelText: "Judul",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _DescController,
                decoration: InputDecoration(
                  labelText: "Author",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _myBox.add(
                    RequestBuku(
                      Title: _TitleController.text,
                      author: _DescController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Submit"),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(115, 144, 114, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }
}

ClipRRect bottomNavBar(BuildContext context) {
  int _selectedIndex = 1;
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: BottomNavigationBar(
      backgroundColor: Color.fromRGBO(115, 144, 114, 1.0),
      selectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_add_outlined),
          label: 'Request',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (int index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HalamanUtama()),
          );
        } else if (index == 1) {
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HalamanProfile()),
          );
        }
      },
    ),
  );
}
