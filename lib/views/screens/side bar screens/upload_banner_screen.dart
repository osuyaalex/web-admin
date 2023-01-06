import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/widget/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = 'UploadBannerScreen';
   const UploadBannerScreen({Key? key}) : super(key: key);

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  dynamic _image;
  String? _fileName;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  pickImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
    );

      setState(() {
        _image = result?.files.first.bytes;
        _fileName = result?.files.first.name;
      });
  }

  uploadBannersToStorage(image)async{
                                         // name of folder     name of image
    Reference ref = _firebaseStorage.ref().child('Banners').child(_fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFireStore()async{
    EasyLoading.show();
    if(_image != null){
     String imageUrl = await uploadBannersToStorage(_image);
     await _firestore.collection('Banners').doc(_fileName).set({
       'image': imageUrl
     }).whenComplete((){
       EasyLoading.dismiss();
       setState(() {
         _image = null;
       });
     } );
    }
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
              'Banner',
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
                      child:  Center(
                        child: _image != null ? Image.memory(_image, fit: BoxFit.fill,)
                            :const Text('Upload Banners'),
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
                          pickImage();
                        },
                        child: const Text('Upload')
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple
                ),
                  onPressed: (){
                  uploadToFireStore();
                  },
                  child: Text('Save')
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text('Banner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
          ),
          BannerWidget()
        ],
      ),
    );
  }
}
