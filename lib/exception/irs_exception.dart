class IrsException implements Exception {
  final String _message;

  IrsException(this._message);

  @override
  String toString() {
    return _message;
  }
}

class CredentialsExpiredException extends IrsException {
  CredentialsExpiredException(super.message);
}
