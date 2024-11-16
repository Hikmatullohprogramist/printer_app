import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:printer_app/models/items.dart';
import 'package:printer_app/models/kassa_cheki.dart';

class ApiService {
  final Dio _dio;
  static const String _baseUrl = "https://dev.food.sayidmuhammad.uz/";
  static const String _itemsEndpoint = "api/items";
  static const String _completeOrderEndpoint = "api/orders/completed";
  static const String _tokenEndpoint = "csrf-token";

  ApiService({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = _baseUrl;
    _setAuthorizationHeader();
  }

  Future<ItemsModel> fetchItems() async {
    return await _getJson<ItemsModel>(
        _itemsEndpoint, (data) => ItemsModel.fromJson(data));
  }

  Future<void> completeCheck(List<int> items) async {
    var body = {"orderItemIds": items};
    try {
      await _dio.post(_completeOrderEndpoint, data: body);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<KassaChekiModel> kassaCheki() async {
    return await _postJson<KassaChekiModel>(
        _completeOrderEndpoint, (data) => KassaChekiModel.fromJson(data));
  }

  Future<void> getToken() async {
    try {
      final response = await _dio.get(_tokenEndpoint);
      if (response.statusCode == 200) {
        await saveToken(response.data["token"]);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> saveToken(String token) async {
    try {
      var authBox = Hive.box('authBox');
      await authBox.put('token', token);
      if (kDebugMode) {
        print("Token successfully saved.");
      }
    } catch (e) {
      print("Error saving token $e");
    }
  }

  void _setAuthorizationHeader() {
    var token = Hive.box('authBox').get('token');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      if (kDebugMode) {
        print("TOKEN ADDED");
      }
    } else {
      _dio.options.headers.remove('Authorization');
      if (kDebugMode) {
        print("Removed TOKEN");
      }
    }
  }

  Future<T> _getJson<T>(String endpoint, T Function(dynamic) fromJson) async {
    try {
      final response = await _dio.get(endpoint);
      if (response.statusCode == 200) {
        return fromJson(response.data);
      } else {
        _handleError();
      }
    } catch (e) {
      _handleError(e);
    }
    throw Exception("Error getting data");
  }

  Future<T> _postJson<T>(String endpoint, T Function(dynamic) fromJson) async {
    try {
      final response = await _dio.post(endpoint);
      if (response.statusCode == 200) {
        return fromJson(response.data);
      } else {
        _handleError();
      }
    } catch (e) {
      _handleError(e);
    }
    throw Exception("Error getting data");
  }

  void _handleError([dynamic error]) {
    print("Error: $error");
  }
}
