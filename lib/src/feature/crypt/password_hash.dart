import 'package:cryptography/cryptography.dart';

class PasswordHash {
  final String password;
  final List<int> nonce;

  PasswordHash(this.password, this.nonce);

  factory PasswordHash.weak(String password) {
    const weakNonce = [70, 85, 84, 206, 182, 189, 11, 48];
    return PasswordHash(password, weakNonce);
  }

  Future<List<int>> generateHash(String password, List<int> nonce) async {
    final algo =
        Argon2id(parallelism: 1, memory: 47104, iterations: 1, hashLength: 32);
    final secretKey =
        await algo.deriveKeyFromPassword(password: password, nonce: nonce);
    return await secretKey.extractBytes();
  }
}
