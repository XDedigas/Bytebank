import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // ignore: avoid_print
    print('Request');
    // ignore: avoid_print
    print('url: ${data.url}');
    // ignore: avoid_print
    print('headers: ${data.headers}');
    // ignore: avoid_print
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // ignore: avoid_print
    print('Response');
    // ignore: avoid_print
    print('status code: ${data.statusCode}');
    // ignore: avoid_print
    print('headers: ${data.headers}');
    // ignore: avoid_print
    print('body: ${data.body}');
    return data;
  }
}
