import 'package:auth_generator/constants/xml_constants.dart';
import 'package:xml/xml.dart';

class AuthError {
  AuthError(
    this.code,
    this.message,
    this.numberOfTimesRemaining,
  );

  final int code;
  final String message;
  final int numberOfTimesRemaining;

  factory AuthError.fromResponse(XmlElement xml) {
    return AuthError(
      int.parse(xml.getAttribute(SOAPConstants.codeEn) ?? '-999'),
      xml.getAttribute(SOAPConstants.messageEn)?.replaceAll('\\n', '\n') ?? '',
      int.parse(xml.getAttribute(SOAPConstants.numberTries) ?? '0'),
    );
  }
}
