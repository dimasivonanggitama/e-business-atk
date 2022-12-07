// import 'package:ebusiness_atk_mobile/views/components/textField.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ebusiness_atk_mobile/views/components/custom_button.dart';
// import 'package:ebusiness_atk_mobile/views/components/preset_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '/views/components/custom_button.dart';
import '/views/components/preset_textField.dart';

class ProdukFormField extends StatefulWidget {
  // const produkFormField({Key? key}) : super(key: key);

  final String title;
  final String buttonText;
  var passingSnapshot;
  final int currentIndex;

  ProdukFormField({
    required this.title, 
    required this.buttonText, 
    this.passingSnapshot, 
    required this.currentIndex
  });

  @override
  State<ProdukFormField> createState() => _ProdukFormFieldState();
}

class _ProdukFormFieldState extends State<ProdukFormField> {
  final TextEditingController namaProdukController = TextEditingController();
  final TextEditingController merekProdukController = TextEditingController();
  final TextEditingController kategoriProdukController = TextEditingController();
  final TextEditingController jumlahStokController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  
  File? image;
  String imagePath = '';
  XFile? imagePicked;
  var selectedDropdown;
  
  Color currentNamaProdukTextFieldOutlineColor = Colors.black;
  Color currentMerekProdukTextFieldOutlineColor = Colors.black;
  Color currentDropdownOutlineColor = Colors.black;
  Color currentJumlahStokTextFieldOutlineColor = Colors.black;
  Color currentHargaTextFieldOutlineColor = Colors.black;
  Color currentImageBoxBorderColor = Colors.black;

  double currentNamaProdukTextFieldOutlineWidth = 1;
  double currentMerekProdukTextFieldOutlineWidth = 1;
  double currentDropdownOutlineWidth = 1;
  double currentJumlahStokTextFieldOutlineWidth = 1;
  double currentHargaTextFieldOutlineWidth = 1;
  double currentImageBoxBorderWidth = 1;

  // String currentDropdownValue = "Alat Tulis";
  // String currentDropdownValue = "Z1KMbhGAGxytcXTWi3eG";
  String currentDropdownValue = "0";
  String currentDropdownValueID = "";
  final Stream<QuerySnapshot> _kategoriStream = FirebaseFirestore.instance.collection('kategori').snapshots();


  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference produk_atk = firestore.collection('produk_atk');

    // if (this.passingSnapshot != null) {

    // }
    String gambarProduk = "";

