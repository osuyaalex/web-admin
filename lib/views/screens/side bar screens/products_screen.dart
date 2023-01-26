import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = 'ProductsScreen';
  const ProductsScreen({Key? key}) : super(key: key);

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
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
              children: [
                _rowHeader('Image', 1),
                _rowHeader('Name', 3),
                _rowHeader('Price', 2),
                _rowHeader('Quantity', 2),
                _rowHeader('Action', 1),
                _rowHeader('View More', 1)
              ]
          )
        ],
      ),
    );
  }
}
