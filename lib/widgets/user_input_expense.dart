import 'package:expense_tracker/models/expense_model.dart';
//import 'package:expense_tracker/widgets/expenses.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class InputExpense extends StatefulWidget {
  const InputExpense({super.key, required this.onAddExpenses});

  final void Function(Expense expense) onAddExpenses;

  @override
  State<InputExpense> createState() {
    return _InputExpenseState();
  }
}

class _InputExpenseState extends State<InputExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  CategoryType _selectedCategory = CategoryType.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); // tryParse(hello)=> null, tryParse("1.12")=>1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('INVALID INPUT'),
                content: const Text('Please Enter Valid Data'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('OK'))
                ],
              ));
      return;
      // SHOW ERROR MESSAGE
    }
    widget.onAddExpenses(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
          18,
          52,
          18,
          15,
        ),
        child: Column(children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: 'KES ', label: Text("Amount")),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                      onPressed: _presentDatePicker,
                      iconSize: 40,
                      icon: const Icon(Icons.calendar_month_sharp))
                ],
              )),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: CategoryType
                      .values // displays all values that make up the enum
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _selectedCategory = value;
                    });

                    print(value);
                  }),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: _submitExpenseData,
              child: const Text('SAVE DATA INPUT')),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                print("Editing Cancelled");
              },
              child: const Text("CANCEL"))
        ]));
  }
}
