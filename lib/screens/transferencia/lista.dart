import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';
import '../../components/centered_message.dart';
import '../../http/webclients/transferencia_webclient.dart';

const _tituloAppBar = 'Transferências';

// ignore: use_key_in_widget_constructors
class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListaTransferenciasState();
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  final TransferenciaWebClient _webClient = TransferenciaWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: FutureBuilder<List<Transferencia>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transferencia> transferencias =
                    snapshot.data as List<Transferencia>;
                if (transferencias.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transferencias.length,
                    itemBuilder: (context, indice) {
                      final transferencia = transferencias[indice];
                      return ItemTransferencia(transferencia);
                    },
                  );
                }
              }
              return CenteredMessage(
                'Nenhuma transferência encontrada!',
                icon: Icons.warning,
              );
          }
          return CenteredMessage(
            'Unknown error',
            icon: Icons.error,
          );
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.contato.numero.toString()),
    ));
  }
}
