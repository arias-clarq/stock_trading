import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_trading/details.dart';

import 'model/StockTrading.dart';
import 'service/StockDataService.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        // Add more text styles if needed
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  ));
}

class Search extends StatefulWidget {
  final double buyingPower;
  final double accountBalance;

  Search({
    required this.buyingPower,
    required this.accountBalance
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _getCoinList = getCoinList();
  List<CoinList> _coinList = [];
  List<CoinList> _filteredList = [];

  _fetchCoinList() async {
    try {
      _coinList = await _getCoinList.getList();
      setState(() {
        _filteredList = List.from(_coinList);
      });
    } catch (e) {
      print(e);
    }
  }

  void _filterCoins(String query) {
    setState(() {
      _filteredList = _coinList
          .where((coin) => coin.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCoinList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232924),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Select Stock:',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: _filterCoins, // Call _filterCoins on text change
            ),
          ),
          Expanded(
            child: _filteredList.isEmpty
                ? Center(child: Text('No results found'))
                : ListView.builder(
              itemCount: _filteredList.length > 20 ? 20 : _filteredList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(coinId: _filteredList[index].coin_id, buyingPower: widget.buyingPower, accountBalance: widget.accountBalance,),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_filteredList[index].name.toUpperCase()),
                        Icon(Icons.chevron_right),
                      ],
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
}