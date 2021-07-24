import 'package:crypto_wallet/shared/models/status_page.dart';

class HomeStatus {
  final StatusPage statusPage;
  final String error;

  HomeStatus({this.statusPage = StatusPage.success, this.error = ''});

  factory HomeStatus.error(String error) =>
      HomeStatus(statusPage: StatusPage.error, error: error);

  factory HomeStatus.loading() =>
      HomeStatus(statusPage: StatusPage.loading);

  factory HomeStatus.noData() =>
      HomeStatus(statusPage: StatusPage.noData);
}
