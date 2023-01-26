import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorWidget extends StatelessWidget {
  VendorWidget({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _vendorsStream = FirebaseFirestore.instance.collection('vendors').snapshots();
  Widget vendorData(int? flex, Widget widget){
    return Expanded(
      flex: flex!,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey
            )
          ),
          child:widget,
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _vendorsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
            final vendorUserData = snapshot.data!.docs[index];
            return  Row(
              children: [
                vendorData(
                    1,
                    Container(
                        height: 50,
                        width: 50,
                        child: Image.network(vendorUserData['image'])
                    )
                ),
                vendorData(
                    3,
                     Text(vendorUserData['businessName'], style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                vendorData(
                    2,
                    Text(vendorUserData['city'], style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                vendorData(
                    2,
                    Text(vendorUserData['state'], style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                vendorData(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ElevatedButton(
                          onPressed: (){},
                          child: Text('Reject', style: TextStyle(fontWeight: FontWeight.bold),)

                      ),
                    )
                ),
                vendorData(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ElevatedButton(
                          onPressed: (){},
                          child: Text('View More', style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                    )
                ),
              ],
            );
            }
        );
      },
    );



  }
}
