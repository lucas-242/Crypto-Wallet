abstract interface class LocalStorage {
  Future<void> remove(String key);
  Future<void> set<T>(String key, T value);
  T? get<T>(String key);
}
