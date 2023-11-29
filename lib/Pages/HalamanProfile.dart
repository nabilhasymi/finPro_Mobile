import 'package:ebook_shop/Pages/HalamanKonversiMataUang.dart';
import 'package:ebook_shop/Pages/HalamanRequestBuku.dart';
import 'package:ebook_shop/Pages/HalamanUtama.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanProfile extends StatefulWidget {
  const HalamanProfile({super.key});

  @override
  State<HalamanProfile> createState() => _HalamanProfileState();
}

class _HalamanProfileState extends State<HalamanProfile> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
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
          "PROFILE",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BebasNeue',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            profile(),
            CurrencyConverter(),
            //RiwayatTransaksi(),
            kesanPesan(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }
}

Container RiwayatTransaksi() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Riwayat Transaksi',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        // ListView dengan scroll horizontal untuk riwayat transaksi
        Container(
          height: 120.0, // Tinggi item transaksi
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10, // Jumlah transaksi
            itemBuilder: (BuildContext context, int index) {
              // Widget untuk menampilkan setiap item transaksi
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4, // memberikan efek shadow
                child: Container(
                  width: 120.0, // Lebar item transaksi
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Transaksi $index'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Container profile() {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black
              .withOpacity(0.4), // Warna bayangan (hitam dengan opasitas 40%)
          spreadRadius: 5, // Radius penyebaran bayangan
          blurRadius: 7, // Radius blur bayangan
          offset: Offset(0, 3), // Geser bayangan secara horizontal dan vertikal
        ),
      ],
      image: DecorationImage(
        image: AssetImage(
            'assets/Background.jpg'), // Ganti dengan path gambar Anda
        fit: BoxFit.cover, // Atur metode tata letak gambar
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            foregroundImage: AssetImage('assets/profile.jpeg'),
          ),
          SizedBox(height: 10.0),
          Text(
            'Nabil Makarim Hasymi',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BebasNeue',
              fontSize: 24.0,
            ),
          ),
          Text(
            '124210056',
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
  );
}

Container kesanPesan() {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //SizedBox(height: 10.0),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kesan',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'BebasNeue',
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Mata Kuliah Pemrograman Aplikasi Mobile terasa sangat menyenangkan dan menantang. \nSemoga ke depannya saya dapat menerapkan ilmu yang didapat dengan sebaik-baiknya.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesan',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'BebasNeue',
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Semoga Pak Bagus mendapat hidayah agar mau memberi nilai saya A',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

ClipRRect bottomNavBar(BuildContext context) {
  int _selectedIndex = 2;
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HalamanRequestBuku()),
          );
        } else if (index == 2) {}
      },
    ),
  );
}
