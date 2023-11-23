//import 'package:ebook_shop/Screen/HalamanUtama.dart';
import 'package:ebook_shop/Pages/HalamanListBuku.dart';
//import 'package:ebook_shop/Pages/HalamanPencarian.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageListBooks(),
    );
  }
}
