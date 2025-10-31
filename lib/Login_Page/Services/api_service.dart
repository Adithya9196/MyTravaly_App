import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mytravaly_app/Login_Page/Models/device_register_response.dart';

class GoogleSignInService {
  static const String _baseUrl = "https://api.mytravaly.com/public/v1/";
  static const Map<String, String> _headers = {
    "Content-Type": "application/json",
    "authtoken": "71523fdd8d26f585315b4233e39d9263",
  };

  static Future<String?> registerDevice(DeviceRegister device) async {
    final body = jsonEncode({
      "action": "deviceRegister",
      "deviceRegister": device.toJson(),
    });

    final response =
        await http.post(Uri.parse(_baseUrl), headers: _headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['data']?['visitorToken'] ?? 'No token';
    } else {
      throw Exception('Failed to register device (${response.statusCode})');
    }
  }

  static String generateVisitorToken(String name) {
    // Simple unique demo token generator
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'demo_token_${name}_$timestamp';
  }
}
