import 'package:auth_generator/constants/xml_constants.dart';
import 'package:auth_generator/services/api_authentication_service.dart';
import 'package:auth_generator/services/key_loader.dart';
import 'package:auth_generator/services/service_locator.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class GeneratorViewModel extends ChangeNotifier {
  final ApiAuthenticationService _apiAuthenticationService =
      serviceLocator<ApiAuthenticationService>();
  final KeyLoader _keyLoader = serviceLocator<KeyLoader>();
  final Logger _logger = Logger();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController environmentController = TextEditingController(
    text: SOAPConstants.attributeSoapenv,
  );
  final TextEditingController generatedHeader = TextEditingController();

  Future<void> onSubmit(BuildContext context) async {
    final String user = userNameController.text;
    final String password = passwordController.text;
    final String environment = environmentController.text;

    if (user.isEmpty || password.isEmpty) {
      _logger.w("Username or password is empty");
      showContentDialog(context);
      return;
    }

    final res = _apiAuthenticationService.getAuthenticationHeader(
      user,
      password,
      environment,
      _keyLoader.authServerData,
    );

    if (res != null) {
      generatedHeader.text = res.toString();
      _logger.d("Generated Header: $generatedHeader");
      notifyListeners();
    } else {
      _logger.w("Auth header is null");
    }
  }

  void showContentDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Empty Fields'),
        content: const Text(
          'Please fill in all fields before generating the header.',
        ),
        actions: [
          Button(
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
              // Delete file here
            },
          ),
        ],
      ),
    );
  }

  void clearFields() {
    userNameController.clear();
    passwordController.clear();
    generatedHeader.clear();
    notifyListeners();
  }

  void clearGeneratedHeader() {
    generatedHeader.clear();
    notifyListeners();
  }

  void copyGeneratedHeader() {
    Clipboard.setData(ClipboardData(text: generatedHeader.text));
    _logger.d("Copied to clipboard: ${generatedHeader.text}");
  }
}
