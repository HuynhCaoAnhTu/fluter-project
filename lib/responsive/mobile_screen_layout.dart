import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bolu_app/utils/colors.dart';
import 'package:bolu_app/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

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

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
        children: homeScreenItems,
      ),
      bottomNavigationBar:
			DefaultTextStyle(
        style: TextStyle(fontSize: 30), child: CupertinoTabBar(
        height: 50,
        activeColor: greenColor, // Màu của label khi trang đó được chọn
        inactiveColor: secondaryColor,

        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? greenColor : secondaryColor,
            ),
            label: 'Home',
            backgroundColor: greenColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.article,
                color: (_page == 1) ? greenColor : secondaryColor,
              ),
              label: 'Booking',
              backgroundColor: greenColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: (_page == 2) ? greenColor : secondaryColor,
            ),
            label: 'Bookmark',
            backgroundColor: greenColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 3) ? greenColor : secondaryColor,
            ),
            label: 'Profile',
            backgroundColor: greenColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
				 iconSize: 30.0, // Set the size of the icons here

      ),
			)
    );
  }
}
