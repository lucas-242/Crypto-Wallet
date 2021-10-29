import 'package:crypto_wallet/shared/models/enums/status_page.dart';

class InsertTradeStatus {
  final StatusPage statusPage;
  final String error;

  InsertTradeStatus({this.statusPage = StatusPage.success, this.error = ''});

  factory InsertTradeStatus.error(String error) =>
      InsertTradeStatus(statusPage: StatusPage.error, error: error);

  factory InsertTradeStatus.loading() =>
      InsertTradeStatus(statusPage: StatusPage.loading);
}
