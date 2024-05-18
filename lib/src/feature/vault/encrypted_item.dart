import 'package:cryptography/cryptography.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class EncryptedItem {
  @Id()
  int id;
  String name;
  List<int>? encryptedContent;
  List<int>? nonce;
  List<int>? mac;
  DateTime createdDate;
  @Index()
  bool isSign;

  @Transient()
  List<int>? _content;

  @Transient()
  final Cipher algo;

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
          await algo.decrypt(secretBox, secretKey: SecretKey(passwordHash));
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
        await algo.encrypt(content, secretKey: SecretKey(passwordHash));
    nonce = secretBox.nonce;
    mac = secretBox.mac.bytes;
    encryptedContent = secretBox.cipherText;
  }

  EncryptedItem({this.name = "", this.id = 0, this.isSign = false})
      : createdDate = DateTime.now(),
        algo = AesGcm.with256bits();
}
