import 'package:auth_generator/services/api_authentication_service.dart';
import 'package:auth_generator/services/key_loader.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<ApiAuthenticationService>(
    () => ApiAuthenticationService(),
  );
  serviceLocator.registerLazySingleton<KeyLoader>(() => KeyLoader());
}
