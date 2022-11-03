import 'package:despesas_pessoais/components/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function(String) removeTransaction;

  TransactionList({
    required this.removeTransaction ,
    required this.transactions,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty 
    ? layoutBuilder()
    : listViewBuilder();
  }

  Widget layoutBuilder(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children:[
            const SizedBox(height: 20),
            Text("Nenhuma Transacao Cadastrada!", style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 20),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover),
            )
          ]
        );
      },
    );
  }

  Widget listViewBuilder(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: transactions.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
          return TransactionItem(transaction: transaction, onRemove: removeTransaction,  key: GlobalObjectKey(transaction));
          // return Card(
          //   elevation: 5,
          //   margin: const EdgeInsets.symmetric(
          //     vertical: 8,
          //     horizontal: 5,
          //   ),
          //   child: TransactionItem(onRemove: removeTransaction, transaction: transaction, key: ValueKey(transaction.id),)
          // );
        },
      );
    }


}