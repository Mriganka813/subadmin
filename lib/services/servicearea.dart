import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subadmin/services/api_v1.dart';

import '/model/servicearea.dart';

class Servicearea {
  Servicearea();

  // CREATE SERVICE AREA
  Future<void> createarea(ModalArea area) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String access_token = prefs.getString('access_token') ?? "";
    Response response = await ApiV1Service.postRequest(
      '/serviceareas',
      data: area.toMap(),
      token: access_token,
    );
  }

  // GET SERVICE AREA
  Future<List<String>> getarea() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String access_token = prefs.getString('access_token') ?? "";
    Response response = await ApiV1Service.getRequest(
      '/serviceareas',
      token: access_token,
    );
    List<String> area = [];
    for (var item in response.data['serviceAreas']) {
      area.add(item['_id']);
    }
    return area;
  }
}
