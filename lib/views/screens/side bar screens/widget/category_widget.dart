import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
   CategoryWidget({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _categoriesStream = FirebaseFirestore.instance.collection('Categories').snapshots();
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              mainAxisSpacing: 7,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index){

            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(snapshot.data!.docs[index]['image']),
                ),
                Text(snapshot.data!.docs[index]['Category Name'])
              ],
            );
            }
        );
      },
    );
  }
}
