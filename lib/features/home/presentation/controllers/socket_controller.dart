// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sisyphus/features/home/data/DTOs/stream_value.dart';
import 'package:sisyphus/features/home/data/models/candle_ticker_model.dart';
import 'package:sisyphus/features/home/data/models/order_book_model.dart';
import 'package:sisyphus/features/home/presentation/controllers/chart_controller.dart';
import 'package:sisyphus/features/home/repositories/binance_repository.dart';

final socketController = StreamProvider.family<CandleTickerModel, StreamValue?>(
    (ref, streamValue) async* {
  final binanceRepository = ref.read(binanceRepositoryProvider);

  final channel = binanceRepository.establishConnection(
    streamValue!.symbol.symbol!.toLowerCase(),
    streamValue.interval ?? '1h',
  );

  ref.onDispose(
    () {
      channel.sink.close();
    },
  );

  await for (final String value in channel.stream) {
    final map = jsonDecode(value) as Map<String, dynamic>;

    final candles = ref.read(chartControllerProvider);

    final eventType = map['e'];

    if (eventType == 'kline') {
      final candleTicker = CandleTickerModel.fromJson(map);

      ref.read(candleTickerStateProvider.notifier).state = candleTicker;

      if (candles[0].date == candleTicker.candle.date &&
          candles[0].open == candleTicker.candle.open) {
        candles[0] = candleTicker.candle;
      } else if (candleTicker.candle.date.difference(candles[0].date) ==
          candles[0].date.difference(candles[1].date)) {
        ref
            .read(chartControllerProvider.notifier)
            .state
            .insert(0, candleTicker.candle);
      }
    } else if (eventType == 'depthUpdate') {
      final orderBook = OrderBookModel.fromJson(map);

      ref.read(orderBookStateProvider.notifier).state = orderBook;
    }
  }
});
