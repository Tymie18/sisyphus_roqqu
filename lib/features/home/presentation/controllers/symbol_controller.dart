import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/features/home/data/models/symbols_model.dart';
import 'package:sisyphus/features/home/presentation/controllers/chart_controller.dart';
import 'package:sisyphus/features/home/repositories/binance_repository.dart';

final symbolControllerProvider =
    NotifierProvider<SymbolController, List<Symbols>>(() {
  return SymbolController();
});

class SymbolController extends Notifier<List<Symbols>> {
  @override
  List<Symbols> build() {
    getSymbols();
    return [];
  }

  BinanceRepository get _binanceRepository =>
      ref.read(binanceRepositoryProvider);

  Future<void> getSymbols() async {
    try {
      final data = await _binanceRepository.fetchSymbols();

      ref.read(currentSymbolStateProvider.notifier).state = data[11];

      state = data;
    } catch (e) {
      state = [];
    }
  }
}
