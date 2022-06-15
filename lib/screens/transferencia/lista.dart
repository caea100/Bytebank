import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

const _tituloAppBar = 'transferencias';

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
        title: Text(_tituloAppBar),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then((transferenciaRecebida) {
            _atualiza(transferenciaRecebida);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualiza(Transferencia? transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        //*Tudo Oque estiver aqui atualiza no build
        widget._trasnferencias.add(transferenciaRecebida);
      });
    }
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
