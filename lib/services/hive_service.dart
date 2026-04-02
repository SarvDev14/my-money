import 'package:hive/hive.dart';
import 'package:my_money/models/transaction_model.dart';

class HiveService {
  Box get box => Hive.box('transactionsBox');

  void addTransaction(TransactionModel tx){
    box.add(tx.toMap());
  }

  List<TransactionModel> getTransactions(){
    return box.values.map((e) => TransactionModel.fromMap(Map.from(e))).toList();
  }

  void deleteTransaction(int index){
    box.deleteAt(index);
  }

  void updateTransaction(int index, TransactionModel tx){
    box.putAt(index, tx.toMap());
  }
}