    namaProdukController.text = this.widget.passingSnapshot.data!.docs[this.widget.currentIndex]['namaProduk'];
    merekProdukController.text = this.widget.passingSnapshot.data!.docs[this.widget.currentIndex]['merekProduk'];
    currentDropdownValue = this.widget.passingSnapshot.data!.docs[this.widget.currentIndex]['kategoriProduk'];
    jumlahStokController.text = this.widget.passingSnapshot.data!.docs[this.widget.currentIndex]['jumlahStok'].toString();
    hargaController.text = this.widget.passingSnapshot.data!.docs[this.widget.currentIndex]['harga'].toString();
    gambarProduk = this.widget.passingSnapshot.data!.docs[this.widget.currentIndex]['gambarProduk'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.widget.title),
      ), 
      body: ListView(
        children: [
          // ListView(
          //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          //   children: [
          //   ],
          // )
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: image != null ? Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  // image: image supposed to be here
                  // image: DecorationImage(image: AssetImage('assetName.jpg'))
                ),
                child: Image.file(image!, fit: BoxFit.cover),
              ) 
              : (gambarProduk != "")? Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  // image: image supposed to be here
                  // image: DecorationImage(image: AssetImage('assetName.jpg'))
                ),
                child: Image.network('https://firebasestorage.googleapis.com/v0/b/e-business-atk.appspot.com/o/$gambarProduk?alt=media', fit: BoxFit.cover),
              ) 
              : Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: currentImageBoxBorderColor,
                    width: currentImageBoxBorderWidth
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                color: Colors.grey.shade300, 
                onTap: () async {
                  await getImage();
                  gambarProduk = "";
                },
                text: "Pilih Foto Produk", 
              ),
            ],
          ),
          // PresetTextField(labelText: "Nama Produk", controller: namaProdukController, currentTextFieldOutlineColor: currentNamaProdukTextFieldOutlineColor, currentTextFieldOutlineWidth: currentNamaProdukTextFieldOutlineWidth),
          // PresetTextField(labelText: "Merek Produk", controller: merekProdukController, currentTextFieldOutlineColor: currentMerekProdukTextFieldOutlineColor, currentTextFieldOutlineWidth: currentMerekProdukTextFieldOutlineWidth),

          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: StreamBuilder<QuerySnapshot>(
                stream: _kategoriStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("Data ada yang salah");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: currentDropdownOutlineColor, 
                          width: currentDropdownOutlineWidth
                        )
                      ),
                      labelText: 'Kategori',
                    ),
                    
                    value: currentDropdownValue,
                    items: snapshot.data!.docs.map((value) {
                    
                    return DropdownMenuItem<String>(
                      value: value.get('id'),
                      child: Text(
                        '${value.get('kategori')}',
                        // style: TextStyle(fontSize: 30),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      currentDropdownValue = newValue!;
                      normalDropdownState();
                    });
                  },
                );
              }
            ),
          ),

          // PresetTextField(labelText: "Jumlah Stok", controller: jumlahStokController, currentTextFieldOutlineColor: currentJumlahStokTextFieldOutlineColor, currentTextFieldOutlineWidth: currentJumlahStokTextFieldOutlineWidth),
          // PresetTextField(labelText: "Harga", controller: hargaController, currentTextFieldOutlineColor: currentHargaTextFieldOutlineColor, currentTextFieldOutlineWidth: currentHargaTextFieldOutlineWidth),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                color: Colors.greenAccent.shade700,
                text: this.widget.buttonText,
                onTap: () async {
                  if (currentDropdownValue == '0' || namaProdukController.text == '' || merekProdukController.text == '' || jumlahStokController.text == '' || hargaController.text == '' /*|| image == null*/) {
                    setState(() {
                      if (currentDropdownValue == '0') {
                          unselectedDropdownState();
                      }
                      if (namaProdukController.text == '') {
                        currentNamaProdukTextFieldOutlineColor = Colors.red;
                        currentNamaProdukTextFieldOutlineWidth = 2;
                      } else {
                        currentNamaProdukTextFieldOutlineColor = Colors.black;
                        currentNamaProdukTextFieldOutlineWidth = 1;
                      }
                      if (merekProdukController.text == '') {
                        currentMerekProdukTextFieldOutlineColor = Colors.red;
                        currentMerekProdukTextFieldOutlineWidth = 2;
                      } else {
                        currentMerekProdukTextFieldOutlineColor = Colors.black;
                        currentMerekProdukTextFieldOutlineWidth = 1;
                      }
                      if (jumlahStokController.text == '') {
                        currentJumlahStokTextFieldOutlineColor = Colors.red;
                        currentJumlahStokTextFieldOutlineWidth = 2;
                      } else {
                        currentJumlahStokTextFieldOutlineColor = Colors.black;
                        currentJumlahStokTextFieldOutlineWidth = 1;
                      }
                      if (hargaController.text == '') {
                        currentHargaTextFieldOutlineColor = Colors.red;
                        currentHargaTextFieldOutlineWidth = 2;
                      } else {
                        currentHargaTextFieldOutlineColor = Colors.black;
                        currentHargaTextFieldOutlineWidth = 1;
                      }
                      // if (image == null) {
                      //   currentImageBoxBorderColor = Colors.red;
                      //   currentImageBoxBorderWidth = 2;
                      // } 
                      // else {
                      //   currentImageBoxBorderColor = Colors.black;
                      //   currentImageBoxBorderWidth = 1;
                      // }
                    });
                    print("- - fail to submit");
                  } else {
                    this.widget.passingSnapshot.data!.docs[0].reference.update({
                    // var batch = firestore.batch();
                    // batch.update(this.widget.passingSnapshot.data!.docs[0].reference, {
                      'namaProduk': namaProdukController.text,
                      'merekProduk': merekProdukController.text,
                      // 'kategoriProduk': kategoriProdukController.text,
                      'kategoriProduk': currentDropdownValue,
                      'jumlahStok': int.parse(jumlahStokController.text),
                      'harga': int.parse(hargaController.text),
                      if (image != null) 'gambarProduk': basename(image!.path)
                    });
                    // batch.commit();

                    print('namaProduk:'+ namaProdukController.text);
                    print('merekProduk:'+ merekProdukController.text);
                    // print('kategoriProduk:'+ kategoriProdukController.text);
                    print('kategoriProduk:'+ currentDropdownValue);
                    print('jumlahStok:'+ jumlahStokController.text);
                    print('harga:'+ hargaController.text);
                    if (image != null) print('gambarProduk:'+ basename(image!.path));

                    // namaProdukController.text = '';
                    // merekProdukController.text = '';
                    // kategoriProdukController.text = '';
                    // jumlahStokController.text = '';
                    // hargaController.text = '';

                    // imagePath = await uploadImage(imagePicked);
                    if (image != null) uploadImage(context);
                    // image = null;
                    
                    print("- - Submitted");

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Informasi'),
                        content: const Text('Data produk berhasil di-update.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),

                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          )
        ],
      )
    );
  }

  
  Future getImage() async {
    // await ImagePicker().pickImage(source: ImageSource.gallery);
    final picker = ImagePicker();
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
    
    setState((){
      if (imagePicked != null) {  // if file manager opened and picked any image (not canceled)
        // image = File(imagePicked!.path);
        image = File(imagePicked.path);
        print("- - image path: "+imagePicked.path);
      }
    });
    return imagePicked;
  }

  // Future<XFile?> getImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   image = File(imagePicked!.path);
  //   setState(() {});
  //   return await _picker.pickImage(source: ImageSource.gallery);
  // }




  // Future uploadImage(File imageFile) async {
  //   String fileName = basename(imageFile.path);

  //   Reference ref = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask task = ref.putFile(imageFile);
  //   TaskSnapshot snapshot = await task;

  //   return await snapshot.ref.getDownloadURL();
  // } 

  Future getImageFileName(BuildContext context) async {
    return basename(image!.path);
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(image!.path);

    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = ref.putFile(image!);
    TaskSnapshot snapshot = await task;

    return await snapshot.ref.getDownloadURL();
  }

  void normalDropdownState() {
    currentDropdownOutlineColor = Colors.black;
    currentDropdownOutlineWidth = 1;
  }
  void unselectedDropdownState() {
    currentDropdownOutlineColor = Colors.red;
    currentDropdownOutlineWidth = 2;
  }
}