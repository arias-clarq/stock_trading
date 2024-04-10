import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/StockTrading.dart';

class getCoinData{
  static const API_URL = "https://api.coingecko.com/api/v3/coins/markets";
  final String apiKey;

  getCoinData(this.apiKey);

  Future<CoinData> getCoin(String coinId) async{
    final response = await http.get(
      Uri.parse('$API_URL?vs_currency=php&ids=$coinId&price_change_percentage=1h&precision=2&x_cg_demo_api_key=$apiKey')
    );

    if(response.statusCode == 200){
        return CoinData.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load coin data');
    }
  }
}

class getCoinList{
  static const API_URL = "https://api.coingecko.com/api/v3/coins/list";

  Future<List<CoinList>> getList() async{
    final response = await http.get(
      Uri.parse(API_URL)
    );

    if(response.statusCode == 200){
      return CoinList.coinListFromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load CoinList data');
    }
  }
}

class getCoinOHLCService {
  static const API_URL = "https://api.coingecko.com/api/v3/coins";
  String days = '1';
  String precision = '2';

  Future<List<CoinOHLC>> getCoinOHLC(String coinId) async {
    final response = await http.get(Uri.parse('$API_URL/$coinId/ohlc?vs_currency=php&days=$days&precision=$precision'));

    if (response.statusCode == 200) {
      return CoinOHLC.coinOHLCFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load coin OHLC data');
    }
  }
}