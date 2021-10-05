import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    setState(() {
      _image = pickedImageFile;
    });
  }

  void removePhoto() {
    setState(() {
      _image = null;
    });
  }

  void addImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Add An Image",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: pickFromGallery,
                icon: FaIcon(Icons.photo_album),
                label: const Text("Gallery"),
              ),
              ElevatedButton.icon(
                onPressed: pickFromCamera,
                icon: const FaIcon(Icons.camera),
                label: const Text("Photo"),
              ),
              ElevatedButton.icon(
                onPressed: removePhoto,
                icon: const FaIcon(Icons.remove),
                label: const Text("Remove Photo"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(null),
                label: const Text("DONE"),
              ),
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
  }

  void submit() async {
    final isValid = _formKey.currentState!.validate();
    if (_image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Add an Image")));
    }
    if (isValid && _image != null) {
      _formKey.currentState!.save();
      try {
        setState(() {
          isLoading = true;
        });
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
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      } finally {
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
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddScreenHeader(
                height: height * 0.3,
                width: width,
              ),
              SizedBox(
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromRGBO(
                                      152,
                                      20,
                                      255,
                                      0.41,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Movie",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  //color: Colors.blue,
                                  height: height * (0.05),
                                  width: width * 0.5,
                                  child: Center(
                                    child: TextFormField(
                                      controller: titleTextController,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.transparent,
                                        hintText: "Movie Title Here",
                                      ),
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
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height * (0.05),
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromRGBO(
                                      152,
                                      20,
                                      255,
                                      0.41,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Director",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * (0.05),
                                  width: width * 0.5,
                                  child: TextFormField(
                                    controller: directorTextController,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.transparent,
                                      hintText: "Director's Name Here",
                                    ),
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromRGBO(
                                        152, 20, 255, 0.41),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      addImage();
                                    },
                                    child: Text(
                                      "Add Image",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.3,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: _image == null
                                      ? const Center(
                                          child: Text("Pick an Image"),
                                        )
                                      : Material(
                                          elevation: 20,
                                          color: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            height: height * 0.3,
                                            width: width * 0.5,
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * 0.01,
                                              horizontal: width * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Image.file(
                                              _image!,
                                              fit: BoxFit.contain,
                                              alignment: Alignment.center,
                                            ),
                                          ),
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
                                    : Text(
                                        "Add Movie",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
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
