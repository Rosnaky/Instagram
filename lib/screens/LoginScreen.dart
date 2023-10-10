import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:instagram_flutter/utils/Colours.dart";
import "package:instagram_flutter/widgets/TextFieldInput.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        width: double.infinity,
        child: Column(
          children: [
            Spacer(flex: 2),
            // svg image
            SvgPicture.asset(
              "assets/images/ic_instagram.svg",
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            TextFieldInput(
              hintText: "Enter email",
              textInputType: TextInputType.emailAddress,
              textEditingController: emailTextEditingController,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFieldInput(
              hintText: "Password",
              textInputType: TextInputType.text,
              isPassword: true,
              textEditingController: passwordTextEditingController,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  color: blueColor,
                ),
                child: Text("Log in"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Don't have an account? ",
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      )),
    );
  }
}
