import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './components/transaction_list.dart';
import 'components/chart.dart';
import 'components/transaction_form.dart';
import 'models/transaction.dart';
 
main() => runApp(ExpensesApp());
 
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
 
    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.black,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];
  bool _showChart = false;

  List<Transaction> get recentTransactions{
    return transactions.where(
      (element){
        return element.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7)
      ));
     }
    ).toList();
  }
 
  void addTransaction(String title, double value, DateTime dateTime) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: dateTime
    );
 
    setState(() {
      transactions.add(newTransaction);
    });
 
    Navigator.of(context).pop();
  }
 
  void openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmitted: addTransaction,);
      },
    );
  }

  void removeTransaction(String id){
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
    
  }


  final appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(),
                if(_showChart || !isLandscape )
                  SizedBox(
                  height: (MediaQuery.of(context).size.height * (isLandscape ? 0.70 : 0.30)),
                  child: Chart(recentTransaction: recentTransactions)
                ),
                if(!_showChart|| !isLandscape)
                  SizedBox(
                  height: MediaQuery.of(context).size.height * (isLandscape ? 1 : 0.70),
                  child: TransactionList(transactions: transactions, removeTransaction: removeTransaction,)
                ),
              ],
          ),
       ),
    );


    return Platform.isIOS
      ?CupertinoPageScaffold(
        navigationBar: 
           CupertinoNavigationBar(
            middle: const Text('Despesas Pessoais', style: TextStyle(color: Colors.black),),
            trailing: 
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLandscape 
                  ? GestureDetector(
                    onTap:(() => setState(() => _showChart = !_showChart)),
                    child: _showChart ? const Icon(Icons.list) : const Icon(Icons.bar_chart),
                  )
                  : Container(),
                   GestureDetector(
                    onTap:() => openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                  )
                ],
              )
          ),
        child: bodyPage
      )
      : Scaffold(
        appBar: AppBar(
          title: const Text('Despesas Pessoais'),
          actions: <Widget>[
          if(isLandscape) 
            IconButton(
              icon: _showChart ? const Icon(Icons.list) : const Icon(Icons.bar_chart),
              onPressed: (() {
                setState(() => _showChart = !_showChart);
              }),
            )
          ],
        ),
        body: bodyPage,
        floatingActionButton: Platform.isIOS
        ? Container()
        : FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => openTransactionFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ); 
  }
}