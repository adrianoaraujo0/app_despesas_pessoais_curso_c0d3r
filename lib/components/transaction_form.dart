import 'package:despesas_pessoais/components/adaptative_button.dart';
import 'package:despesas_pessoais/components/adaptative_datepicker.dart';
import 'package:despesas_pessoais/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionForm extends StatefulWidget {
  TransactionForm({required this.onSubmitted, super.key});

  void Function(String, double, DateTime dateTime) onSubmitted;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController valueController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void submitForm(){
    if(valueController.text.isEmpty || titleController.text.isEmpty ){return;}

    widget.onSubmitted(titleController.text, double.parse(valueController.text), selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.fromLTRB(8, 8, 8, 10 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            AdaptativeTextField(
              controller: titleController,
              label: "Título", 
              textInputType: TextInputType.name
            ),
            AdaptativeTextField(
              controller: valueController,
              label: "Valor (R\$)", 
              textInputType: const TextInputType.numberWithOptions(decimal: true)
            ),
            AdaptativeDatePicker(
              selectedDate: selectedDate,
              onDate:(newDate){
                setState(() => selectedDate = newDate);
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(onPressed: submitForm, label: "Nova transação"),
               
              ],
            )
          ],
        ),
      ),
    );
  }
}