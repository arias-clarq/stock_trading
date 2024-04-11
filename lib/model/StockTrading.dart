//this is for details for getting specific coins based on id
class CoinData{
  List<Map<String, dynamic>> data = [];

  final String symbol;
  final String image;
  final String name;
  final double currentPrice;
  final double price_change_24h;
  final int? total_volume;
  final double? high_24;
  final double? low_24;
  //add more field here if desired

  CoinData({
    required this.symbol,
    required this.image,
    required this.name,
    required this.price_change_24h,
    required this.currentPrice,
    required this.total_volume,
    required this.high_24,
    required this.low_24
  });

  factory CoinData.fromJson(data){
    return CoinData(
        symbol: data[0]['symbol'],
        image: data[0]['image'],
        name: data[0]['name'],
        price_change_24h: data[0]['price_change_24h'],
        currentPrice: data[0]['current_price'],
        total_volume: data[0]['total_volume'],
        high_24: data[0]['high_24'],
        low_24: data[0]['low_24']
    );
  }
}

//this for searchList
class CoinList {
  final String coin_id;
  final String name;
  final String symbol;

  CoinList({
    required this.coin_id,
    required this.name,
    required this.symbol
  });

  factory CoinList.fromJson(Map<String, dynamic> json) {
    return CoinList(
        coin_id: json['id'],
        name: json['name'],
        symbol: json['symbol']
    );
  }

  static List<CoinList> coinListFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => CoinList.fromJson(item)).toList();
  }
}

//this for chart
class CoinOHLC {
  int timestamp;
  double open;
  double high;
  double low;
  double close;

  CoinOHLC({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory CoinOHLC.fromJson(List<dynamic> jsonList) {
    return CoinOHLC(
      timestamp: jsonList[0] as int,
      open: (jsonList[1] as num).toDouble(),
      high: (jsonList[2] as num).toDouble(),
      low: (jsonList[3] as num).toDouble(),
      close: (jsonList[4] as num).toDouble(),
    );
  }

  static List<CoinOHLC> coinOHLCFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => CoinOHLC.fromJson(item)).toList();
  }
}