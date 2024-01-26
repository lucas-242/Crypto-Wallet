// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Todos`
  String get all {
    return Intl.message(
      'Todos',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Montante`
  String get amount {
    return Intl.message(
      'Montante',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Preço médio`
  String get averagePrice {
    return Intl.message(
      'Preço médio',
      name: 'averagePrice',
      desc: '',
      args: [],
    );
  }

  /// `Compra`
  String get buy {
    return Intl.message(
      'Compra',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message(
      'Cancelar',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cripto`
  String get crypto {
    return Intl.message(
      'Cripto',
      name: 'crypto',
      desc: '',
      args: [],
    );
  }

  /// `Montante em cripto`
  String get cryptoAmount {
    return Intl.message(
      'Montante em cripto',
      name: 'cryptoAmount',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get date {
    return Intl.message(
      'Data',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Modo escuro`
  String get darkMode {
    return Intl.message(
      'Modo escuro',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Deletar`
  String get delete {
    return Intl.message(
      'Deletar',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Esse campo precisa ser preenchido`
  String get errorFieldNull {
    return Intl.message(
      'Esse campo precisa ser preenchido',
      name: 'errorFieldNull',
      desc: '',
      args: [],
    );
  }

  /// `Esse campo precisa ser um número válido`
  String get errorFieldNotNumber {
    return Intl.message(
      'Esse campo precisa ser um número válido',
      name: 'errorFieldNotNumber',
      desc: '',
      args: [],
    );
  }

  /// `Esse campo precisa ser igual ou maior que $0,00`
  String get errorFieldLessZero {
    return Intl.message(
      'Esse campo precisa ser igual ou maior que \$0,00',
      name: 'errorFieldLessZero',
      desc: '',
      args: [],
    );
  }

  /// `Esse campo precisa ser maior que 0`
  String get errorFieldLessZeroOrZero {
    return Intl.message(
      'Esse campo precisa ser maior que 0',
      name: 'errorFieldLessZeroOrZero',
      desc: '',
      args: [],
    );
  }

  /// `Insira uma data válida`
  String get errorFieldWrongDate {
    return Intl.message(
      'Insira uma data válida',
      name: 'errorFieldWrongDate',
      desc: '',
      args: [],
    );
  }

  /// `Saldo insuficiente para efetuar a operação`
  String get errorInsufficientBalance {
    return Intl.message(
      'Saldo insuficiente para efetuar a operação',
      name: 'errorInsufficientBalance',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao tentar logar`
  String get errorLogin {
    return Intl.message(
      'Erro ao tentar logar',
      name: 'errorLogin',
      desc: '',
      args: [],
    );
  }

  /// `Error trying to logout`
  String get errorLogout {
    return Intl.message(
      'Error trying to logout',
      name: 'errorLogout',
      desc: '',
      args: [],
    );
  }

  /// `Taxa`
  String get fee {
    return Intl.message(
      'Taxa',
      name: 'fee',
      desc: '',
      args: [],
    );
  }

  /// `Filtrar`
  String get filter {
    return Intl.message(
      'Filtrar',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Ganho / Perda`
  String get gainLoss {
    return Intl.message(
      'Ganho / Perda',
      name: 'gainLoss',
      desc: '',
      args: [],
    );
  }

  /// `Entrar com Google`
  String get googleButton {
    return Intl.message(
      'Entrar com Google',
      name: 'googleButton',
      desc: '',
      args: [],
    );
  }

  /// `Esconder Total`
  String get hideTotal {
    return Intl.message(
      'Esconder Total',
      name: 'hideTotal',
      desc: '',
      args: [],
    );
  }

  /// `Selecione uma cripto`
  String get hintFieldCrypto {
    return Intl.message(
      'Selecione uma cripto',
      name: 'hintFieldCrypto',
      desc: '',
      args: [],
    );
  }

  /// `dd/MM/aaaa`
  String get hintFieldDate {
    return Intl.message(
      'dd/MM/aaaa',
      name: 'hintFieldDate',
      desc: '',
      args: [],
    );
  }

  /// `Selecione um tipo de operação`
  String get hintFieldOperationType {
    return Intl.message(
      'Selecione um tipo de operação',
      name: 'hintFieldOperationType',
      desc: '',
      args: [],
    );
  }

  /// `Obs: Por enquanto utilizamos apenas dolár para as operações. Fique atento ao preenchimentos dos campos.`
  String get hintTrade {
    return Intl.message(
      'Obs: Por enquanto utilizamos apenas dolár para as operações. Fique atento ao preenchimentos dos campos.',
      name: 'hintTrade',
      desc: '',
      args: [],
    );
  }

  /// `Modo claro`
  String get lightMode {
    return Intl.message(
      'Modo claro',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Veja todas suas criptos em um só lugar`
  String get logo {
    return Intl.message(
      'Veja todas suas criptos em um só lugar',
      name: 'logo',
      desc: '',
      args: [],
    );
  }

  /// `Sair`
  String get logout {
    return Intl.message(
      'Sair',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Em sua carteira`
  String get inYourWallet {
    return Intl.message(
      'Em sua carteira',
      name: 'inYourWallet',
      desc: '',
      args: [],
    );
  }

  /// `investido`
  String get invested {
    return Intl.message(
      'investido',
      name: 'invested',
      desc: '',
      args: [],
    );
  }

  /// `Montante investido`
  String get investedAmount {
    return Intl.message(
      'Montante investido',
      name: 'investedAmount',
      desc: '',
      args: [],
    );
  }

  /// `1a`
  String get oneYear {
    return Intl.message(
      '1a',
      name: 'oneYear',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de Operação`
  String get operationType {
    return Intl.message(
      'Tipo de Operação',
      name: 'operationType',
      desc: '',
      args: [],
    );
  }

  /// `Não há criptos na carteira`
  String get noCryptos {
    return Intl.message(
      'Não há criptos na carteira',
      name: 'noCryptos',
      desc: '',
      args: [],
    );
  }

  /// `Não há dados na sua carteira`
  String get noData {
    return Intl.message(
      'Não há dados na sua carteira',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Sem resultados para o termo buscado`
  String get noResults {
    return Intl.message(
      'Sem resultados para o termo buscado',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Não há trades na carteira`
  String get noTrades {
    return Intl.message(
      'Não há trades na carteira',
      name: 'noTrades',
      desc: '',
      args: [],
    );
  }

  /// `Cotação`
  String get price {
    return Intl.message(
      'Cotação',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `registrar`
  String get register {
    return Intl.message(
      'registrar',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Registrar Trade`
  String get registerTrade {
    return Intl.message(
      'Registrar Trade',
      name: 'registerTrade',
      desc: '',
      args: [],
    );
  }

  /// `Salvar`
  String get save {
    return Intl.message(
      'Salvar',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Busca`
  String get search {
    return Intl.message(
      'Busca',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Venda`
  String get sell {
    return Intl.message(
      'Venda',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Mostrar Total`
  String get showTotal {
    return Intl.message(
      'Mostrar Total',
      name: 'showTotal',
      desc: '',
      args: [],
    );
  }

  /// `Montante vendido`
  String get soldAmount {
    return Intl.message(
      'Montante vendido',
      name: 'soldAmount',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Total investido`
  String get totalInvested {
    return Intl.message(
      'Total investido',
      name: 'totalInvested',
      desc: '',
      args: [],
    );
  }

  /// `Detalhes do Trade`
  String get tradeDetails {
    return Intl.message(
      'Detalhes do Trade',
      name: 'tradeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Cotação`
  String get tradePrice {
    return Intl.message(
      'Cotação',
      name: 'tradePrice',
      desc: '',
      args: [],
    );
  }

  /// `Trades`
  String get trades {
    return Intl.message(
      'Trades',
      name: 'trades',
      desc: '',
      args: [],
    );
  }

  /// `Transferência`
  String get transfer {
    return Intl.message(
      'Transferência',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `Carteira`
  String get wallet {
    return Intl.message(
      'Carteira',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
