import 'package:cryptography/cryptography.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class EncryptedItem {
  @Id()
  int id;
  List<int>? encryptedContent;
  List<int>? nonce;
  List<int>? mac;
  @Index()
  bool isSign;

  @Transient()
  List<int>? _content;

  @Transient()
  final Cipher _algo;

  Future<List<int>?> getContent(List<int> passwordHash) async {
    if (_content != null ||
        nonce == null ||
        mac == null ||
        encryptedContent == null) {
      return _content;
    }
    final secretBox =
        SecretBox(encryptedContent!, nonce: nonce!, mac: Mac(mac!));
    try {
      _content =
          await _algo.decrypt(secretBox, secretKey: SecretKey(passwordHash));
    } catch (e) {
      if (e is SecretBoxAuthenticationError) {
        return _content;
      }
      rethrow;
    }
    return _content;
  }

  Future<void> setContent(List<int> passwordHash, List<int> content) async {
    final secretBox =
        await _algo.encrypt(content, secretKey: SecretKey(passwordHash));
    nonce = secretBox.nonce;
    mac = secretBox.mac.bytes;
    encryptedContent = secretBox.cipherText;
  }

  EncryptedItem({this.id = 0, this.isSign = false})
      : _algo = AesGcm.with256bits();
}
