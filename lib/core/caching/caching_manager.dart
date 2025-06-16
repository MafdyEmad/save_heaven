class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, dynamic> _cache = {};

  void setData(String key, dynamic value) {
    _cache[key] = value;
  }

  dynamic getData(String key) {
    return _cache[key];
  }

  void clearCache() {
    _cache.clear();
  }

  void removeKey(String key) {
    _cache.remove(key);
  }
}
