import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @averagePrice.
  ///
  /// In en, this message translates to:
  /// **'Average price'**
  String get averagePrice;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @crypto.
  ///
  /// In en, this message translates to:
  /// **'Crypto'**
  String get crypto;

  /// No description provided for @cryptoAmount.
  ///
  /// In en, this message translates to:
  /// **'Crypto amount'**
  String get cryptoAmount;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @errorFieldNull.
  ///
  /// In en, this message translates to:
  /// **'This field can\'t be null'**
  String get errorFieldNull;

  /// No description provided for @errorFieldNotNumber.
  ///
  /// In en, this message translates to:
  /// **'This field must be a valid number'**
  String get errorFieldNotNumber;

  /// No description provided for @errorFieldLessZero.
  ///
  /// In en, this message translates to:
  /// **'This field must be equals or greater than \$0,00'**
  String get errorFieldLessZero;

  /// No description provided for @errorFieldLessZeroOrZero.
  ///
  /// In en, this message translates to:
  /// **'This field must be greater than 0'**
  String get errorFieldLessZeroOrZero;

  /// No description provided for @errorFieldWrongDate.
  ///
  /// In en, this message translates to:
  /// **'Insert a valid date'**
  String get errorFieldWrongDate;

  /// No description provided for @errorInsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance to carry out the transaction'**
  String get errorInsufficientBalance;

  /// No description provided for @errorLogin.
  ///
  /// In en, this message translates to:
  /// **'Error trying to login'**
  String get errorLogin;

  /// No description provided for @errorLogout.
  ///
  /// In en, this message translates to:
  /// **'Error trying to logout'**
  String get errorLogout;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @gainLoss.
  ///
  /// In en, this message translates to:
  /// **'Gain / Loss'**
  String get gainLoss;

  /// No description provided for @googleButton.
  ///
  /// In en, this message translates to:
  /// **'Enter with Google'**
  String get googleButton;

  /// No description provided for @hideTotal.
  ///
  /// In en, this message translates to:
  /// **'Hide Total'**
  String get hideTotal;

  /// No description provided for @hintFieldCrypto.
  ///
  /// In en, this message translates to:
  /// **'Select a crypto'**
  String get hintFieldCrypto;

  /// No description provided for @hintFieldDate.
  ///
  /// In en, this message translates to:
  /// **'dd/MM/yyyy'**
  String get hintFieldDate;

  /// No description provided for @hintFieldOperationType.
  ///
  /// In en, this message translates to:
  /// **'Select the operation type'**
  String get hintFieldOperationType;

  /// No description provided for @hintTrade.
  ///
  /// In en, this message translates to:
  /// **'Note: We only use dollars for operations. Pay attention to filling in the fields.'**
  String get hintTrade;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @logo.
  ///
  /// In en, this message translates to:
  /// **'See all your cryptos in one place'**
  String get logo;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @inYourWallet.
  ///
  /// In en, this message translates to:
  /// **'In your wallet'**
  String get inYourWallet;

  /// No description provided for @invested.
  ///
  /// In en, this message translates to:
  /// **'invested'**
  String get invested;

  /// No description provided for @investedAmount.
  ///
  /// In en, this message translates to:
  /// **'Invested amount'**
  String get investedAmount;

  /// No description provided for @noCryptos.
  ///
  /// In en, this message translates to:
  /// **'No cryptos in the wallet'**
  String get noCryptos;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'There is no data on your wallet'**
  String get noData;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results for the searched term'**
  String get noResults;

  /// No description provided for @noTrades.
  ///
  /// In en, this message translates to:
  /// **'No trades in the wallet'**
  String get noTrades;

  /// No description provided for @oneYear.
  ///
  /// In en, this message translates to:
  /// **'1y'**
  String get oneYear;

  /// No description provided for @operationType.
  ///
  /// In en, this message translates to:
  /// **'Operation Type'**
  String get operationType;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'register'**
  String get register;

  /// No description provided for @registerTrade.
  ///
  /// In en, this message translates to:
  /// **'Register Trade'**
  String get registerTrade;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @showTotal.
  ///
  /// In en, this message translates to:
  /// **'Show Total'**
  String get showTotal;

  /// No description provided for @soldAmount.
  ///
  /// In en, this message translates to:
  /// **'Sold amount'**
  String get soldAmount;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @totalInvested.
  ///
  /// In en, this message translates to:
  /// **'Total invested'**
  String get totalInvested;

  /// No description provided for @tradeDetails.
  ///
  /// In en, this message translates to:
  /// **'Trade Details'**
  String get tradeDetails;

  /// No description provided for @tradePrice.
  ///
  /// In en, this message translates to:
  /// **'Crypto price'**
  String get tradePrice;

  /// No description provided for @trades.
  ///
  /// In en, this message translates to:
  /// **'Trades'**
  String get trades;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
