/// System Trade types
/// 
/// 1. Buy
/// 2. Sell
/// 3. Transfer
/// 
/// Call list if you want to get all types in an array
abstract class TradeType {
  static const buy = 'buy';
  static const sell = 'sell';
  static const transfer = 'transfer';

  static const list = [buy, sell, transfer];
}
