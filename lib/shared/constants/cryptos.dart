abstract class Cryptos {
  static const btc = 'BTC';
  static const eth = 'ETH';
  static const ada = 'ADA';
  static const bnb = 'BNB';
  static const doge = 'DOGE';
  static const xrp = 'XRP';
  static const dot = 'DOT';
  static const sol = 'SOL';
  static const icp = 'ICP';
  static const uni = 'UNI';
  static const usdt = 'USDT';
  static const usdc = 'USDC';
  static const bch = 'BCH';
  static const busd = 'BUSD';
  static const luna = 'LUNA';
  static const link = 'LINK';
  static const ltc = 'LTC';
  static const matic = 'MATIC';
  static const wbtc = 'WBTC';
  static const vet = 'VET';
  static const xlm = 'XLM';
  static const theta = 'THETA';
  static const etc = 'ETC';
  static const fil = 'FIL';
  static const trx = 'TRX';
  static const dai = 'DAI';
  static const avax = 'AVAX';
  static const aave = 'AAVE';
  static const ftt = 'FTT';
  static const atom = 'ATOM';
  static const ceth = 'CETH';
  static const grt = 'GRT';
  static const eos = 'EOS';
  static const cusdc = 'CUSDC';
  static const xmr = 'XMR';
  static const cake = 'CAKE';
  static const klay = 'KLAY';
  static const cdai = 'CDAI';
  static const shib = 'SHIB';
  static const axs = 'AXS';
  static const neo = 'NEO';
  static const cro = 'CRO';
  static const algo = 'ALGO';
  static const mkr = 'MKR';
  static const xtz = 'XTZ';
  static const bsv = 'BSV';
  static const ksm = 'KSM';
  static const miota = 'MIOTA';
  static const amp = 'AMP';
  static const btt = 'BTT';
  static const leo = 'LEO';
  static const rvn = 'RVN';
  static const nano = 'NANO';
  static const erg = 'ERG';
  static const slp = 'SLP';
  static const coti = 'COTI';

  static const List<String> list = [
    btc,
    ada,
    eth,
    doge,
    xrp,
    bnb,
    dot,
    sol,
    icp,
    uni,
    usdt,
    usdc,
    bch,
    busd,
    luna,
    link,
    ltc,
    matic,
    wbtc,
    vet,
    xlm,
    theta,
    etc,
    fil,
    trx,
    dai,
    avax,
    aave,
    ftt,
    atom,
    ceth,
    grt,
    eos,
    cusdc,
    xmr,
    cake,
    klay,
    cdai,
    shib,
    axs,
    neo,
    cro,
    algo,
    mkr,
    xtz,
    bsv,
    ksm,
    miota,
    amp,
    btt,
    leo,
    rvn,
    nano,
    erg,
    slp,
    coti,
  ];

  static const Map<String, String> apiIds = {
    btc: 'bitcoin',
    ada: 'cardano',
    eth: 'ethereum',
    doge: 'dogecoin',
    xrp: 'ripple',
    bnb: 'binancecoin',
    dot: 'polkadot',
    sol: 'solana',
    icp: 'internet-computer',
    uni: 'uniswap',
    usdt: 'tether',
    usdc: 'usd-coin',
    bch: 'bitcoin-cash',
    busd: 'binance-usd',
    luna: 'terra-luna',
    link: 'chainlink',
    ltc: 'litecoin',
    matic: 'matic-network',
    wbtc: 'wrapped-bitcoin',
    vet: 'vechain',
    xlm: 'stellar',
    theta: 'theta-token',
    etc: 'ethereum-classic',
    fil: 'filecoin',
    trx: 'tron',
    dai: 'dai',
    avax: 'avalanche-2',
    aave: 'aave',
    ftt: 'ftx-token',
    atom: 'cosmos',
    ceth: 'compound-ether',
    grt: 'the-graph',
    eos: 'eos',
    cusdc: 'compound-usd-coin',
    xmr: 'monero',
    cake: 'pancakeswap-token',
    klay: 'klay-token',
    cdai: 'cdai',
    shib: 'shiba-inu',
    axs: 'axie-infinity',
    neo: 'neo',
    cro: 'crypto-com-chain',
    algo: 'algorand',
    mkr: 'maker',
    xtz: 'tezos',
    bsv: 'bitcoin-cash-sv',
    ksm: 'kusama',
    miota: 'iota',
    amp: 'amp-token',
    btt: 'bittorrent-2',
    leo: 'leo-token',
    rvn: 'ravencoin',
    nano: 'nano',
    erg: 'ergo',
    slp: 'smooth-love-potion',
    coti: 'coti',
  };

  static const Map<String, String> names = {
    btc: 'Bitcoin',
    ada: 'Cardano',
    eth: 'Ethereum',
    doge: 'Dogecoin',
    xrp: 'Ripple',
    bnb: 'Binancecoin',
    dot: 'Polkadot',
    sol: 'Solana',
    icp: 'Internet Computer',
    uni: 'Uniswap',
    usdt: 'Tether',
    usdc: 'Usd coin',
    bch: 'Bitcoin Cash',
    busd: 'Binance Usd',
    luna: 'Terra Luna',
    link: 'Chainlink',
    ltc: 'Litecoin',
    matic: 'Matic Network',
    wbtc: 'Wrapped Bitcoin',
    vet: 'Vechain',
    xlm: 'Stellar',
    theta: 'Theta Token',
    etc: 'Ethereum Classic',
    fil: 'Filecoin',
    trx: 'Tron',
    dai: 'Dai',
    avax: 'Avalanche',
    aave: 'Aave',
    ftt: 'FTX Token',
    atom: 'Cosmos',
    ceth: 'Compound Ether',
    grt: 'The Graph',
    eos: 'EOS',
    cusdc: 'cUSDC',
    xmr: 'Monero',
    cake: 'Pancakeswap Token',
    klay: 'Klay Token',
    cdai: 'cDAI',
    shib: 'Shiba Inu',
    axs: 'Axie Infinity',
    neo: 'NEO',
    cro: 'Crypto.com Coin',
    algo: 'Algorand',
    mkr: 'Maker',
    xtz: 'Tezos',
    bsv: 'Bitcoin SV',
    ksm: 'Kusama',
    miota: 'Iota',
    amp: 'Amp Token',
    btt: 'Bittorrent',
    leo: 'Leo Token',
    rvn: 'Ravencoin',
    nano: 'Nano',
    erg: 'Ergo',
    slp: 'Smooth Love Potion',
    coti: 'Coti',
  };

  static const colors = {
    btc: 0xFFF79319,
    eth: 0xFF686f95,
    ada: 0xFF26508C,
    bnb: 0xFFF3BA2F,
    usdt: 0xFF05AD85,
    xrp: 0xFF5B5F64,
    doge: 0xFFBB9F36,
    usdc: 0xFF2674C9,
    dot: 0xFF343335,
    sol: 0xFF8775DB,
    uni: 0xFFFE1A87,
    bch: 0xFF0AC18E,
    busd: 0xFFEDB70B,
    luna: 0xFFFFD952,
    link: 0xFF2E52AF,
    ltc: 0xFF222222,
    icp: 0xFF28A9E0,
    matic: 0xFF8247E5,
    wbtc: 0xFFF79319,
    vet: 0xFF4284BC,
    xlm: 0xFF0F0F0F,
    theta: 0xFFB1EBED,
    etc: 0xFF168F1A,
    fil: 0xFF0090FF,
    trx: 0xFFC12F26,
    coti: 0xFF2D65B0,
  };
}
