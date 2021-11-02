<h1>Crypto Wallet</h1>

<h2 align="center">Topics 📋</h2>

   <p>
   
   - [About 📖](#About-)
   - [How to use 🤔](#How-to-use-)

   </p>

---

<h2 align="center">About 📖</h2>
   
<p>
  Crypto Wallet is an app to centralize all of your crypto finances in an unique place.
</p>

<p>
The first version of the app will work with BTC, ETH, ADA, XRP, DOGE, BNB, DOT and SOL. It will allow you to save your buy/sell trades in Dollar and view the balance of your cryptos separately or all consolidated in a dashboard.
</p>

<p>
I'm using <a href="https://www.coingecko.com/api">CoinGecko API</a> to get the crypto currencies.
</p>

<p>
This project has been develop for personal use at first moment, but feel free to contribute with ideas or code. Maybe one day this could be at the stores.
</p>

---

<h2 align="center">How to use🤔</h2>

   ```
   - Clone this repository:
   $ git clone https://github.com/lucas-242/Crypto-Wallet.git

   - Enter in the directory:
   $ cd Crypto-Wallet/crypto_wallet_view

   - Create the file apikey.properties with ADMOB_APPID test key:
   $ echo ADMOB_APPID = "ca-app-pub-3940256099942544~3347511713" > apikey.properties

   - Create the file keys.dart with ad mob units test keys:
   $ echo "const admob_unit_trade_operation = 'ca-app-pub-3940256099942544/1033173712';" > lib/shared/core/keys.dart

   - Install the dependencies:
   $ flutter pub get

   - Run the app: 
   $ flutter run
   ```
