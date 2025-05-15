class AuthHeader {
  String username;
  String created;
  String? nonce;
  String digest;
  String encryptedPassword;

  factory AuthHeader.empty() {
    return AuthHeader(
      username: '',
      created: '',
      nonce: '',
      digest: 'digest',
      encryptedPassword: '',
    );
  }

  AuthHeader({
    required this.username,
    required this.created,
    required this.nonce,
    required this.digest,
    required this.encryptedPassword,
  });
}
