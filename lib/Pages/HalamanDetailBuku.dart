import 'package:ebook_shop/Model/recentBooksModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBooks extends StatelessWidget {
  final Books booksData;
  const DetailBooks({Key? key, required this.booksData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(booksData.title! + " Detail"),
      ),
      body: _buildArticleDetail(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          launchUrl(Uri.parse(
            booksData.url ?? '',
          ));
          // Aksi ketika FAB ditekan
        },
        icon: Icon(Icons.link),
        label: Text('See More...'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildArticleDetail() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            booksData.image!, // Assuming imageUrl exists in the article data
            height: 200, // Set height as needed
            width: double.infinity, // Take full width
            fit: BoxFit.fitHeight, // Adjust the image to cover the space
          ),
          SizedBox(height: 20),
          Text(
            booksData.title!, // Assuming title exists in the article data
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          Text(
            booksData.subtitle ??
                '', // Assuming description exists in the article data
            style: TextStyle(fontSize: 16),
          ),
          // Add other details about the article as needed
        ],
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
