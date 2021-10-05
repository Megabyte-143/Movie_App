import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/add_screen_header.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);
  static const routeName = "/add_screen";

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final titleTextController = TextEditingController();
  final directorTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String director = '';
  File? _image;
  bool isLoading = false;
  String? imgUrl;

  void pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    final pickedImageFile = File(pickedImage!.path);
    print(pickedImage.name);
    print(pickedImage.path);
    setState(() {
      _image = pickedImageFile;
    });
  }

  void pickFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    final pickedImageFile = File(pickedImage!.path);
    print(pickedImage.name);
    print(pickedImage.path);
    setState(() {
      _image = pickedImageFile;
    });
  }

  void removePhoto() {
    setState(() {
      _image = null;
    });
  }

  void submit() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_image == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please Add an Image")));
        } else {
          setState(() {
            isLoading = true;
          });
          print(director);
          print(title);
          print(_image!.path);
          final ref = FirebaseStorage.instance
              .ref()
              .child('movieImages')
              .child('$title.jpg');
          await ref.putFile(_image!);
          imgUrl = await ref.getDownloadURL();
          await FirebaseFirestore.instance.collection('movies').doc(title).set({
            'title': title,
            'director': director,
            'imgUrl': imgUrl,
            'status': false,
          }).then((value) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Movie Added")));
          });
        }
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        _formKey.currentState!.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddScreenHeader(
                height: height * 0.3,
                width: width,
              ),
              Container(
                height: height * 0.7,
                child: Stack(
                  children: [
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image(
                        image: AssetImage(
                          "assets/images/bottom_right.png",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      height: height * 0.7,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height * (0.05),
                                  width: width * 0.3,
                                  color: Colors.yellow,
                                  child: const Center(
                                    child: Text(
                                      "Movie",
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.blue,
                                  height: height * (0.05),
                                  width: width * 0.5,
                                  child: TextFormField(
                                    controller: titleTextController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Title';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      title = value.toString();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height * (0.05),
                                  width: width * 0.3,
                                  color: Colors.yellow,
                                  child: const Center(
                                    child: Text(
                                      "Director",
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.blue,
                                  height: height * (0.05),
                                  width: width * 0.5,
                                  child: TextFormField(
                                    controller: directorTextController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Title';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      director = value.toString();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: height * (0.05),
                                    width: width * 0.3,
                                    color: Colors.yellow,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Add An Image"),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: pickFromGallery,
                                                    child:
                                                        const Text("Gallery"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: pickFromCamera,
                                                    child: const Text("Photo"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: removePhoto,
                                                    child: const Text(
                                                        "Remove Photo"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("OK"),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: const Text("Add Image"),
                                    )),
                                Container(
                                  height: height * 0.3,
                                  // color: Colors.blue,
                                  width: width * 0.5,
                                  decoration: const BoxDecoration(
                                      //color: Colors.blue,
                                      // image: DecorationImage(
                                      //   image: AssetImage(image==null ? '': image!.path),
                                      // ),
                                      ),
                                  child: _image == null
                                      ? const Center(
                                          child: Text("Pick an Image"),
                                        )
                                      : Image.file(
                                          _image!,
                                          fit: BoxFit.contain,
                                          alignment: Alignment.center,
                                        ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height * 0.07,
                              width: width * 0.3,
                              //color: Colors.pink,
                              child: ElevatedButton(
                                onPressed: () {
                                  submit();
                                },
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text("Add Movie"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
