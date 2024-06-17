import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisyphus/shared/utils/utils.dart';

// ignore: avoid_positional_boolean_parameters
typedef BoolCallback = void Function(bool);

final currencyFormat = NumberFormat(
  '#,##0',
  'en_US',
);
final valueFormat = NumberFormat(
  '#,##0.00',
  'en_US',
);

extension ThemeExtension on BuildContext? {
  bool isDarkMode() {
    final brightness = Theme.of(this!).brightness;
    return brightness == Brightness.dark;
  }
}

extension DoubleExtension on double? {
  String formatValue() {
    return this == null ? '-' : (currencyFormat.format(this));
  }

  String formatValue2() {
    return this == null ? '-' : (valueFormat.format(this));
  }
}
