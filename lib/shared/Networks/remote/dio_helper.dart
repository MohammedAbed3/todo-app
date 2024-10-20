import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  // String newsUrl = 'https://newsapi.org/';
  // String shopUrl = 'https://student.valuxapps.com/api/';
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,


    )
    );
  }

  static Future<Response?> getData(
      {required String url,  Map<String, dynamic>? query,
        String lang = 'en',
        String? token,}) async {
    dio?.options.headers =
    {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };


    return await dio?.get(
      url,
      queryParameters: query,

    );
  }

  static Future<Response>? postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    if (dio == null) {
      throw Exception('Dio is not initialized');
    }

    dio?.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio!.post(
        url,
        queryParameters: query,
        data: data,
      );

      print('Response data: ${response.data}');  // طباعة البيانات المستلمة للتحقق من صحتها
      return response;
    } catch (error) {
      print('Error during post request: $error');
      throw error;
    }
  }

}
