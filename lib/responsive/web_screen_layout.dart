import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bolu_app/utils/colors.dart';
import 'package:bolu_app/utils/global_variable.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
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
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        actions: [
          Expanded(
              child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(100, 0, 100, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 30.0,
                    color: _page == 0 ? primaryColor : secondaryColor,
                  ),
                  onPressed: () => navigationTapped(0),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                    color: _page == 1 ? primaryColor : secondaryColor,
                  ),
                  onPressed: () => navigationTapped(1),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 30.0,
                    color: _page == 2 ? primaryColor : secondaryColor,
                  ),
                  onPressed: () => navigationTapped(2),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 30.0,
                    color: _page == 3 ? primaryColor : secondaryColor,
                  ),
                  onPressed: () => navigationTapped(3),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 30.0,
                    color: _page == 4 ? primaryColor : secondaryColor,
                  ),
                  onPressed: () => navigationTapped(4),
                ),
              ],
            ),
          )),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
    );
  }
}
