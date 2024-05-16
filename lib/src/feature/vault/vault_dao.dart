abstract class VaultDAO {
  Future<void> load();

  Future<void> create(String password);
}
