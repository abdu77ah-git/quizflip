import 'web_storage_stub.dart'
    if (dart.library.html) 'web_storage_web.dart';

abstract class WebStorage {
  static WebStorage get instance => getWebStorage();

  void save(String key, String value);
  String? load(String key);
}
