
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
import 'Reset_Form_Feild.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.04,
            ),
            Image.asset(
              "assets/images/img2.png",
              height: getProportionateScreenHeight(200),
              width: getProportionateScreenWidth(200),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            const Text(
              "Reset Password",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor),
            ),
            const Text("Enter your new password"),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            const ResetFormField(),
          ],
        ),
      ),
    );
  }
}
