// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'web_storage.dart';

class HtmlWebStorage implements WebStorage {
  @override
  void save(String key, String value) {
    html.window.localStorage[key] = value;
  }

  @override
  String? load(String key) {
    return html.window.localStorage[key];
  }
}

WebStorage getWebStorage() => HtmlWebStorage();
