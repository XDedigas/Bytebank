import 'package:bytebank/screens/contato/lista.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const String _tituloAppBar = 'Dashboard';
  static const String _tituloContainerContatos = 'Contatos';
  static const String _tituloContainerTransf = 'Transferências';
  static const String _pathImageBank = 'images/bytebank_logo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(_pathImageBank),
          ),
          Row(
            children: <Widget>[
              _FeatureItem(_tituloContainerContatos, Icons.people,
                  onClick: () => _showListaContatos(context)),
              _FeatureItem(_tituloContainerTransf, Icons.monetization_on,
                  onClick: () => _showListaTransferencias(context)),
            ],
          ),
        ],
      ),
    );
  }

  void _showListaContatos(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ListaContatos(),
    ));
  }

  void _showListaTransferencias(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ListaTransferencias(),
    ));
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 150,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
