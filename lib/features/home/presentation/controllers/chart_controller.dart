// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:candlesticks/candlesticks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/features/home/data/DTOs/stream_value.dart';
import 'package:sisyphus/features/home/data/models/candle_ticker_model.dart';
import 'package:sisyphus/features/home/data/models/order_book_model.dart';
import 'package:sisyphus/features/home/data/models/symbols_model.dart';
import 'package:sisyphus/features/home/repositories/binance_repository.dart';

final currentSymbolStateProvider = StateProvider<Symbols?>((ref) {
  return null;
});

final candleTickerStateProvider = StateProvider<CandleTickerModel?>((ref) {
  return null;
});

final orderBookStateProvider = StateProvider<OrderBookModel?>((ref) {
  return null;
});

// MAIN CHART CONTROLLER WITH CANDLES

final chartControllerProvider =
    NotifierProvider<ChartController, List<Candle>>(() {
  return ChartController();
});

class ChartController extends Notifier<List<Candle>> {
  @override
  List<Candle> build() {
    return [];
  }

  BinanceRepository get _binanceRepository =>
      ref.read(binanceRepositoryProvider);

  Future<List<Candle>> getCandles(StreamValue streamValue) async {
    try {
      final data = await _binanceRepository.fetchCandles(
        symbol: streamValue.symbol.symbol!,
        interval: streamValue.interval!,
      );

      state = data;
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<void> loadMoreCandles(StreamValue streamValue) async {
    try {
      final data = await _binanceRepository.fetchCandles(
        symbol: streamValue.symbol.symbol!,
        interval: streamValue.interval!,
        endTime: state.last.date.millisecondsSinceEpoch,
      );

      state
        ..removeLast()
        ..addAll(data);
    } catch (e) {
      print(e);
    }
  }
}
