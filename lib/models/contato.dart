class Contato {
  final String nome;
  final int numero;

  Contato(
    this.nome,
    this.numero,
  );

  @override
  String toString() {
    return 'Contato{nome: $nome, numero: $numero}';
  }

  Contato.fromJson(Map<String, dynamic> json)
      : nome = json['name'],
        numero = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': nome,
        'accountNumber': numero,
      };
}
