import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_trading/details.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Search(),
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

class Search extends StatelessWidget {
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
          'Select Stock:',
          style: TextStyle(color: Colors.white), // Set the text color
        ),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
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
                ),
              ),
              SizedBox(
                height: 5,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // ITEM1
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('USD'),
                            Icon(
                              Icons.chevron_right,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Color(0xFF313B33),
                    ),
                    //   item2
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TSLA'),
                            Icon(
                              Icons.chevron_right,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Color(0xFF313B33),
                    ),
                    //   item3
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('AAPL'),
                            Icon(
                              Icons.chevron_right,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Color(0xFF313B33),
                    ),
                    //   item4
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('LLC'),
                            Icon(
                              Icons.chevron_right,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Color(0xFF313B33),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
