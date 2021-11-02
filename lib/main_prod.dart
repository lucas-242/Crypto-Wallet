import 'main_delegate.dart';
import '/shared/core/build_configs.dart';
import 'shared/models/enums/environment.dart';

Future<void> main() async {
  Config.setEnvironment(Environment.prod);
  mainDelegate();
}