import 'dart:ui';

import 'package:crypto_wallet/domain/models/crypto.dart';

abstract class Cryptos {
  static final supported = <Crypto>[
    const Crypto(
      id: 'bitcoin',
      name: 'Bitcoin',
      symbol: 'BTC',
      image:
          'https://metacore.mobula.io/ea67a92c8e0a9b951d6fafed56e8ee714180e9ccbadb7d0555b9cb1b1224dba7.png',
      color: Color(0xFFF79319),
    ),
    const Crypto(
      id: 'ethereum',
      name: 'Ethereum',
      symbol: 'ETH',
      color: Color(0xFF686f95),
    ),
    const Crypto(
      id: 'cardano',
      name: 'Cardano',
      symbol: 'ADA',
      color: Color(0xFF26508C),
    ),
    const Crypto(
      id: 'binance_coin',
      name: 'Binance Coin',
      symbol: 'BNB',
      color: Color(0xFFF3BA2F),
    ),
    const Crypto(
      id: 'tether',
      name: 'Tether',
      symbol: 'USDT',
      color: Color(0xFF05AD85),
    ),
    const Crypto(
      id: 'ripple',
      name: 'Ripple',
      symbol: 'XRP',
      color: Color(0xFF5B5F64),
    ),
    const Crypto(
      id: 'dogecoin',
      name: 'Dogecoin',
      symbol: 'DOGE',
      color: Color(0xFFBB9F36),
    ),
    const Crypto(
      id: 'usd_coin',
      name: 'USD Coin',
      symbol: 'USDC',
      color: Color(0xFF2674C9),
    ),
    const Crypto(
      id: 'polkadot',
      name: 'Polkadot',
      symbol: 'DOT',
      color: Color(0xFF343335),
    ),
    const Crypto(
      id: 'solana',
      name: 'Solana',
      symbol: 'SOL',
      color: Color(0xFF8775DB),
    ),
    const Crypto(
      id: 'uniswap',
      name: 'Uniswap',
      symbol: 'UNI',
      color: Color(0xFFFE1A87),
    ),
    const Crypto(
      id: 'bitcoin_cash',
      name: 'Bitcoin Cash',
      symbol: 'BCH',
      color: Color(0xFF0AC18E),
    ),
    const Crypto(
      id: 'binance_usd',
      name: 'Binance USD',
      symbol: 'BUSD',
      color: Color(0xFFEDB70B),
    ),
    const Crypto(
      id: 'terra_luna',
      name: 'Terra',
      symbol: 'LUNA',
      color: Color(0xFFFFD952),
    ),
    const Crypto(
      id: 'chainlink',
      name: 'Chainlink',
      symbol: 'LINK',
      color: Color(0xFF2E52AF),
    ),
    const Crypto(
      id: 'litecoin',
      name: 'Litecoin',
      symbol: 'LTC',
      color: Color(0xFF222222),
    ),
    const Crypto(
      id: 'internet_computer',
      name: 'internet_computer',
      symbol: 'ICP',
      color: Color(0xFF28A9E0),
    ),
    const Crypto(
      id: 'matic_network',
      name: 'Polygon',
      symbol: 'MATIC',
      color: Color(0xFF8247E5),
    ),
    const Crypto(
      id: 'wrapped_bitcoin',
      name: 'Wrapped Bitcoin',
      symbol: 'WBTC',
      color: Color(0xFFF79319),
    ),
    const Crypto(
      id: 'vechain',
      name: 'VeChain',
      symbol: 'VET',
      color: Color(0xFF4284BC),
    ),
    const Crypto(
      id: 'stellar',
      name: 'Stellar',
      symbol: 'XLM',
      color: Color(0xFF0F0F0F),
    ),
    const Crypto(
      id: 'theta_network',
      name: 'Theta Network',
      symbol: 'THETA',
      color: Color(0xFFB1EBED),
    ),
    const Crypto(
      id: 'ethereum_classic',
      name: 'Ethereum Classic',
      symbol: 'ETC',
      color: Color(0xFF168F1A),
    ),
    const Crypto(
      id: 'filecoin',
      name: 'Filecoin',
      symbol: 'FIL',
      color: Color(0xFF0090FF),
    ),
    const Crypto(
      id: 'tron',
      name: 'Tron',
      symbol: 'TRX',
      color: Color(0xFFC12F26),
    ),
    const Crypto(
      id: 'coti',
      name: 'Coti',
      symbol: 'COTI',
      color: Color(0xFF2D65B0),
    ),
    const Crypto(
      id: 'avalanche',
      name: 'Avalanche',
      symbol: 'AVAX',
      color: Color(0xFFE84142),
    ),
    const Crypto(
      id: 'cosmos',
      name: 'Cosmos Hub',
      symbol: 'ATOM',
      color: Color(0xFF2B2E46),
    ),
    const Crypto(
      id: 'multiversx',
      name: 'MultiversX',
      symbol: 'EGLD',
      color: Color(0xFF23F7DD),
    ),
  ];
}
