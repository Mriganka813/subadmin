import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subadmin/model/driver.dart';
import 'package:subadmin/services/api_v1.dart';

class Driver {
  Driver();

  // GET ALL DRIVER IN A SERVICE AREA
  Future<List<DriverModel>> getdriver(String serviceAreaId) async {
    serviceAreaId = "6461f3bdc4918d53bf5c1210";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String access_token = prefs.getString('access_token') ?? "";
    Response response = await ApiV1Service.getRequest(
      '/admin/$serviceAreaId/getDrivers',
      token: access_token,
    );
    List<DriverModel> driver = [];
    for (var item in response.data['drivers']) {
      driver.add(DriverModel.fromMap(item));
    }
    print(response.data['drivers']);
    return driver;
  }

  // VERIFY A DRIVER
  Future<void> verifydriver(String driverId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String access_token = prefs.getString('access_token') ?? "";
    Response response = await ApiV1Service.patchRequest(
      '/admin/$driverId/verify?action=VERIFY',
      token: access_token,
    );
  }
}
