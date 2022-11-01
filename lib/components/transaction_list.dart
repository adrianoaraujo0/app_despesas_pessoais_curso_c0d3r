import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function(String) removeTransaction;
  TransactionList({
    required this.removeTransaction ,
    required this.transactions,
    super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty 
    ? LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children:[
            const SizedBox(
              height: 20,
            ),
            Text(
              "Nenhuma Transacao Cadastrada!",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                "assets/images/waiting.png",
                fit:  BoxFit.cover,
                )
            )
          ]
        );
      },
    ) 
    : ListView.builder(
      shrinkWrap: true,
      itemCount: transactions.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        print(MediaQuery.of(context).size.width);
        final transaction = transactions[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text("R\$${transaction.value}")
                  ),
                ),
              ),
              title: Text(
                transaction.title, 
                style: Theme.of(context).textTheme.headline6
              ),
              subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
              trailing: MediaQuery.of(context).size.width < 412
              ?  IconButton(
                  color: Theme.of(context).errorColor,
                  icon: const Icon(Icons.delete),
                  onPressed: (){
                    removeTransaction(transaction.id);
                  }
                )
              : TextButton(onPressed: () {} ,child: const Text("Excluir"))
            ),
          );
      },
    );
  }
}