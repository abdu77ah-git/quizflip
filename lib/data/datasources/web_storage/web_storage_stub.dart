import 'web_storage.dart';

class StubWebStorage implements WebStorage {
  @override
  void save(String key, String value) {}

  @override
  String? load(String key) => null;
}

WebStorage getWebStorage() => StubWebStorage();
