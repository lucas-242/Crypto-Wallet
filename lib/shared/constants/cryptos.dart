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
  static const near = 'NEAR';
  static const sushi = 'SUSHI';
  static const waves = 'WAVES';
  static const comp = 'COMP';
  static const cel = 'CEL';
  static const dash = 'DASH';
  static const qnt = 'QNT';
  static const ht = 'HT';
  static const dcr = 'DCR';
  static const hbar = 'HBAR';
  static const ust = 'UST';
  static const snx = 'SNX';
  static const hnt = 'HNT';
  static const xdc = 'XDC';
  static const chz = 'CHZ';
  static const bat = 'BAT';
  static const pax = 'PAX';
  static const ray = 'RAY';
  static const sdao = 'SDAO';
  static const agix = 'AGIX';
  static const cos = 'COS';
  static const lbc = 'LBC';
  static const hbtc = 'HBTC';
  static const hot = 'HOT';
  static const xem = 'XEM';
  static const zec = 'ZEC';
  static const tfuel = 'TFUEL';
  static const enj = 'ENJ';
  static const bcha = 'BCHA';
  static const stx = 'STX';
  static const ftm = 'FTM';
  static const qtum = 'QTUM';
  static const yfi = 'YFI';
  static const flow = 'FLOW';
  static const tusd = 'TUSD';
  static const zil = 'ZIL';
  static const btg = 'BTG';
  static const ar = 'AR';
  static const tel = 'TEL';
  static const mana = 'MANA';
  static const safemoon = 'SAFEMOON';
  static const audio = 'AUDIO';
  static const one = 'ONE';
  static const xsushi = 'XSUSHI';
  static const dgb = 'DGB';
  static const nexo = 'NEXO';
  static const clout = 'CLOUT';
  static const bnt = 'BNT';
  static const ont = 'ONT';

  static const List<String> list = [
    btc,
    eth,
    ada,
    bnb,
    usdt,
    doge,
    dot,
    xrp,
    usdc,
    sol,
    icp,
    uni,
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
    near,
    sushi,
    waves,
    comp,
    cel,
    dash,
    qnt,
    ht,
    dcr,
    hbar,
    ust,
    snx,
    hnt,
    xdc,
    chz,
    hbtc,
    hot,
    xem,
    zec,
    tfuel,
    enj,
    bcha,
    stx,
    ftm,
    qtum,
    yfi,
    flow,
    tusd,
    zil,
    rvn,
    btg,
    ar,
    tel,
    mana,
    safemoon,
    bat,
    audio,
    one,
    xsushi,
    dgb,
    nexo,
    clout,
    bnt,
    pax,
    ont,
    nano,
    erg,
    ray,
    coti,
    slp,
    agix,
    cos,
    sdao,
    lbc,
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
    near: 'near',
    sushi: 'sushi',
    waves: 'waves',
    comp: 'compound-governance-token',
    cel: 'celsius-degree-token',
    dash: 'dash',
    qnt: 'quant',
    ht: 'huobi-token',
    dcr: 'decred',
    hbar: 'hedera-hashgraph',
    ust: 'terrausd',
    snx: 'havven',
    hnt: 'helium',
    xdc: 'xdce-crowd-sale',
    chz: 'chiliz',
    bat: 'basic-attention-token',
    pax: 'payperex',
    ray: 'raydium',
    sdao: 'singularitydao',
    agix: 'singularitynet',
    cos: 'contentos',
    lbc: 'lbry-credits',
    hbtc: 'huobi-btc',
    hot: 'holotoken',
    xem: 'nem',
    zec: 'zcash',
    tfuel: 'theta-fuel',
    enj: 'enjincoin',
    bcha: 'bitcoin-cash-abc-2',
    stx: 'blockstack',
    ftm: 'fantom',
    qtum: 'qtum',
    yfi: 'yearn-finance',
    flow: 'flow',
    tusd: 'true-usd',
    zil: 'zilliqa',
    btg: 'bitcoin-gold',
    ar: 'arweave',
    tel: 'telcoin',
    mana: 'decentraland',
    safemoon: 'safemoon',
    audio: 'audius',
    one: 'harmony',
    xsushi: 'xsushi',
    dgb: 'digibyte',
    nexo: 'nexo',
    clout: 'bitclout',
    bnt: 'bancor',
    ont: 'ontology',
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
    near: 'Near',
    sushi: 'Sushi',
    waves: 'Waves',
    comp: 'Compound',
    cel: 'Celsius Network',
    dash: 'Dash',
    qnt: 'Quant',
    ht: 'Huobi Token',
    dcr: 'Decred',
    hbar: 'Hedera Hashgraph',
    ust: 'TerraUSD',
    snx: 'Synthetix Network Token',
    hnt: 'Helium',
    xdc: 'XDC Network',
    chz: 'Chiliz',
    bat: 'Basic Attention Token',
    pax: 'PayperEx',
    ray: 'Raydium',
    sdao: 'SingularityDAO',
    agix: 'SingularityNET',
    cos: 'Contentos',
    lbc: 'LBRY Credits',
    hbtc: 'Huobi BTC',
    hot: 'Holo',
    xem: 'NEM',
    zec: 'Zcash',
    tfuel: 'Theta Fuel',
    enj: 'Enjin Coin',
    bcha: 'Bitcoin Cash ABC',
    stx: 'Stacks',
    ftm: 'Fantom',
    qtum: 'Qtum',
    yfi: 'yearn.finance',
    flow: 'Flow',
    tusd: 'TrueUSD',
    zil: 'Zilliqa',
    btg: 'Bitcoin Gold',
    ar: 'Arweave',
    tel: 'Telcoin',
    mana: 'Decentraland',
    safemoon: 'SafeMoon',
    audio: 'Audius',
    one: 'Harmony',
    xsushi: 'xSUSHI',
    dgb: 'DigiByte',
    nexo: 'NEXO',
    clout: 'BitClout',
    bnt: 'Bancor Network Token',
    ont: 'Ontology',
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
