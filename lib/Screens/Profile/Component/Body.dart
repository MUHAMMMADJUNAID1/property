import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Component/build_button.dart';
import '../../../constant.dart';
import '../../../size_config.dart';
import '../../Home/Home_screen.dart';
import 'user_post_data.dart';

class Body extends StatefulWidget {
  String? name;
  String? image;
  Body({Key? key, this.image, this.name}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? _image;

  // pick  Image from Gallery
  Future getImage() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      }
      if (pick == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No FIle  selected")));
      }
    });
  }

  // profile update
  Future updateImage() async {
    if (_image == null) {
      Fluttertoast.showToast(msg: "Please Select Image");
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      User? user = FirebaseAuth.instance.currentUser;

      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${user?.uid}/images')
          .child('image');
      await ref.putFile(_image!);

      Fluttertoast.showToast(msg: "Profile Update Successfully");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          child: ClipOval(
                              child: SizedBox(
                                  height: getProportionateScreenHeight(120),
                                  width: getProportionateScreenWidth(120),
                                  child: _image == null
                                      ? widget.image == null
                                          ? Image.asset(
                                              "assets/images/img5.png",
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              widget.image.toString(),
                                              fit: BoxFit.cover,
                                            )
                                      : Image.file(
                                          _image!,
                                          fit: BoxFit.cover,
                                        ))),
                        ),
                        Positioned(
                            bottom: 3,
                            right: 0,
                            child: Image.asset(
                              "assets/images/lock.png",
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(40),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  widget.name == null
                      ? Text(
                          "no data",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor),
                        )
                      : Text(
                          widget.name.toString(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildButten(
                    text: " Update Image ",
                    onpressed: () {
                      updateImage();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const UserPostData(),
          ],
        ),
      ),
    );
  }
}
