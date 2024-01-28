// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  Computed<BottomNavigationPage>? _$currentPageComputed;

  @override
  BottomNavigationPage get currentPage => (_$currentPageComputed ??=
          Computed<BottomNavigationPage>(() => super.currentPage,
              name: '_AppStore.currentPage'))
      .value;

  late final _$currentPageValueAtom =
      Atom(name: '_AppStore.currentPageValue', context: context);

  @override
  int get currentPageValue {
    _$currentPageValueAtom.reportRead();
    return super.currentPageValue;
  }

  @override
  set currentPageValue(int value) {
    _$currentPageValueAtom.reportWrite(value, super.currentPageValue, () {
      super.currentPageValue = value;
    });
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('_AppStore.signInWithGoogle', context: context);

  @override
  Future<void> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void changePage(int newPage) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.changePage');
    try {
      return super.changePage(newPage);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listenUser() {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.listenUser');
    try {
      return super.listenUser();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPageValue: ${currentPageValue},
currentPage: ${currentPage}
    ''';
  }
}
