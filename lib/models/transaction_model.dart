class TransactionModel {
  final double amount;
  final String  type;
  final String category;
  final DateTime date;
  final String note;


  TransactionModel({
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
    required this.type
  });

  Map<String, dynamic> toMap(){
    return{
      'amount':amount,
      'type':type,
      'date':date.toIso8601String(),
      'note':note,
      'category':category
    }; // the hive needs to convert the object into map in order to store into db
  }

  factory TransactionModel.fromMap(Map<dynamic, dynamic> map){
    return TransactionModel(amount: map['amount'], category: map['category'], date: DateTime.parse(map['date']), note: map['note'], type: map['type']); // wen we need that object, we convert the map converted object into the object again 
  }
}