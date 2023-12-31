import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/UserProvider.dart';
import 'package:instagram_flutter/utils/Values.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveLayout(
      {Key? key, required this.mobileLayout, required this.webLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < webScreenSize) {
        return widget.mobileLayout;
      } else {
        return widget.webLayout;
      }
    });
  }
}
