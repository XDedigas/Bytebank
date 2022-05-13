import 'package:bytebank/components/transferencia_auth_dialog.dart';
import 'package:bytebank/http/webclients/transferencia_webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import '../../models/contato.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloCampoValor = 'Valor';
const _textoBotaoConfirmar = 'Confirmar';
const _keybordType = TextInputType.numberWithOptions(decimal: true);

// ignore: use_key_in_widget_constructors
class FormularioTransferencia extends StatefulWidget {
  final Contato contato;

  // ignore: use_key_in_widget_constructors
  const FormularioTransferencia(this.contato);

  @override
  FormularioTransferenciaState createState() => FormularioTransferenciaState();
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoValor = TextEditingController();
  final TransferenciaWebClient _webClient = TransferenciaWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contato.nome,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contato.numero.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorCampoValor,
                  style: const TextStyle(fontSize: 24.0),
                  decoration:
                      const InputDecoration(labelText: _rotuloCampoValor),
                  keyboardType: _keybordType,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text(_textoBotaoConfirmar),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_controladorCampoValor.text);
                      final transactionCreated =
                          Transferencia(value, widget.contato);
                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransferenciaAuthDialog(
                          onConfirm: (String password) {
                            _save(transactionCreated, password, context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transferencia transactionCreated, String password,
      BuildContext context) async {
    _webClient.save(transactionCreated, password).then((transaction) {
      if (transaction != null) {
        Navigator.pop(context);
      }
    });
  }
}
