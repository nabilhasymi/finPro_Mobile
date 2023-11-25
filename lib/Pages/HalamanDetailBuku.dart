import 'package:ebook_shop/Model/DetailedBooksModel.dart';
import 'package:ebook_shop/Model/recentBooksModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBooks extends StatelessWidget {
  //final DetailedBooksModel booksData;
  final Books booksData;
  const DetailBooks({Key? key, required this.booksData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(booksData.title! + " Detail"),
      ),
      body: _buildBookDetail(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchURL(booksData.url!);
        },
        icon: Icon(Icons.link),
        label: Text('See More...'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          Text(
            'SubTitle: ${booksData.subtitle}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Penulis: ${booksData.authors}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Deskripsi: ',
            style: TextStyle(fontSize: 16),
          ),
          // Other book details can be added here
        ],
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
}
