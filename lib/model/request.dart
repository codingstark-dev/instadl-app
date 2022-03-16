import 'package:dio/dio.dart';

// or new Dio with a BaseOptions instance.
var options = BaseOptions(
  baseUrl: 'https://api.instavideosave.com',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = Dio(options);

class RequestDio {
  Future<dynamic> allinone(url) async {
    try {
      var response =
          await dio.get('/allinone', options: Options(headers: {'url': url}));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
