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

  void _submit(){
    if(_amountController.text.isEmpty) return;

    final tx = TransactionModel(amount: double.parse(_amountController.text), category: _category, date: _selectedDate, note: _noteController.text, type: _type);

    Provider.of<TransactionProvider>(context,listen:false).addTransaction(tx);

    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsGeometry.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add Transaction", style: TextStyle(fontSize: 20)),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),

            DropdownButton<String>(
              value: _type,
              items: ['income', 'expense']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _type = val!),
            ),

            DropdownButton<String>(
              value: _category,
              items: ['Food', 'Travel', 'Shopping', 'Bills']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _category = val!),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${_selectedDate.toLocal()}".split(' ')[0]),
                TextButton(
                  child: Text("Pick Date"),
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
                )
              ],
            ),

            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: "Note"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: _submit,
              child: Text("Add"),
            ),
              
            
          ],
        ),
      ),
      
      );
  }
}