abstract class LocalStorageBase {
  Future<void> write(String key, String value);
  String? read(String key);
  Future<void> delete(String key);
  Future<void> clear();
}