import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_trading/search.dart';
import 'package:intl/intl.dart  ';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(accountBalance: null),
    theme: ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),

      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  late final accountBalance;
  MyApp({ required this.accountBalance});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  {
  late double accountBalance;

  void updateAccount(){
    setState(() {
      accountBalance = 10000.0;
    });
  }

  double margin = 2.0; // Example margin factor (e.g., 2x leverage)
  double marginRequirement = 0.5; // Example margin requirement (e.g., 50%)
  late double buyingPower; // Declare buyingPower as a late variable
  late String buyingPowerString;
  late String accountBalanceString;

  String formatDoubleWithCommas(double value) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(value);
  }

  @override
  void initState() {
    super.initState();
    // Calculate buying power
    updateAccount();
    buyingPower = accountBalance * margin * (1.0 - marginRequirement);
    buyingPowerString = formatDoubleWithCommas(buyingPower);
    accountBalanceString = formatDoubleWithCommas(accountBalance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('../assets/img/Welcome.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(30),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('../assets/img/jdc.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello!',
                                  ),
                                  Text(
                                    'Juan Dela Cruz',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Search(buyingPower: buyingPower, accountBalance: accountBalance,)),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.only(right: 7),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF313B33),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.search,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF313B33),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.settings,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current Balance',
                          ),
                          Text(
                            '₱'+'$accountBalanceString',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Buying Power',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '₱'+'$buyingPowerString',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Today\'s Change',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '₱'+'124.80',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 9, top: 15),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Stock Assets',
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 20),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Search(buyingPower: buyingPower, accountBalance: accountBalance,)),
                                          );
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          margin: EdgeInsets.only(right: 7),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF313B33),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text('Name'),
                                ],
                              ),
                            ), //Stock assets header
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              margin: EdgeInsets.only(bottom: 9, top: 5),
                              child: Row(

                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('TSLA'),
                                      Text(
                                        '10 Shares',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white24),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ), //stock item

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 9),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Transaction History',
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 20),
                                  ),
                                ],
                              ),
                            ), //Stock assets header
                            Divider(
                              thickness: 1,
                              color: Color(0xFF313B33),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Buy',
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text('3.00'),
                                        SizedBox(width: 5),
                                        Text('USD'),
                                      ],
                                    ),
                                    Text(
                                      'Apr 02, 2024 20:50',
                                      style: TextStyle(
                                          color: Colors.white38, fontSize: 10),
                                    ),
                                  ],
                                ),
                                Text('-290.28'),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFF313B33),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Buy',
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text('3.00'),
                                        SizedBox(width: 5),
                                        Text('USD'),
                                      ],
                                    ),
                                    Text(
                                      'Apr 02, 2024 20:50',
                                      style: TextStyle(
                                          color: Colors.white38, fontSize: 10),
                                    ),
                                  ],
                                ),
                                Text('-290.28'),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFF313B33),
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