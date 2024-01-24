import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
import '../../SignUp/SignUp_Screen.dart';
import 'addIcon.dart';
import 'login_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Image.asset(
                "assets/images/img2.png",
                height: getProportionateScreenHeight(150),
                width: getProportionateScreenWidth(150),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.06,
              ),
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              const Text(
                "Access Account",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.04,
              ),
              const LoginForm(),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.06,
              ),
              const AddIcon(),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.09,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("i don't have an account ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
