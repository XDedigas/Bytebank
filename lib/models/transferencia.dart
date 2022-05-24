import 'contato.dart';

class Transferencia {
  final String id;
  final double? valor;
  final Contato contato;

  Transferencia(this.id, this.valor, this.contato);

  Transferencia.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        valor = json['value'],
        contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': valor,
        'contact': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transferencia{valor: $valor, contato: $contato}';
  }
}
