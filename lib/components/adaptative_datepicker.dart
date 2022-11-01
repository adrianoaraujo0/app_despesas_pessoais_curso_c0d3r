import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {

  DateTime selectedDate = DateTime.now();
  Function (DateTime) onDate;

  AdaptativeDatePicker({
    required this.selectedDate,
    required this.onDate,
    super.key
  });

  buildShowDatePicker(BuildContext context) async{
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then(((pickedDate){
          if(pickedDate == null){return;}

          onDate(pickedDate);
          // setState(() {selectedDate = pickedDate;});
        }
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ? Container(
      height: 180,
      child: CupertinoDatePicker(
      onDateTimeChanged: onDate,
      mode: CupertinoDatePickerMode.date,
      initialDateTime: DateTime.now(),
      minimumDate: DateTime(2019),
      maximumDate: DateTime.now(),
      ),
    )
    : SizedBox(
      height: 70,
      child: Row(
        children: [
            Expanded(
              child: Text("Data selecionada: ${DateFormat("dd/MM/y").format(selectedDate)}"
              ),
            ),
          TextButton(
            onPressed: ()=>buildShowDatePicker(context), 
            child: const Text("Selecionar data", 
            style: TextStyle(
              fontWeight: FontWeight.w700
            ),)
          ),
        ],
      ),
    );
  }
}