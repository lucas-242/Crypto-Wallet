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
      image:
          'https://metacore.mobula.io/60989b438a473ed77703f7bcd3530fc15542996a6607ae831de8c5e3e10f688d.png',
      color: Color(0xFF686f95),
    ),
    const Crypto(
      id: 'cardano',
      name: 'Cardano',
      symbol: 'ADA',
      image:
          'https://metacore.mobula.io/3edece3acc09847b89486012e1b54fad158cf45d75eeec66bfd1c33fe8965050.png',
      color: Color(0xFF26508C),
    ),
    const Crypto(
      id: 'binance_coin',
      name: 'Binance Coin',
      symbol: 'BNB',
      image:
          'https://metacore.mobula.io/4222eebc08140e722f50099fc8322b28e7c52e1abb92897e716cb2dc89598634.png',
      color: Color(0xFFF3BA2F),
    ),
    const Crypto(
      id: 'tether',
      name: 'Tether',
      symbol: 'USDT',
      image:
          'https://metacore.mobula.io/9372980b0ad7216a726ff3ec3b2e9337bd3fd49f5de696fd4c4e088f0f59fbee.png',
      color: Color(0xFF05AD85),
    ),
    const Crypto(
      id: 'ripple',
      name: 'Ripple',
      symbol: 'XRP',
      image:
          'https://metacore.mobula.io/2d88d2c33b0ed6b2d49cd7cd26572911ae1fbd68de20fb9895de3cc211e7cd85.png',
      color: Color(0xFF5B5F64),
    ),
    const Crypto(
      id: 'dogecoin',
      name: 'Dogecoin',
      symbol: 'DOGE',
      image:
          'https://metacore.mobula.io/f0fac619d2d330a339defff963909c348327463fd25f77c211f7fe812a03706f.png',
      color: Color(0xFFBB9F36),
    ),
    const Crypto(
      id: 'usd_coin',
      name: 'USD Coin',
      symbol: 'USDC',
      image:
          'https://metacore.mobula.io/9b4a08fadc7e3bed84e2eb662e097221da46ce2fedfc77f9fa8c1b3fa0c6cded.png',
      color: Color(0xFF2674C9),
    ),
    const Crypto(
      id: 'polkadot',
      name: 'Polkadot',
      symbol: 'DOT',
      image:
          'https://metacore.mobula.io/33f1cefc4284656ee1d3facf50a4dc1ecaa669bd07419225cae54b4da25b598c.png',
      color: Color(0xFF343335),
    ),
    const Crypto(
      id: 'solana',
      name: 'Solana',
      symbol: 'SOL',
      image:
          'https://metacore.mobula.io/f04676dc11ee766f3b78fb4f5f5b5cc3165e746f184ec259357033f9ff1ccd78.png',
      color: Color(0xFF8775DB),
    ),
    const Crypto(
      id: 'uniswap',
      name: 'Uniswap',
      symbol: 'UNI',
      image:
          'https://metacore.mobula.io/fa4fd40f963dc45a7bfeeb2ad01567abcd43159943b2493cc319ccee6f11582e.png',
      color: Color(0xFFFE1A87),
    ),
    const Crypto(
      id: 'bitcoin_cash',
      name: 'Bitcoin Cash',
      symbol: 'BCH',
      image:
          'https://metacore.mobula.io/ec37354815fce5f7ddf2d62c11859ae85c2b91bd8362a1141b867ce688353c03.png',
      color: Color(0xFF0AC18E),
    ),
    const Crypto(
      id: 'binance_usd',
      name: 'Binance USD',
      symbol: 'BUSD',
      image:
          'https://metacore.mobula.io/56e93eb2eb1f082fab53de6f20642c21467032ce91101d5db299b48f216059d5.png',
      color: Color(0xFFEDB70B),
    ),
    const Crypto(
      id: 'terra_luna_classic',
      name: 'Terra Luna Classic',
      symbol: 'LUNC',
      image:
          'https://metacore.mobula.io/bd0fbea32794b7cdda99542c69b1424d67e212ddcb205bb6d3763292d412111c.png',
      color: Color(0xFFFFD952),
    ),
    const Crypto(
      id: 'chainlink',
      name: 'Chainlink',
      symbol: 'LINK',
      image:
          'https://metacore.mobula.io/138cd2033b65a6188f68523963d4a371390bbbcce9f5662955f9f637b0104f1b.png',
      color: Color(0xFF2E52AF),
    ),
    const Crypto(
      id: 'litecoin',
      name: 'Litecoin',
      symbol: 'LTC',
      image:
          'https://metacore.mobula.io/7b0b448f120306782b58c56fde9f9acafd48d749b533517f81a1082727b4e132.png',
      color: Color(0xFF222222),
    ),
    const Crypto(
      id: 'internet_computer',
      name: 'internet_computer',
      symbol: 'ICP',
      image:
          'https://metacore.mobula.io/53d45742a955dceb332f41689de629f6563204f90397ab0e34223d76092d0240.png',
      color: Color(0xFF28A9E0),
    ),
    const Crypto(
      id: 'matic_network',
      name: 'Polygon',
      symbol: 'MATIC',
      image:
          'https://metacore.mobula.io/22884f2d889a75fd9715538bf8c4ffedfd91766e8b3a886128dd9495521deca7.png',
      color: Color(0xFF8247E5),
    ),
    const Crypto(
      id: 'wrapped_bitcoin',
      name: 'Wrapped Bitcoin',
      symbol: 'WBTC',
      image:
          'https://metacore.mobula.io/ab4b719b82cf9ac7ed1f4398cba30368d2e4f3445ffc7a0fa240a993393709c6.png',
      color: Color(0xFFF79319),
    ),
    const Crypto(
      id: 'vechain',
      name: 'VeChain',
      symbol: 'VET',
      image:
          'https://metacore.mobula.io/1223b69cd74652c04b072e75ddfbd17b05a014149382c734a1d712c9c1927601.png',
      color: Color(0xFF4284BC),
    ),
    const Crypto(
      id: 'stellar',
      name: 'Stellar',
      symbol: 'XLM',
      image:
          'https://metacore.mobula.io/37dce8296da025f87f4ba1b5974f444c641e7b4404218ba298c14d52eb76b3b3.png',
      color: Color(0xFF0F0F0F),
    ),
    const Crypto(
      id: 'theta_network',
      name: 'Theta Network',
      symbol: 'THETA',
      image:
          'https://metacore.mobula.io/514636d5a79212034ec78c19465355744584969f7eb03d0a0d6f1da9ab046f9c.png',
      color: Color(0xFFB1EBED),
    ),
    const Crypto(
      id: 'ethereum_classic',
      name: 'Ethereum Classic',
      symbol: 'ETC',
      image:
          'https://metacore.mobula.io/75e12ff3194a2ddada96ac3b746245ecb6d79b06f81cda8c7d022c9ad3c91e95.png',
      color: Color(0xFF168F1A),
    ),
    const Crypto(
      id: 'filecoin',
      name: 'Filecoin',
      symbol: 'FIL',
      image:
          'https://metacore.mobula.io/3a3680ab98644b6109ed8f299d7bec9afb6f20efb13fb0432f3c5f7a783de741.png',
      color: Color(0xFF0090FF),
    ),
    const Crypto(
      id: 'tron',
      name: 'Tron',
      symbol: 'TRX',
      image:
          'https://metacore.mobula.io/c9348545774454d2d1a3de623177c8fb2ade1d3ed8ac7f33b90d2477f22869b8.png',
      color: Color(0xFFC12F26),
    ),
    const Crypto(
      id: 'coti',
      name: 'Coti',
      symbol: 'COTI',
      image:
          'https://metacore.mobula.io/e3562fd0b101348a1362f59597ad39f2bf8bf18ae030f494b215f2b361e79759.png',
      color: Color(0xFF2D65B0),
    ),
    const Crypto(
      id: 'avalanche',
      name: 'Avalanche',
      symbol: 'AVAX',
      image:
          'https://metacore.mobula.io/a4706cd9b09a74be152a23424d0ecf9fa6a18180b8b4474a2d18e1328178f5d8.png',
      color: Color(0xFFE84142),
    ),
    const Crypto(
      id: 'cosmos',
      name: 'Cosmos Hub',
      symbol: 'ATOM',
      image:
          'https://metacore.mobula.io/7e53d95af605907a60bd107536bea4e29915f136d482420cd5a0d6ad02c79de7.png',
      color: Color(0xFF2B2E46),
    ),
    const Crypto(
      id: 'multiversx',
      name: 'MultiversX',
      symbol: 'EGLD',
      image:
          'https://metacore.mobula.io/7d9587fa358b707ec2bee24141d67588ec019654bf8778fc12061ccdc854df1c.png',
      color: Color(0xFF23F7DD),
    ),
  ];
}
