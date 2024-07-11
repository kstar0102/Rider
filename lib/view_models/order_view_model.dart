import 'package:flutter/material.dart';
import 'package:uber_josh/services/api_servies.dart';
import '../models/order_model.dart'; // Adjust the import path as needed
import 'package:shared_preferences/shared_preferences.dart';

class OrderViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final OrderModel _order = OrderModel(stopLocation: []);

  String? _errorMessage;
  bool _isFetchSuccessful = false;
  bool _isPostSuccessful = false;

  String? get errorMessage => _errorMessage;
  bool get isFetchSuccessful => _isFetchSuccessful;
  bool get isPostSuccessful => _isPostSuccessful;

  OrderModel get order => _order;

  void setRiderId(int riderId) {
    _order.riderId = riderId;
    notifyListeners();
  }
  
  void setStartLocation(String startLocation) {
    _order.startLocation = startLocation;
    notifyListeners();
  }

  void setPeriod(int period) {
    _order.period = period;
    notifyListeners();
  }

  void setStopLocation(List<String> stopLocation) {
    _order.stopLocation = stopLocation;
    notifyListeners();
  }

  void setCost(double cost) {
    _order.cost = cost;
    notifyListeners();
  }

  void setEndLocation(String endLocation) {
    _order.endLocation = endLocation;
    notifyListeners();
  }

  void setStartAddress(String startAddress){
    _order.startAddress = startAddress;
    notifyListeners();
  }

  void setEndAddress(String endAddress){
    _order.endAddress = endAddress;
    notifyListeners();
  }
  void setRouteDistance(double routeDistance) {
    _order.routeDistance = routeDistance;
    notifyListeners();
  }

  void setArrivedDate(DateTime arrivedDate) {
    _order.arrivedDate = arrivedDate;
    notifyListeners();
  }

  void setStartDate(DateTime startDate) {
    _order.startDate = startDate;
    notifyListeners();
  }

  void setRating(int rating) {
    _order.rating = rating;
    notifyListeners();
  }

  void setEndDate(DateTime endDate) {
    _order.endDate = endDate;
    notifyListeners();
  }

  void setStatus(int status) {
    _order.status = status;
    notifyListeners();
  }

  Future<void> clearLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('order');
    await prefs.remove('token');
  }

  Future<void> orderRequest() async {
    final data = _order.toJson();
    try {
      final result = await _apiService.authData(data, "history_favourite");
      if (result['statusCode'] == 200) {
        _isFetchSuccessful = true;
      } else {
        _isFetchSuccessful = false;
        _errorMessage = result['message'];
      }
    } catch (e) {
      _isFetchSuccessful = false;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}