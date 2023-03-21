import 'package:flutter/material.dart';
import 'package:xyz_store/common/app_colors.dart';
import 'package:xyz_store/ui/screens/screens.dart';

class BottomNavBar extends StatefulWidget {
  int index = 0;
  BottomNavBar({super.key, this.index = 0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  // int pindex = widget.index;
  bool _isSelected = true;

  List<Widget> pages = [
    const HomePage(),
    const ExploreScreen(),
    const CartPage(),
    const SettingsPage()
  ];

  void updateIndex(int index) {
    setState(() {
      widget.index = index;
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[widget.index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          // print(value);
          updateIndex(value);
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: widget.index,
        selectedItemColor: GlobalColors().primaryRed,
        // unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            label: "Home",
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.shopping_cart),
              label: "Cart",
              icon: Icon(Icons.shopping_cart_outlined)),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              label: "Settings",
              icon: Icon(Icons.settings_outlined)),
        ],
      ),
    );
  }
}
