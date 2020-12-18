import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service..dart';
import 'package:restaurant_app/data/detail_restaurant.dart';
import 'package:restaurant_app/data/search_result.dart';

import '../data/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService});

  Result _result;
  String _message = '';
  ResultState _state;
  SearchResult _search =
      SearchResult(error: false, founded: 0, restaurants: []);
  DetailRestaurant _detail;
  String get message => _message;
  Result get result => _result;
  DetailRestaurant get detail => _detail;
  SearchResult get search => _search;
  ResultState get state => _state;

  Future<void> fetchAllRestaurant() async {
    try {
      final response = await apiService.getListRestaurant();
      if (response.restaurants.length == 0) {
        _state = ResultState.NoData;
        _message = 'Tidak ada data disajikan';
      } else {
        _state = ResultState.HasData;
        _result = response;
      }
    } on SocketException catch (_) {
      _state = ResultState.Error;
      _message = 'Tidak terdapat koneksi internet';
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
    }
    notifyListeners();
  }

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      final response = await apiService.getDetailRestaurant(id);
      if (response.restaurant == null) {
        _state = ResultState.NoData;
        _message = 'Tidak ada data disajikan';
      } else {
        _state = ResultState.HasData;
        _detail = response;
      }
    } on SocketException catch (_) {
      _state = ResultState.Error;
      _message = 'Tidak terdapat koneksi internet';
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
    }
    notifyListeners();
  }

  Future<void> fetchSearchRestaurant(String query) async {
    try {
      final response = await apiService.searchRestaurant(query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'Tidak ada data disajikan';
      } else {
        _state = ResultState.HasData;
        _search = response;
      }
    } on SocketException catch (_) {
      _state = ResultState.Error;
      _message = 'Tidak terdapat koneksi internet';
    } on NoSuchMethodError {
      _state = ResultState.Error;
      _message = 'Tidak terdapat data untuk disajikan';
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
    }
    notifyListeners();
  }
}
