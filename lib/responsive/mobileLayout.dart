import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/providers/UserProvider.dart';
import 'package:instagram_flutter/utils/Colours.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int value) {
    pageController.jumpToPage(value);
  }

  void onPageChanged(int value) {
    setState(() {
      _page = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: [
          Text("home"),
          Text("seach"),
          Text("feed"),
          Text("favourites"),
          Text("profile"),
        ],
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _page == 0 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                  color: _page == 2 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
