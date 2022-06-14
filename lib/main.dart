import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';

void main() => runApp(Bytebank());

class Bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(secondary: Colors.black)
      ),
      home: ListaTrasferencias(),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criando trasferencia'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                controlador: _controladorCampoNumeroConta,
                dica: '000',
                rotulo: 'Numero da Conta',
              ),
              Editor(
                controlador: _controladorCampoValor,
                dica: '0.00',
                rotulo: 'valor',
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text('Confirmar'),
                onPressed: () => _criaTransferencia(context),
              )
            ],
          ),
        ));
  }

/*
*Não sei oq deu mas pra cirar metodo sem VOID e sim _nomedometodo
 */
  _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  const Editor({
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
  });

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;
  //* Quando não se porde ser NULL tem q por a interrogação
  /*
       * *icon: icone != null ? Icon(icone) : null */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTrasferencias extends StatefulWidget {
  //*de stateless para statefull

  final List<Transferencia> _trasnferencias = []; //* Cria uma lista zerada
//*coisa muito dinamica fica aqui
  @override
  State<StatefulWidget> createState() {
    return ListaTrasferenciasState();
  }
}

class ListaTrasferenciasState extends State<ListaTrasferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._trasnferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._trasnferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
            if (transferenciaRecebida != null) {
              setState(() {
                //*Tudo Oque estiver aqui atualiza no build
                widget._trasnferencias.add(transferenciaRecebida);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;
  Transferencia(
    this.valor,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
