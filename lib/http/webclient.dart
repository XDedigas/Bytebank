import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);
const String baseIP = '192.168.100.7:8080';
const String baseMetod = 'transactions';
