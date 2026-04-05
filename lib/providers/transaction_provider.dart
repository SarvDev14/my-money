import 'package:flutter/cupertino.dart';
import 'package:my_money/models/transaction_model.dart';
import 'package:my_money/services/hive_service.dart';

class TransactionProvider extends ChangeNotifier{
  final HiveService _service = HiveService();

  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  double getThisWeekExpense() {
    final now = DateTime.now();
    final startOfWeek = _startOfWeek(now);

    return _transactions
        .where((tx) =>
            tx.type == 'expense' && tx.date.isAfter(startOfWeek))
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double getLastWeekExpense() {
    final now = DateTime.now();
    final startOfThisWeek = _startOfWeek(now);
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
    final startOfWeek = _startOfWeek(now);

    return _transactions
        .where((tx) =>
            tx.type == 'income' && tx.date.isAfter(startOfWeek))
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double getLastWeekIncome() {
    final now = DateTime.now();
    final startOfThisWeek = _startOfWeek(now);
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

    // Start of week (Monday)
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday - 1),
    );

    // End of week (Sunday)
    final endOfWeek = startOfWeek.add(Duration(days: 7));

    List<double> weekly = List.filled(7, 0);

    for (var tx in _transactions) {
      if (tx.type == 'expense') {
        if (!tx.date.isBefore(startOfWeek) &&
            tx.date.isBefore(endOfWeek)) {

          int index = tx.date.weekday - 1;
          weekly[index] += tx.amount;
        }
      }
    }

    return weekly;
  }
  // utility for start of the week
  DateTime _startOfWeek(DateTime date) {
    final d = DateTime(date.year, date.month, date.day); // removes time
    return d.subtract(Duration(days: d.weekday - 1));
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