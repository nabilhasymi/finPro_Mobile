//import 'package:url_launcher/link.dart';
import 'dart:async';
import 'package:ebook_shop/Model/recentBooksModel.dart';
import 'package:ebook_shop/Pages/HalamanProfile.dart';
import 'package:ebook_shop/Pages/HalamanRequestBuku.dart';
import 'package:ebook_shop/Pages/HalamanUtama.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBooks extends StatelessWidget {
  //final DetailedBooksModel booksData;
  final Books booksData;
  const DetailBooks({Key? key, required this.booksData}) : super(key: key);

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
        title: Text(booksData.title! + " Detail"),
      ),
      body: _buildBookDetail(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchURL(booksData.url!);
        },
        icon: Icon(Icons.link),
        backgroundColor: Color.fromRGBO(115, 144, 114, 1.0),
        label: Text('See More...'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  Widget _buildBookDetail() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            booksData.image!, // Assuming imageUrl exists in the book data
            height: 200, // Set height as needed
            width: double.infinity, // Take full width
            fit: BoxFit.fitHeight, // Adjust the image to cover the space
          ),
          SizedBox(height: 20),
          Text(
            booksData.title!, // Assuming title exists in the book data
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Table(
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ID',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        booksData.id.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sub Title',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        booksData.subtitle!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Penulis',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        booksData.authors ?? "N/A",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

ClipRRect bottomNavBar(BuildContext context) {
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
      onTap: (int index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HalamanUtama()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HalamanRequestBuku()),
          );
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

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
