import 'package:flutter/material.dart';

class WithdrawalScreen extends StatelessWidget {
  static const String routeName = 'WithdrawalScreen';
  const WithdrawalScreen({Key? key}) : super(key: key);

  Widget _rowHeader(String text, int num){
    return Expanded(
        flex: num,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade700
              ),
              color: Colors.orange
          ),
          child: Center(child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          )),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Withdrawals',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
              children: [
                _rowHeader('Name', 1),
                _rowHeader('Amount', 3),
                _rowHeader('Bank Name', 2),
                _rowHeader('Bank Account', 2),
                _rowHeader('Email', 1),
                _rowHeader('Phone', 1)
              ]
          )
        ],
      ),
    );
  }
}
