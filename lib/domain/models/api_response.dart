import 'dart:convert';

class ApiResponse {
  ApiResponse({
    required this.status,
    required this.body,
    required this.requestUrl,
    required this.requestBody,
    required this.method,
    this.headers,
  });

  int status;
  String body;
  Uri requestUrl;
  String requestBody;
  String method;
  Map<String, dynamic>? headers;

  dynamic get json => jsonDecode(body);
}
