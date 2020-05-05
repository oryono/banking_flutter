import 'package:flutter_money_formatter/flutter_money_formatter.dart';

money(double amount) {
  FlutterMoneyFormatter fmt = FlutterMoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
        symbol: 'UGX',
        thousandSeparator: ',',
        decimalSeparator: '.',
      ));

  return fmt.output.symbolOnLeft.toString();
}
