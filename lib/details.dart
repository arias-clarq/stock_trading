import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Details(),
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

class Details extends StatelessWidget {
  final TextEditingController priceController =
      TextEditingController(text: '190.00');

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
                                'AAPL',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('Apple Inc'),
                            ],
                          ),
                          Text(
                            '168.54',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black54,
                      height: 200,

                      //   ------------ graph here ------------
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
                            // Content for Tab 1
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
                                    '168.54',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Quantity:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter quantity',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Buying Power:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    '8,000,000.00',
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
                                        // Add your button onPressed logic here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green, // Button background color
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
                            // Content for Tab 2
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
                                    '168.54',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Quantity:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter quantity',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Max:',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    '3.00',
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
                                        // Add your button onPressed logic here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red, // Button background color
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
