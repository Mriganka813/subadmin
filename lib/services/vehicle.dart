import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subadmin/model/vehicle.dart';
import 'package:subadmin/services/api_v1.dart';

class Vehical {
  Vehical();

  // CREATE VEHICLE
  Future<void> createarea(Vehicle area, String serviceAreaID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String access_token = prefs.getString('access_token') ?? "";
    Response response = await ApiV1Service.postRequest(
      '/admin/$serviceAreaID/vehicle',
      data: area.toMap(),
      token: access_token,
    );
  }
}
