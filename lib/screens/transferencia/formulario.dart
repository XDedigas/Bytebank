import 'dart:async';

import 'package:bytebank/components/transferencia_auth_dialog.dart';
import 'package:bytebank/http/webclients/transferencia_webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../components/progress.dart';
import '../../components/response_dialog.dart';
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
  final String transferenciaId = const Uuid().v4();
  bool _sending = false;

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
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Enviando...'),
                ),
                visible: _sending,
              ),
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
                          Transferencia(transferenciaId, value, widget.contato);
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
    await _send(transactionCreated, password, context);
  }

  Future<void> _showSuccesDialog(
      Transferencia transf, BuildContext context) async {
    if (transf != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transferência concluída!');
          });
      Navigator.pop(context);
    }
  }

  Future<void> _send(Transferencia transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });
    try {
      final Transferencia transf =
          await _webClient.save(transactionCreated, password);
      _showSuccesDialog(transf, context);
    } on TimeoutException catch (e) {
      FirebaseCrashlytics.instance
          .setCustomKey('timeoutException', e.toString());
      FirebaseCrashlytics.instance
          .setCustomKey('http_body', transactionCreated.toString());
      FirebaseCrashlytics.instance.recordError(
          'Erro: $e Mensagem: timeout ao enviar uma transferência!', null);
      _showFailureMessage(context,
          message: 'timeout ao enviar uma transferência!');
    } on HttpException catch (e) {
      FirebaseCrashlytics.instance.setCustomKey('httpException', e.toString());
      FirebaseCrashlytics.instance
          .setCustomKey('http_statusCode', e.statusCode.toString());
      FirebaseCrashlytics.instance
          .setCustomKey('http_body', transactionCreated.toString());
      FirebaseCrashlytics.instance.recordError(e, null);
      _showFailureMessage(context, message: e.message.toString());
    } on Exception catch (e) {
      FirebaseCrashlytics.instance.setCustomKey('exception', e.toString());
      FirebaseCrashlytics.instance
          .setCustomKey('http_body', transactionCreated.toString());
      FirebaseCrashlytics.instance.recordError(e, null);
      _showFailureMessage(context);
    } finally {
      setState(() {
        _sending = false;
      });
    }
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknow error!'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
