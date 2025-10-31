import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mytravaly_app/Search_Page/Model_Page/Search_Model.dart';

class SearchRepository {
  static const String _baseUrl = 'https://api.mytravaly.com/public/v1/';
  static const String _authToken = '71523fdd8d26f585315b4233e39d9263';

  Future<SearchModel> searchHotels(String visitorToken) async {
    final headers = {
      'Content-Type': 'application/json',
      'authtoken': _authToken,
      'visitortoken': visitorToken,
    };

    final body = {
      "action": "getSearchResultListOfHotels",
      "getSearchResultListOfHotels": {
        "searchCriteria": {
          "checkIn": "2026-07-11",
          "checkOut": "2026-07-12",
          "rooms": 2,
          "adults": 2,
          "children": 0,
          "searchType": "hotelIdSearch",
          "searchQuery": ["qyhZqzVt"],
          "limit": 5,
          "accommodation": ["all", "hotel"],
          "arrayOfExcludedSearchType": ["street"],
          "highPrice": "3000000",
          "lowPrice": "0",
          "currency": "INR",
          "rid": 0
        },
        "preloaderList": []
      }
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    print('Status Code: ${response.statusCode}');
    print('Response: ${response.body}');

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 && decoded["status"] == true) {
      return SearchModel.fromJson(decoded);
    } else {
      throw Exception(decoded["message"] ?? "Failed to load hotels");
    }
  }
}
