import 'dart:convert';
import 'package:restaurant_app/data/detail_restaurant.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:http/http.dart' as http;

import '../search_result.dart';

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev";
  static final String _list = "/list";
  static final String _detail = "/detail/";
  static final String _search = "/search?q=";

  Future<Result> getListRestaurant() async {
    final response = await http.get(_baseUrl + _list);
    if (response.statusCode == 200) {
      final result = Result.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    final response = await http.get(_baseUrl + _detail + id);
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to detail');
    }
  }

  Future<SearchResult> searchRestaurant(String query) async {
    final response = await http.get(_baseUrl + _search + query);
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search');
    }
  }
}
