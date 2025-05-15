import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class KeyLoader {
  String? authPass;
  String? _publicSaData;

  Future<void> loadKeys() async {
    await _loadAuthenticationServerKey();
  }

  String get authServerData {
    if (_publicSaData == null) {
      throw Exception("AuthServerData key not set.");
    } else {
      return _publicSaData!;
    }
  }

  Future<void> _loadAuthenticationServerKey() async {
    try {
      _publicSaData = await rootBundle.loadString(
        'assets/crypto/sa_pub_key_prod.pem',
      );
    } catch (exception) {
      debugPrint("Authentication key not found. $exception");
    }
  }
}
