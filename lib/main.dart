import 'package:flutter/material.dart';
import 'package:my_money/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_money/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();

  await Hive.openBox("transactionsBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>TransactionProvider()..loadTransactions()),
      ],

      child: MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    )
    
    );
    
    
  }
}