import 'package:dio/dio.dart';
import 'package:todos_list/data/data_provider/api_data_provider.dart';

import '../models/device.dart';

class ApiRepository {
  ApiDataProvider _apiDataProvider = ApiDataProvider();

  Future<List<Device>> getDeviceList() async {
    Response response = await _apiDataProvider.getDataList();
    print('Response = ${response.toString()}');

    if (response.statusCode == 200) {
      List<Device> deviceList = [];

      List mapsList = response.data;
      for (var i in mapsList) {
        deviceList.add(
          Device.fromJson(i as Map<String, dynamic>),
        );
      }

      print('Device List = ${deviceList.length}');
      for (var i in deviceList) print(i.toString());

      return deviceList;
    } else {
      throw Exception('Bad Response :: Status code = ${response.statusCode}');
    }
  }
}
