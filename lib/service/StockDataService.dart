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
      throw Exception('Failed to load data');
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
      throw Exception('Failed to load data');
    }
  }
}