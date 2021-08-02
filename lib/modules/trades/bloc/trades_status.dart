import 'package:crypto_wallet/shared/models/enums/status_page.dart';

class TradesStatus {
  final StatusPage statusPage;
  final String error;

  TradesStatus({this.statusPage = StatusPage.success, this.error = ''});

  factory TradesStatus.error(String error) =>
      TradesStatus(statusPage: StatusPage.error, error: error);

  factory TradesStatus.loading() =>
      TradesStatus(statusPage: StatusPage.loading);

  factory TradesStatus.noData() => TradesStatus(statusPage: StatusPage.noData);
}
