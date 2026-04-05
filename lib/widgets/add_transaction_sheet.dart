import 'package:flutter/material.dart';
import 'package:my_money/models/transaction_model.dart';
import 'package:my_money/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();


  String _type = 'expense';
  String _category = 'Food';

  DateTime _selectedDate = DateTime.now();

  Map<String, IconData> categoryIcons = {
    'Food': Icons.restaurant,
    'Travel': Icons.flight,
    'Shopping': Icons.shopping_bag,
    'Bills': Icons.receipt,
  };

  void _submit(){
    if(_amountController.text.isEmpty) return;

    final tx = TransactionModel(amount: double.parse(_amountController.text), category: _category, date: _selectedDate, note: _noteController.text, type: _type);

    Provider.of<TransactionProvider>(context,listen:false).addTransaction(tx);

    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 255, 239),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Text(
                "Add Transaction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 20),

            
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                
                focusedBorder: OutlineInputBorder(
                  
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2
                  )
                  
                ),
                labelText: "Amount",
                hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  
                ),

              ),
            ),

            SizedBox(height: 16),


            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = 'expense'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == 'expense'
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("Expense" ,style: TextStyle(fontWeight: FontWeight.bold),),),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = 'income'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == 'income'
                            ? Colors.green.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("Income",style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

     
            DropdownButtonFormField<String>(
              value: _category,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(15),

              decoration: InputDecoration(
                labelText: "Category",
                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2
                  )
                ),
                prefixIcon: Icon(Icons.category, color: Colors.black),

                filled: true,
                fillColor: Colors.grey.shade100,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              items: categoryIcons.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.key,
                  child: Row(
                    children: [
                      Icon(entry.value, size: 18),
                      SizedBox(width: 10),
                      Text(entry.key),
                    ],
                  ),
                );
              }).toList(),

              onChanged: (val) => setState(() => _category = val!),
            ),

            SizedBox(height: 16),

            // 📅 Date Picker
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${_selectedDate.toLocal()}".split(' ')[0], style: TextStyle(fontWeight: FontWeight.bold),),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: Text("Pick Date", style: TextStyle(color: Colors.black),),
                  )
                ],
              ),
            ),

            SizedBox(height: 16),

          
            TextField(
              controller: _noteController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2
                  )
                ),
                labelText: "Note",
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

      
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.indigo,
                ),
                onPressed: _submit,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}