class StockData{
  List<Map<String, dynamic>> data = [];

  final String symbol;
  final String image;
  final String name;
  final double currentPrice;
  final int total_volume;
  final int? high_24;
  final int? low_24;

  StockData({
    required this.symbol,
    required this.image,
    required this.name,
    required this.currentPrice,
    required this.total_volume,
    required this.high_24,
    required this.low_24
  });

  factory StockData.fromJson(data){
    return StockData(
        symbol: data[0]['symbol'],
        image: data[0]['image'],
        name: data[0]['name'],
        currentPrice: data[0]['current_price'],
        total_volume: data[0]['total_volume'],
        high_24: data[0]['high_24'],
        low_24: data[0]['low_24']
    );
  }
}