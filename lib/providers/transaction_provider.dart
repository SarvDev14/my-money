import 'package:flutter/cupertino.dart';
import 'package:my_money/models/transaction_model.dart';
import 'package:my_money/services/hive_service.dart';

class TransactionProvider extends ChangeNotifier{
  final HiveService _service = HiveService();

  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  double getThisWeekExpense() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return _transactions
        .where((tx) =>
            tx.type == 'expense' && tx.date.isAfter(startOfWeek))
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double getLastWeekExpense() {
    final now = DateTime.now();
    final startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfLastWeek = startOfThisWeek.subtract(Duration(days: 7));

    return _transactions
        .where((tx) =>
            tx.type == 'expense' &&
            tx.date.isAfter(startOfLastWeek) &&
            tx.date.isBefore(startOfThisWeek))
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double getThisWeekIncome() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return _transactions
        .where((tx) =>
            tx.type == 'income' && tx.date.isAfter(startOfWeek))
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double getLastWeekIncome() {
    final now = DateTime.now();
    final startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfLastWeek = startOfThisWeek.subtract(Duration(days: 7));

    return _transactions
        .where((tx) =>
            tx.type == 'income' &&
            tx.date.isAfter(startOfLastWeek) &&
            tx.date.isBefore(startOfThisWeek))
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  // getting categories
  Map<String, double> getCategoryTotals() {
    Map<String, double> data = {};

    for (var tx in _transactions) {
      if (tx.type == 'expense') {
        data[tx.category] =
            (data[tx.category] ?? 0) + tx.amount;
      }
    }

    return data;
  }

  List<double> getWeeklyExpenses() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    List<double> weekly = List.filled(7, 0);

    for (var tx in _transactions) {
      if (tx.type == 'expense') {
        if (tx.date.isAfter(startOfWeek)) {
          int index = tx.date.weekday - 1; // Mon=0 ... Sun=6
          weekly[index] += tx.amount;
        }
      }
    }

    return weekly;
  }

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