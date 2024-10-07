import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  // String newsUrl = 'https://newsapi.org/';
  // String shopUrl = 'https://student.valuxapps.com/api/';
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json',

        }
    )
    );
  }

  static Future<Response?> getData(
      {required String url, required Map<String, dynamic> query,
        String lang = 'ar',
        String? token,}) async {
    dio?.options.headers =
    {
      'lang':lang,
      'Authorization':token,
    };


    return await dio?.get(
      url,
      queryParameters: query,

    );
  }

  static Future<Response>? postData({
    required String url,
     Map<String, dynamic>? query,
    required Map<String, dynamic> date,
    String lang = 'ar',
    String? token,
}){
    dio?.options.headers =
       {
        'lang':lang,
        'Authorization':token,
      };

    return dio?.post(url,
    queryParameters: query,
      data: date
    );
  }
}
