import 'package:ebook_shop/Pages/HalamanProfile.dart';
import 'package:ebook_shop/Pages/HalamanUtama.dart';
import 'package:flutter/material.dart';
import 'package:ebook_shop/Model/recentBooksModel.dart';
//import '../Model/recentBooksModel.dart';

class HalamanCart extends StatefulWidget {
  final Books booksData;
  //final String bookTitle;

  const HalamanCart({Key? key, required this.booksData}) : super(key: key);

  @override
  State<HalamanCart> createState() => _HalamanCartState();
}

class _HalamanCartState extends State<HalamanCart> {
  int _selectedIndex = 1;
  List<int> cartItems = [
    1,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang Belanja',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        //automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors
                    .transparent, // Jika ingin menghilangkan warna latar belakang bawaan dari CircleAvatar
                radius: 30, // Sesuaikan dengan ukuran yang diinginkan
                child: ClipPath(
                  child: Image.network(
                    widget.booksData.image!,
                    fit: BoxFit
                        .fitHeight, // Sesuaikan dengan kebutuhan: cover, contain, dll.
                    height: 60, // Sesuaikan dengan tinggi yang diinginkan
                    width: 60, // Sesuaikan dengan lebar yang diinginkan
                  ),
                ),
              ),
              title: Text(
                widget.booksData.title! + ' (${cartItems[index]})',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Harga: \$XX'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (cartItems[index] > 1) {
                          cartItems[
                              index]--; // Kurangi jumlah item jika lebih dari 1
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cartItems[index]++; // Tambah jumlah item
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        cartItems.removeAt(index); // Hapus item
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      //bottomNavigationBar: bottomNavBar(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          checkout(); // Panggil fungsi checkout ketika tombol ditekan
        },
        label: Text('Checkout'),
        icon: Icon(Icons.shopping_cart),
      ),
    );
  }

  void checkout() {
    // Lakukan proses checkout di sini, misalnya proses pembayaran, pengiriman, dll.
    //double totalPrice = calculateTotalPrice();
    // Misalnya, tampilkan total harga atau lakukan tindakan lain terkait checkout
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Total Harga: '),
          content: Text('Proses pembayaran dan pengiriman dilakukan di sini.'),
          actions: [
            TextButton(
              onPressed: () {
                // Lakukan tindakan setelah checkout (jika diperlukan)
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // ... Fungsi checkout dan bottomNavBar tidak berubah
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
    );
  }
}
