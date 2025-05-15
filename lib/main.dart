import 'dart:async';

import 'package:auth_generator/services/key_loader.dart';
import 'package:auth_generator/services/service_locator.dart';
import 'package:auth_generator/theme.dart';
import 'package:auth_generator/views/home_view.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  KeyLoader keyLoader = serviceLocator<KeyLoader>();
  await keyLoader.loadKeys();

  runApp(const MyApp());
}

final _appTheme = AppTheme();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appTheme,
      builder: (context, child) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: 'Auth Generator',
          debugShowCheckedModeBanner: false,
          home: HomeView(),
          themeMode: appTheme.mode,
          color: appTheme.color,
          locale: appTheme.locale,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
        );
      },
    );
  }
}
