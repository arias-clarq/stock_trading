import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'model/StockTrading.dart';
import 'service/StockDataService.dart';
import 'package:intl/intl.dart  ';
import 'package:fl_chart/fl_chart.dart';
import 'dart:ui';

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

class Details extends StatefulWidget {
  final String coinId;
  double buyingPower;

  Details({
    required this.coinId,
    required this.buyingPower
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController priceController = TextEditingController(text: '190.00');

  final _stockDataService = getCoinData("CG-y7TNBhEA4Mx3TUJkXzT6caQH");
  CoinData? _stockData;
  double? previous_close;
  String? previous_close_string;
  String? current_price;

  String formatDoubleWithCommas(double value) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(value);
  }

  _fetchCoin(String coinId) async{
    try{
      final coinData = await _stockDataService.getCoin(coinId);
      setState(() {
        _stockData = coinData;
        previous_close = _stockData!.currentPrice - _stockData!.price_change_24h;
        previous_close_string = previous_close?.toStringAsFixed(2);
        current_price = formatDoubleWithCommas(_stockData!.currentPrice);
      });
    }catch(e){
      print(e);
    }
  }

  final _getCoinOHLCService = getCoinOHLCService();
  List<CoinOHLC> _coinOHLCList = [];
  _fetchCoinOHLC(String coin_id) async {
    try {
      final List<CoinOHLC> coinOHLC = await _getCoinOHLCService.getCoinOHLC(coin_id);
      setState(() {
        _coinOHLCList = coinOHLC;
      });
    } catch (e) {
      print(e);
      // Handle error
    }
  }

  final TextEditingController quantityBuy = TextEditingController();
  final TextEditingController quantitySell = TextEditingController();
  // Add your logic to buy coins
  void _buyCoins(String coinId, double price, int quantity) {
    // Calculate the total cost of buying the specified quantity of the coin
    double totalCost = price * quantity;

    // Check if the buying power is sufficient
    if (widget.buyingPower >= totalCost) {
      // Perform the purchase
      print('Buying $quantity coins of $coinId at $price per coin');

      // Subtract the total cost from buying power
      setState(() {
        widget.buyingPower -= totalCost;
        // Update user portfolio (e.g., adding the purchased coins)
        // This can be done using a portfolio service or updating the state
        // Example:
        // updateUserPortfolio(coinId, quantity, price);
      });

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully bought $quantity $coinId.'))
      );

    } else {
      // Not enough buying power
      print('Insufficient buying power');
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insufficient buying power to buy $quantity $coinId.'))
      );
    }
  }

  void _sellCoins(String coinId, double price, int quantity) {
    // Calculate the total revenue from selling the specified quantity of the coin
    double totalRevenue = price * quantity;

    // Perform the sale
    print('Selling $quantity coins of $coinId at $price per coin');

    // Add the total revenue to buying power
    setState(() {
      widget.buyingPower += totalRevenue;
      // Update user portfolio (e.g., removing the sold coins)
      // This can be done using a portfolio service or updating the state
      // Example:
      // updateUserPortfolioAfterSale(coinId, quantity);
    });

    // Display a success message
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully sold $quantity $coinId.'))
    );
  }


  @override
  void initState() {
    // _fetchCoinOHLC(widget.coinId);
    _fetchCoinOHLC(widget.coinId);
    _fetchCoin(widget.coinId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232924),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Set the background color to transparent
        elevation: 0,
        // Remove the shadow
        centerTitle: true,
        // Center the title
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: Colors.white,
          onPressed: () {
            // Add navigation logic here to go back
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Place Order',
          style: TextStyle(color: Colors.white), // Set the text color
        ),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _stockData?.symbol.toUpperCase() ?? '',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(_stockData?.name ?? ''),
                            ],
                          ),
                          Text(
                            '${previous_close_string ?? ''}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black54,
                      height: 300,
                      child: _coinOHLCList.isEmpty
                          ? Center(child: Text('No data available'))
                          : LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: _coinOHLCList.map((ohlc) {
                                return FlSpot(_coinOHLCList.indexOf(ohlc).toDouble(), ohlc.close);
                              }).toList(),
                              isCurved: true,
                              colors: [Colors.blue],
                              barWidth: 2,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                          minY: _coinOHLCList.map((ohlc) => ohlc.low).reduce((a, b) => a < b ? a : b),
                          maxY: _coinOHLCList.map((ohlc) => ohlc.high).reduce((a, b) => a > b ? a : b),
                          titlesData: FlTitlesData(
                            leftTitles: SideTitles(showTitles: true),
                            bottomTitles: SideTitles(showTitles: true),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: 'Buy'),
                          Tab(text: 'Sell'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Content for Buy Tab
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Price per Stock:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    current_price ?? '',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Quantity:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  TextFormField(
                                    controller: quantityBuy,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.green),
                                    decoration: InputDecoration(
                                      hintText: 'Enter quantity',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a quantity';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Buying Power:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    '${widget.buyingPower}',
                                    style: TextStyle(color: Colors.black54),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        int quantity = int.tryParse(quantityBuy.text) ?? 0;
                                        double price = _stockData?.currentPrice ?? 0;
                                        String coinId = widget.coinId;
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Confirm Buy'),
                                              content: Text('Are you sure you want to buy $quantity ${_stockData?.symbol.toUpperCase() ?? ''}?',style: TextStyle(color: Colors.black),),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    _buyCoins(coinId, price, quantity);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Buy'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Content for Sell Tab
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Price per Stock:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    current_price ?? '',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Quantity:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  TextFormField(
                                    controller: quantitySell,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.red),
                                    decoration: InputDecoration(
                                      hintText: 'Enter quantity',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a quantity';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text('Max:', style: TextStyle(color: Colors.black87)),
                                      SizedBox(width: 10), // Adjust the width as needed
                                      Text('3.00', style: TextStyle(color: Colors.black54)),
                                      SizedBox(width: 20), // Adjust the width as needed
                                      Text('Buying Power:', style: TextStyle(color: Colors.black87)),
                                      SizedBox(width: 10), // Adjust the width as needed
                                      Text('${widget.buyingPower}', style: TextStyle(color: Colors.black54)),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: double.maxFinite,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        int quantity = int.tryParse(quantitySell.text) ?? 0;
                                        double price = _stockData?.currentPrice ?? 0;
                                        String coinId = widget.coinId;

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Confirm Sell'),
                                              content: Text('Are you sure you want to sell $quantity ${_stockData?.symbol.toUpperCase() ?? ''}?',style: TextStyle(color: Colors.black),),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    _sellCoins(coinId,price,quantity);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Sell'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: Text(
                                        'Sell',
                                        style: TextStyle(fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
