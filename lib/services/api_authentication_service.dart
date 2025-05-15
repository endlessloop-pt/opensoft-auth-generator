import 'dart:convert';
import 'dart:typed_data';

import 'package:auth_generator/constants/xml_constants.dart';
import 'package:auth_generator/models/auth_header.dart';
import 'package:encrypt/encrypt.dart';
import 'package:logger/logger.dart';
import 'package:pointycastle/export.dart';
import 'package:xml/xml.dart';

class ApiAuthenticationService {
  final Logger _logger = Logger();

  String? getAuthenticationHeader(String username, String password, String env, String authServerData) {
    String requestCreatedTimestamp = _getCreatedTimestamp();
    Key symmetricKey = _generateAesSymmetricKey();
    String? nonce = _getNonce(symmetricKey, authServerData);
    String base64EncryptedPassword = _getEncryptedPassword(symmetricKey, password);
    String base64EncryptedDigest = _getDigest(password, requestCreatedTimestamp, symmetricKey);

    _logger.d("---- AUTHENTICATION HEADER --- \n nonce: $nonce \n "
        "digest: $base64EncryptedDigest \n encryptedPwd: $base64EncryptedPassword"
        " \n created: $requestCreatedTimestamp \n --------");

    final auth = AuthHeader(
      username: username,
      created: requestCreatedTimestamp,
      nonce: nonce,
      digest: base64EncryptedDigest,
      encryptedPassword: base64EncryptedPassword,
    );

    return _buildXmlBody(auth, env);
  }

  String? _buildXmlBody(AuthHeader authHeader, String env) {
    XmlBuilder builder = XmlBuilder();
    builder.element(
      env + SOAPConstants.tagEnvelopeWithoutEnv,
      nest: () {
        builder.namespace(
          SOAPConstants.envelopeNamespace,
          env,
        );
        builder.namespace(
          SOAPConstants.envelopeNamespace,
          "env",
        );
        builder.namespace(
          SOAPConstants.wssNamespace,
          SOAPConstants.attributeWss,
        );
        builder.element(
          SOAPConstants.tagHeader,
          nest: () {
            builder.element(
              SOAPConstants.security,
              // attributes: {SOAPConstants.tagActor: SOAPConstants.actorUrl},
              nest: () {
                // builder.attribute(
                //   SOAPConstants.attributeAtVersion,
                //   SOAPConstants.atVersionValue,
                // );
                // builder.namespace(
                //   SOAPConstants.atNamespace,
                //   SOAPConstants.attributeAt,
                // );
                builder.element(
                  SOAPConstants.tagUsernameToken,
                  nest: () {
                    builder.element(
                      SOAPConstants.tagUsername,
                      nest: () {
                        builder.text(authHeader.username);
                      },
                    );

                    builder.element(
                      SOAPConstants.tagPassword,
                      attributes: {
                        SOAPConstants.attributeDigest: authHeader.digest,
                      },
                      nest: () {
                        builder.text(authHeader.encryptedPassword);
                      },
                    );
                    builder.element(
                      SOAPConstants.tagNonce,
                      nest: () {
                        builder.text(authHeader.nonce ?? '');
                      },
                    );
                    builder.element(
                      SOAPConstants.tagCreated,
                      nest: () {
                        builder.text(authHeader.created);
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
    XmlDocument document = builder.buildDocument();
    return document.toXmlString(pretty: true, indent: '\t');
  }

  Key _generateAesSymmetricKey() {
    final key = Key.fromSecureRandom(16);
    return key;
  }

  String _getCreatedTimestamp() {
    return DateTime.now().toUtc().toIso8601String();
  }

  String? _getNonce(Key symmetricKey, String publicSaData) {
    final publicKey = RSAKeyParser().parse(publicSaData) as RSAPublicKey;

    // 3. encrypt symetric key with sa public key

    final cipher = PKCS1Encoding(RSAEngine());
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    Uint8List output = cipher.process(Uint8List.fromList(symmetricKey.bytes));

    // 4. Encode to base64 and return
    return base64Encode(output);
  }

  String _getEncryptedPassword(Key symmetricKey, String password) {
    var aesEngine = AESEngine();
    aesEngine.init(true, KeyParameter(symmetricKey.bytes));
    var cipher = PaddedBlockCipherImpl(
      PKCS7Padding(),
      ECBBlockCipher(aesEngine),
    );
    cipher.init(
      true /*encrypt*/,
      PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
        KeyParameter(symmetricKey.bytes),
        null,
      ),
    );

    Uint8List output = cipher.process(Uint8List.fromList(utf8.encode(password)));
    return base64Encode(output);

  }

  String _getEncryptedHash(Key symmetricKey, Uint8List hash) {
    var aesEngine = AESEngine();
    aesEngine.init(true, KeyParameter(symmetricKey.bytes));
    var cipher = PaddedBlockCipherImpl(
      PKCS7Padding(),
      ECBBlockCipher(aesEngine),
    );
    cipher.init(
      true /*encrypt*/,
      PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
        KeyParameter(symmetricKey.bytes),
        null,
      ),
    );

    Uint8List output = cipher.process(hash);
    return base64Encode(output);

  }

  String _getDigest(String password, String created, Key symmetricKey) {
    final aesEngine = AESEngine();
    aesEngine.init(true, KeyParameter(symmetricKey.bytes));

    var b = BytesBuilder();
    b.add(symmetricKey.bytes);
    b.add(utf8.encode(created));
    b.add(utf8.encode(password));

    final digestSha1 = Digest('SHA-1').process(b.toBytes());

    String encHash = _getEncryptedHash(symmetricKey, digestSha1);
    return encHash;
  }
}