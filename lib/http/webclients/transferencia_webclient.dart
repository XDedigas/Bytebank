import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    final Response response = await client
        .get(Uri.http(baseIP, baseMetod))
        .timeout(const Duration(seconds: 5));
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

    return Transferencia.fromJson(jsonDecode(response.body));
  }
}
