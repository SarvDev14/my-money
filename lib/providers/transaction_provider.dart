import 'package:flutter/cupertino.dart';
import 'package:my_money/models/transaction_model.dart';
import 'package:my_money/services/hive_service.dart';

class TransactionProvider extends ChangeNotifier{
  final HiveService _service = HiveService();

  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  void loadTransactions(){
    _transactions = _service.getTransactions();
    notifyListeners(); 
  }

  void addTransaction(TransactionModel tx){
    _service.addTransaction(tx);
    loadTransactions();

  }

  void deleteTransaction(int index){
    _service.deleteTransaction(index);
    loadTransactions();
  }
}