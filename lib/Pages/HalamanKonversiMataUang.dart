import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String _fromCurrency = 'IDR'; // Mata uang asal (Rupiah)
  String _toCurrency = 'USD'; // Mata uang yang dituju (Dollar)
  double _amount = 0;
  double _convertedAmount = 0;

  Map<String, double> _conversionRates = {
    'IDR': 1, // Nilai konversi Rupiah terhadap dirinya sendiri adalah 1
    'USD': 0.000070,
    'EUR': 0.000061,
  };

  void _convertCurrency() {
    setState(() {
      _convertedAmount = _amount *
          (_conversionRates[_toCurrency]! / _conversionRates[_fromCurrency]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna bayangan
            spreadRadius: 5, // Jarak penyebaran bayangan
            blurRadius: 7, // Tingkat kabur pada bayangan
            offset: Offset(0, 3), // Perpindahan bayangan dari kotak aslinya
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //SizedBox(height: 20),
          Text(
            'KONVERSI MATA UANG',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'BebasNeue',
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'cth: 10000',
            ),
            onChanged: (value) {
              setState(() {
                _amount = double.tryParse(value) ?? 0;
                _convertCurrency();
              });
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _fromCurrency,
                  items: _conversionRates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                      _convertCurrency();
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    var temp = _fromCurrency;
                    _fromCurrency = _toCurrency;
                    _toCurrency = temp;
                    _convertCurrency();
                  });
                },
                icon: Icon(Icons.swap_horiz),
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: _toCurrency,
                  items: _conversionRates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                      _convertCurrency();
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Jumlah Terkonversi:', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                _convertedAmount != 0
                    ? Text(
                        '${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
