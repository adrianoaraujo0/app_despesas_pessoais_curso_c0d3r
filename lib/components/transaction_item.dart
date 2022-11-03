import 'dart:math';

import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {


  final Transaction transaction;
  final void Function(String) onRemove;

  const TransactionItem({
    required this.transaction,
    required this.onRemove,
    super.key
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: listTile(widget.transaction, context)
    );
  }

Widget listTile(Transaction transaction, BuildContext context){
  return  ListTile(
    leading: circleAvatar(transaction),
    title: Text(
      transaction.title, 
      style: Theme.of(context).textTheme.headline6
    ),
    subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
    trailing: MediaQuery.of(context).size.width < 412
    ? IconButton(
        color: Theme.of(context).errorColor,
        icon: const Icon(Icons.delete),
        onPressed: (){
          widget.onRemove(transaction.id);
        }
      )
    : TextButton(onPressed: () {} ,child: const Text("Excluir"))
  ); 
}

Widget circleAvatar(Transaction transaction){
  return CircleAvatar(
    backgroundColor: _backgroundColor,
    radius: 30,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: FittedBox(
        child: Text("R\$${transaction.value}")
      ),
    ),
  );
}
}