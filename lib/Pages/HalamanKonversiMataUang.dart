import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  late TextEditingController _controller;
  double _rupiahAmount = 0;
  double _dollarAmount = 0;
  double _euroAmount = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void convertCurrency(String value) {
    if (value.isEmpty) {
      setState(() {
        _rupiahAmount = 0;
        _dollarAmount = 0;
        _euroAmount = 0;
      });
      return;
    }

    double amount = double.tryParse(value) ?? 0;

    setState(() {
      _rupiahAmount = amount;
      _dollarAmount = amount * 0.000068; // 1 Rupiah = 0.000068 Dollar
      _euroAmount = amount * 0.000061; // 1 Rupiah = 0.000061 Euro
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter amount in Rupiah',
              border: OutlineInputBorder(),
            ),
            onChanged: convertCurrency,
          ),
          SizedBox(height: 20),
          Text('Converted Amounts:'),
          SizedBox(height: 10),
          Text('Dollar: \$ $_dollarAmount'),
          SizedBox(height: 10),
          Text('Euro: € $_euroAmount'),
        ],
      ),
    );
  }
}
