import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();

  final _amtcontroller = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (_amtcontroller.text.isEmpty) {
      return;
    }
    final enteredTitle = _titlecontroller.text;
    final enteredAmt = double.parse(_amtcontroller.text);
    if (enteredTitle.isEmpty || enteredAmt <= 0 || _selectedDate == null) {
      return;
    }

    widget.addtx(enteredTitle, enteredAmt, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titlecontroller,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amtcontroller,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? DateFormat.yMd().format(DateTime.now())
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                    ),
                    textColor: Colors.purple,
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Add Transaction',
              ),
              textColor: Colors.purple,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
