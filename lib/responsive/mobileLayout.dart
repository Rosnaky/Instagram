import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/userProvider.dart';
import 'package:provider/provider.dart';
import "package:instagram_flutter/models/user.dart" as userModel;

class MobileLayout extends StatelessWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userModel.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(body: Center(child: Text(user.username)));
  }
}
