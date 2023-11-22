//import 'package:ebook_shop/Screen/HalamanUtama.dart';
import 'package:ebook_shop/Pages/HalamanListBuku.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageListBooks(),
    );
  }
}
