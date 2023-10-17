import "dart:io";
import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:http/http.dart" as http;
import "package:image_picker/image_picker.dart";
import "package:instagram_flutter/responsive/MobileLayout.dart";
import "package:instagram_flutter/responsive/ResponsiveLayoutTheme.dart";
import "package:instagram_flutter/responsive/WebLayout.dart";
import "package:instagram_flutter/screens/LoginScreen.dart";
import "package:instagram_flutter/utils/Colours.dart";
import "package:instagram_flutter/utils/Utils.dart";
import "package:instagram_flutter/widgets/TextFieldInput.dart";

import 'package:instagram_flutter/utils/Values.dart';

import "../resources/AuthMethods.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  Uint8List? _img;
  bool _isLoading = false;
  MemoryImage defaultImage = MemoryImage(defaultImageIntArray);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    nameTextEditingController.dispose();
    usernameTextEditingController.dispose();
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _img = img;
    });
  }

  getDefaultImage() async {
    final imageUrl = Uri.parse(
        "static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg");
    final http.Response response = await http.get(imageUrl);
    setState(() {
      _img = response.bodyBytes;
    });
  }

  signUpUser() async {
    if (_img == null) {
      await getDefaultImage();
    }
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
      username: usernameTextEditingController.text,
      name: nameTextEditingController.text,
      file: _img!,
    );
    if (res != "Success") {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              mobileLayout: MobileLayout(), webLayout: WebLayout())));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLoginScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
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
            // circular widget to accept and show our selected file
            Stack(children: [
              _img != null && _img! != defaultImageIntArray
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_img!),
                    )
                  : CircleAvatar(
                      radius: 64,
                      backgroundImage: defaultImage,
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: primaryColor,
                    ),
                  ))
            ]),
            SizedBox(
              height: 16,
            ),
            TextFieldInput(
              hintText: "Email address",
              textInputType: TextInputType.emailAddress,
              textEditingController: emailTextEditingController,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFieldInput(
              hintText: "Full name",
              textInputType: TextInputType.text,
              textEditingController: nameTextEditingController,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFieldInput(
              hintText: "Username",
              textInputType: TextInputType.text,
              textEditingController: usernameTextEditingController,
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
              onTap: signUpUser,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  color: blueColor,
                ),
                child: _isLoading
                    ? Center(
                        child: const CircularProgressIndicator(
                            color: primaryColor),
                      )
                    : Text("Sign up"),
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
                    "Already have an account? ",
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToLoginScreen,
                  child: Container(
                    child: Text(
                      "Log in",
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
