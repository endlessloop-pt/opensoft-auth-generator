class User {
  User({
    required this.loginNif,
    this.password,
    required this.actorUrl,
  });
  String? loginNif;
  String? password;
  final String actorUrl;

  void setLoginNif(String? value) {
    loginNif = value;
  }

  void setPassword(String? value) {
    password = value;
  }
}
