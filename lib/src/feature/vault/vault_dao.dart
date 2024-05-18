abstract class VaultDao {
  static const magicSeq = [19, 84];

  Future<bool> tryUnlock(String password);

  Future<bool> get isMasterPassSet;
}
