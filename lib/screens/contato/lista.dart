import 'package:flutter/material.dart';
import '../../components/progress.dart';
import '../../database/dao/contato_dao.dart';
import '../../models/contato.dart';
import '../transferencia/formulario.dart';
import 'formulario.dart';

const _tituloAppBar = 'Contatos';

// ignore: use_key_in_widget_constructors
class ListaContatos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaContatosState();
  }
}

// ignore: use_key_in_widget_constructors
class ListaContatosState extends State<ListaContatos> {
  final ContatoDao _dao = ContatoDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: FutureBuilder<List<Contato>>(
          initialData: const [],
          future: _dao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contato> _contatos = snapshot.data as List<Contato>;
                return ListView.builder(
                  itemCount: _contatos.length,
                  itemBuilder: (context, indice) {
                    final contato = _contatos[indice];
                    return ItemContato(contato, onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              FormularioTransferencia(contato),
                        ),
                      );
                    });
                  },
                );
            }
            return const Text('Error');
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioContato(),
            ),
          ).then((value) {
            setState(() {
              widget.createState();
            });
          });
        },
      ),
    );
  }
}

class ItemContato extends StatelessWidget {
  final Contato _contatos;
  final Function onClick;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ItemContato(this._contatos, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () => onClick(),
      leading: const Icon(Icons.contact_phone),
      title: Text(_contatos.nome.toString()),
      subtitle: Text(_contatos.numero.toString()),
    ));
  }
}
