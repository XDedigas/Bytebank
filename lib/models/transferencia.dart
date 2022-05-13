import 'contato.dart';

class Transferencia {
  final double? valor;
  final Contato contato;

  Transferencia(
    this.valor,
    this.contato,
  );

  Transferencia.fromJson(Map<String, dynamic> json)
      : valor = json['value'],
        contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'value': valor,
        'contact': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transferencia{valor: $valor, contato: $contato}';
  }
}
