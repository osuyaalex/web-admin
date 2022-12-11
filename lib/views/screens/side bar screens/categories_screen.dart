import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/widget/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = 'CategoriesScreen';
   const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
 dynamic _image;
 String? _fileName;
 late String categoryName;

  uploadCategory()async{
    EasyLoading.show();
    if(_key.currentState!.validate()){
     String imageUrl = await uploadCategoryBannerToStorage(_image);
     _firestore.collection('Categories').doc(_fileName).set({
       'image': imageUrl,
       'Category Name': categoryName
     }).whenComplete((){
       EasyLoading.dismiss();
       setState(() {
         _image = null;
         _key.currentState!.reset();
       });
     });
    } else{
      print('bad');
    }
  }

  uploadCategoryBannerToStorage(image)async{
   Reference ref =  _storage.ref().child('Category Images').child(_fileName!);
   UploadTask uploadTask = ref.putData(image);
   TaskSnapshot snapshot = await uploadTask;
   String downloadUrl = await snapshot.ref.getDownloadURL();
   return downloadUrl;
  }


  _pickImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    setState(() {
      _image = result?.files.first.bytes;
      _fileName = result?.files.first.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Form(
        key: _key,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'category',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            border: Border.all(color: Colors.grey.shade800),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:_image != null ? Image.memory(_image, fit: BoxFit.fill,)
                            :  const Center(
                          child: Text('Upload Category'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple
                          ),
                          onPressed:(){
                            _pickImage();
                          },
                          child: const Text('Upload')
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: SizedBox(
                    width: 120,
                    child: TextFormField(
                      onChanged: (value){
                        categoryName = value;
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Category Name Must Not Be Empty';
                        }else{
                          return null;}

                      },
                      decoration: const InputDecoration(
                          labelText: 'Enter Category Name',
                          hintText: 'Enter Category Name'
                      ),
                    ),
                  )
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple
                    ),
                    onPressed: (){
                      uploadCategory();
                    },
                    child: Text('Save')
                ),
              ],
            ),
            const Divider(
              color:Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text('Categories',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            CategoryWidget()
          ],
        ),
      ),
    );
  }
}
