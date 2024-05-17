abstract class VaultDao {
  Future<void> tryUnlock(String password);

  Future<bool> get isMasterPassSet;
}
