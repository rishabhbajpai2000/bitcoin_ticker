import 'dart:convert';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;




class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  // functions definition
  Future<double> networkCall(
      String nameOfCrypto, String nameOfNationalCurrency) async {
    final response = await http.get(
      Uri.parse(
          'https://apiv2.bitcoinaverage.com/indices/global/ticker/$nameOfCrypto$nameOfNationalCurrency'),
      // Send authorization headers to the backend.
      headers: {'x-ba-key': 'ZTA1Y2QwYjliMmYzNGM5Yjg4ZTNjMTcxZTU0YWJlOTE'},
    );
    if (response.statusCode == 200) {
      // print(response.body);
      print("$nameOfCrypto " +
          jsonDecode(response.body)["last"].toString() +
          " $nameOfNationalCurrency");
      return jsonDecode(response.body)["last"];
    } else {
      print(response.body);
    }
  }


  
  List<DropdownMenuItem<String>> getAllCurrencies() {
    List<DropdownMenuItem<String>> answers = [];
    for (int i = 0; i < currenciesList.length; i++) {
      answers.add(DropdownMenuItem(
          child: Text(currenciesList[i]), value: currenciesList[i]));
    }
    return answers;
  }

  void updatePrice(String kSelectedCurrency) async {
    kBTCPrice = await networkCall("BTC", kSelectedCurrency);
    kETHPrice = await networkCall("ETH", kSelectedCurrency);
    kLTCPrice = await networkCall("LTC", kSelectedCurrency);
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      updatePrice(kSelectedCurrency);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC =  $kBTCPrice $kSelectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $kETHPrice $kSelectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $kLTCPrice $kSelectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: kSelectedCurrency,
              items: getAllCurrencies(),
              onChanged: (value) {
                setState(()  {
                  kSelectedCurrency = value;
                   updatePrice(kSelectedCurrency);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
