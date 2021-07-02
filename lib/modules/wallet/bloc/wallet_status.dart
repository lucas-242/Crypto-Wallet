import 'package:crypto_wallet/shared/models/status_page.dart';

class WalletStatus {
  final StatusPage statusPage;
  final String error;

  WalletStatus({this.statusPage = StatusPage.success, this.error = ''});

  factory WalletStatus.error(String error) =>
      WalletStatus(statusPage: StatusPage.error, error: error);

  factory WalletStatus.loading() =>
      WalletStatus(statusPage: StatusPage.loading);
}
