import 'dart:math';
import 'package:ebook_shop/Pages/HalamanJam.dart';
import 'package:ebook_shop/Pages/HalamanRequestBuku.dart';
import 'package:flutter/material.dart';
import 'package:ebook_shop/Model/recentBooksModel.dart';
import 'package:ebook_shop/Pages/HalamanDetailBuku.dart';
import 'package:ebook_shop/Pages/HalamanProfile.dart';
import 'package:ebook_shop/Pages/HalamanLogin.dart';
import 'package:ebook_shop/API_DATA_SRC.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  late SharedPreferences logindata;
  late String username;
  late String password;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
      password = logindata.getString('password')!;
    });
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
          "Welcome $username",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logindata.setBool("login", true);
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) {
                return HalamanLogin();
              }));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ClockPage(),
          //_searchField(),
          _buildListBooks(),
        ],
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(RecentBooksModel books) {
    return Column(
      children: [
        getRecentBooks(books),
        getTopChartsBooks(books),
        getFavoriteBooks(books),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _buildListBooks() {
    return Container(
      padding: EdgeInsets.only(left: 8),
      child: FutureBuilder(
        future: ApiDataSource.instance.recentBooks(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            RecentBooksModel recentBooksModel =
                RecentBooksModel.fromJson(snapshot.data);
            return _buildSuccessSection(recentBooksModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildItemBooks(Books booksData) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 200,
        height: 150,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBooks(booksData: booksData),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Text(
                    booksData.title!,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BebasNeue',
                      fontSize: 28.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                //decoration: BoxDecoration(color: Colors.grey),
                width: 150,
                height: 150,
                child: Image.network(booksData.image!),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Text(
                    booksData.authors!,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BebasNeue',
                      fontSize: 20.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRecentBooks(RecentBooksModel books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: Text(
            "Newest:",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BebasNeue',
              fontSize: 28.0,
            ),
          ),
        ),
        Container(
          height: 300,
          //color: Colors.blue,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.books!.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(width: 15),
            itemBuilder: (BuildContext context, int index) {
              return _buildItemBooks(books.books![index]);
            },
          ),
        ),
      ],
    );
  }

  getFavoriteBooks(RecentBooksModel books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            "Favorite:",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BebasNeue',
              fontSize: 28.0,
            ),
          ),
        ),
        Container(
          height: 300,
          //color: Colors.blue,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.books!.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(width: 15),
            itemBuilder: (BuildContext context, int index) {
              final reversedIndex = books.books!.length - 1 - index;
              return _buildItemBooks(books.books![reversedIndex]);
            },
          ),
        ),
      ],
    );
  }

  getTopChartsBooks(RecentBooksModel books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            "Top Chart:",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BebasNeue',
              fontSize: 28.0,
            ),
          ),
        ),
        Container(
          height: 300,
          //color: Colors.blue,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.books!.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(width: 15),
            itemBuilder: (BuildContext context, int index) {
              final randomIndex = Random().nextInt(books.books!.length);
              return _buildItemBooks(books.books![randomIndex]);
            },
          ),
        ),
      ],
    );
  }
}

Container _searchField() {
  void updateList() {
    //
  }

  final TextEditingController _searchController = TextEditingController();
  return Container(
    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        )
      ],
    ),
    child: TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(15),
        hintText: "Search",
        prefixIcon: Icon(Icons.search_outlined),
        //suffixIcon: Icon(Icons.filter_list),
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
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
