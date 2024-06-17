import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sisyphus/features/home/data/models/symbols_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final binanceRepositoryProvider =
    Provider<BinanceRepository>((ref) => BinanceRepository());

class BinanceRepository {
  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    final uri = Uri.parse(
      'https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? '&endTime=$endTime' : ''}',
    );
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        // ignore: unnecessary_lambdas
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Future<List<Symbols>> fetchSymbols() async {
    final uri = Uri.parse('https://api.binance.com/api/v3/ticker/price');
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        // ignore: unnecessary_lambdas
        .map((e) => Symbols.fromJson(e))
        .toList();
  }

  WebSocketChannel establishConnection(String symbol, String interval) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@kline_$interval'],
          'id': 1,
        },
      ),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@depth'],
          'id': 1,
        },
      ),
    );

    return channel;
  }
}
