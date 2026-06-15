import 'dart:convert';

extension JsonStringExtension on String {
  Map<String, dynamic> decodeJsonMap() {
    final decoded = jsonDecode(this);
    return decoded is Map<String, dynamic> ? decoded : const {};
  }
}

extension JsonObjectExtension on Object? {
  Map<String, dynamic>? asJsonMap() {
    final value = this;
    return value is Map<String, dynamic> ? value : null;
  }

  List<dynamic> asJsonList() {
    final value = this;
    return value is List<dynamic> ? value : const [];
  }
}
