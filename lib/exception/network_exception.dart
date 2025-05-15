class NetworkException implements Exception {
  final String message;
  final String? prefix;

  NetworkException({required this.message, this.prefix = ''});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends NetworkException {
  FetchDataException(String message)
      : super(
          message: message,
          prefix: 'request_error',
        );
}

class BadFormatException extends NetworkException {
  BadFormatException(String message)
      : super(
          message: message,
          prefix: 'invalid_format',
        );
}

class UnexpectedErrorException extends NetworkException {
  UnexpectedErrorException(String message)
      : super(
          message: message,
        );
}

class InsecureConnectionException extends NetworkException {
  InsecureConnectionException(String message)
      : super(
          message: message,
        );
}

class BadSecurityHeader extends NetworkException {
  BadSecurityHeader(String message)
      : super(
          message: message,
          prefix: 'bad_security_header',
        );
}

class MissingPermissionsException extends NetworkException {
  MissingPermissionsException(String message)
      : super(
          message: message,
          prefix: 'permissions_error',
        );
}

class ServiceException extends NetworkException {
  ServiceException(String message) : super(message: message);
}

class BadIrsYearException extends NetworkException {
  BadIrsYearException(String message) : super(message: message);
}

class BadRequestException extends NetworkException {
  BadRequestException(String message)
      : super(
          message: message,
          prefix: 'bad_request',
        );
}

class BadResponseException extends NetworkException {
  BadResponseException(String message)
      : super(
          message: message,
          prefix: 'bad_response',
        );
}

class MissingXMLElement extends NetworkException {
  MissingXMLElement(String message)
      : super(
          message: message,
          prefix: 'missing_xml_element',
        );
}

class CredentialsException implements Exception {
  final String? _attemptNumber;
  final String? _message;
  final String? _genericMessage;

  CredentialsException(
    this._message,
    this._attemptNumber,
    this._genericMessage,
  );

  @override
  String toString() {
    if (_attemptNumber != null) {
      return "$_message \nTem $_attemptNumber tentativas.";
    } else {
      return _message ?? '';
    }
  }

  String get genericMessage => _genericMessage ?? '';

  String? get attemptNumber => _attemptNumber;
}
