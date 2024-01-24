import 'package:property/size_config.dart';
import 'package:flutter/material.dart';

import '../../../Component/build_button.dart';
import '../../Login/loginScreen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Image.asset(
            "assets/images/img2.png",
            height: getProportionateScreenHeight(220),
            width: getProportionateScreenWidth(220),
          ),
          const Spacer(
            flex: 2,
          ),
          BuildButten(
            text: "Get Started",
            onpressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
