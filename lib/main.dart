import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'model/transaction.dart';


void main(){
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final titleController=TextEditingController();
  final amountController=TextEditingController();

  List<Transaction> transaction =[
    // Transaction(id: 't1', title: 'Mount Abu', amount: 2000, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Jaipur', amount: 4000, date: DateTime.now())
  ];
  int cnt=1;
  _addTransaction(String title,double amount){


    print(title);
    print(amount);


   setState(() {

     var tre=Transaction(id: 't$cnt', title: title, amount: amount, date: DateTime.now());
     transaction.add(tre);
     cnt++;
   });
  }
  final _formkey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title:Text('Expence'),),

      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Title"),
            ),

            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              controller: amountController,
              decoration: InputDecoration(hintText: "Amount"),
            ),
            ElevatedButton(onPressed: (){
              print(titleController.text);
              print(amountController.text);
              _addTransaction(titleController.text,double.parse(amountController.text));
            amountController.text="";
            titleController.text="";
              }, child: Text("Submit")),
            Expanded(
              child: ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    title: Text('${transaction[index].title}'),
                    subtitle: Text('${DateFormat.yMd().format(transaction[index].date)}'),
                    leading: Text('${transaction[index].id}'),
                    trailing: Text('${transaction[index].amount}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}