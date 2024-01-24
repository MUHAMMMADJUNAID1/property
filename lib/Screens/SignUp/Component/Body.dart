import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Auth_Provider.dart';
import '../../../constant.dart';
import '../../../size_config.dart';
import '../../Login/loginScreen.dart';
import 'signup_Form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? _image;
  String? downloadURL;

  Future getImage() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      }
      if (pick == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please Select Image")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<AuthProvider>(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                              child: SizedBox(
                            height: 100,
                            width: 100,
                            child: _image == null
                                ? Image.asset(
                                    "assets/images/img5.png",
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Image.asset(
                              "assets/images/lock.png",
                              height: 40,
                              width: 40,
                            ))
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.05,
              ),
              const Text(
                "Register",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              const Text("create an account"),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              SignUpForm(
                image: _image,
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("I already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: kPrimaryColor),
                    ),
                  )
                  //  Text("Login"style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.w600),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
