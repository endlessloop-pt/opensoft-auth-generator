class SOAPConstants {
  static const String tagEnvelope = '$attributeSoapenv:Envelope';
  static const String tagEnvelopeWithoutEnv = ':Envelope';
  static const String attributeSoapenv = 'S';
  static const String envelopeNamespace =
      'http://schemas.xmlsoap.org/soap/envelope/';
  static const String tagHeader = '$attributeSoapenv:Header';
  static const String attributeWss = 'wss';
  static const String wssNamespace =
      'http://schemas.xmlsoap.org/ws/2002/12/secext';
  static const String security = '$attributeWss:Security';
  static const String tagActor = '$attributeSoapenv:actor';
  static const String actor = 'Actor';
  static const String actorAUrl = 'http://at.pt/actor/SPA';
  static const String actorBUrl = 'http://at.pt/actor/SPB';
  static String dependantActor(int index) => 'http://at.pt/actor/D$index';
  static const String attributeAtVersion = 'at:Version';
  static const String atVersionValue = '2';
  static const String atNamespace = 'http://at.pt/wsp/auth';
  static const String attributeAt = 'at';
  static const String attributeSch = 'sch';
  static const String schNamespace =
      'https://servicos.portaldasfinancas.gov.pt/dm3irsmobile/schemas';
  static const String attributeSch1 = 'sch1';
  static const String sch1Namespace =
      'https://servicos.portaldasfinancas.gov.pt/dm3irs/schemas';
  static const String tagUsernameToken = 'wss:UsernameToken';
  static const String tagUsername = 'wss:Username';
  static const String tagPassword = 'wss:Password';
  static const String attributeDigest = 'Digest';
  static const String tagNonce = 'wss:Nonce';
  static const String tagCreated = 'wss:Created';
  static const String tagBody = '$attributeSoapenv:Body';
  static const String code = 'codigo';
  static const String statusType = 'statusType';
  static const String faultCode = 'faultcode';
  static const String message = 'mensagem';
  static const String faultString = 'faultstring';
  static const String authenticationException = 'ns:AuthenticationException';
  static const String detail = 'detail';
  static const String authenticationFailed = 'AuthenticationFailed';
  static const String numberTries = 'NumberOfTriesRemaining';
  static const String codeEn = 'Code';
  static const String messageEn = 'Message';
  static const String anyNamespace = '*';
}
