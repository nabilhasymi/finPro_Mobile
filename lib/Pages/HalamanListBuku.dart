import 'package:ebook_shop/Model/recentBooksModel.dart';
import 'package:ebook_shop/Pages/HalamanDetailBuku.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ebook_shop/API_DATA_SRC.dart';

class PageListBooks extends StatefulWidget {
  const PageListBooks({super.key});

  @override
  State<PageListBooks> createState() => _PageListBooksState();
}

class _PageListBooksState extends State<PageListBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DAFTAR BUKU",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _searchField(),
          _buildListBooks(),
        ],
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  BottomNavigationBar bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => PageListBooks()),
          // );
        } else if (index == 1) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => recentBooks()),
          // );
        } else if (index == 2) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => recentBooks()),
          // );
        }
      },
    );
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

  Widget _buildListBooks() {
    return Container(
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

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(RecentBooksModel books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
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
          height: 350,
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
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.price_change_outlined,
                        ),
                        onPressed: () {
                          // Tambahkan aksi yang ingin dilakukan saat ikon "more" ditekan
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
