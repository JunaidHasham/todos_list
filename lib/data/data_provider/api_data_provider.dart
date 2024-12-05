import 'package:dio/dio.dart';

class ApiDataProvider {
  Future<Response> getDataList() async {
    Dio dio = Dio(
      BaseOptions(
        responseType: ResponseType.json,
      ),
    );

    Response response = await dio.get('https://api.restful-api.dev/objects');

    return response;
  }
}
