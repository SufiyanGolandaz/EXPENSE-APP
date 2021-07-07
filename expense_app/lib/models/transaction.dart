import 'package:flutter/material.dart';

class Transaction {
  String id;
  DateTime date;
  double amount;
  String title;
  Transaction(
      {@required this.id,
      @required this.date,
      @required this.amount,
      @required this.title});
}
