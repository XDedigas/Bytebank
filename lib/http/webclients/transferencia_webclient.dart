import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    final Response response = await client.get(Uri.http(baseIP, baseMetod));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transferencia.fromJson(json))
        .toList();
  }

  Future<Transferencia> save(Transferencia transf, String password) async {
    final String transferenciaJson = jsonEncode(transf.toJson());

    final Response response = await client.post(Uri.http(baseIP, baseMetod),
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transferenciaJson);

    if (response.statusCode == 200) {
      return Transferencia.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String? _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error!';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Ocorreu erro enviando a transferência!',
    401: 'Ocorreu erro na autenticação da transferência!',
    409: 'Transferência já existe!'
  };
}

class HttpException implements Exception {
  final String? message;
  HttpException(this.message);
}
