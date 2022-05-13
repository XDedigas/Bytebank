import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';

import '../../database/dao/contato_dao.dart';

const _tituloAppBar = 'Criando Contato';
const _rotuloNome = 'Nome completo';
const _rotuloNomeDica = "José da Silva";
const _rotuloNumero = 'Número de contato';
const _rotuloNumeroDica = "(47) 99200-0000";
const _textoBotaoConfirmar = 'Confirmar';

const _keybordType = TextInputType.number;

// ignore: use_key_in_widget_constructors
class FormularioContato extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioContatoState();
  }
}

class FormularioContatoState extends State<FormularioContato> {
  final TextEditingController _controladorCampoNumero = TextEditingController();
  final TextEditingController _controladorCampoNome = TextEditingController();
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoNome,
                dica: _rotuloNomeDica,
                rotulo: _rotuloNome,
              ),
              Editor(
                dica: _rotuloNumeroDica,
                controlador: _controladorCampoNumero,
                rotulo: _rotuloNumero,
                keybord: _keybordType,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      child: const Text(_textoBotaoConfirmar),
                      onPressed: () {
                        _dao
                            .save(_criaContato(context))
                            .then((id) => Navigator.pop(context));
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  Contato _criaContato(BuildContext context) {
    final int? numero = int.tryParse(_controladorCampoNumero.text);
    final String nome = _controladorCampoNome.text;
    List<int> lista = [];
    lista.contains(0);
    if (numero != null && nome != "") {
      return Contato(nome, numero);
    } else {
      throw Exception('Erro ao armazenar informações do contato');
    }
  }
}
