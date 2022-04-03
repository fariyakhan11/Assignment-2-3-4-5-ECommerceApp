import 'package:furniture_store_app/consts/my_icons.dart';
import 'package:furniture_store_app/screens/cart.dart';
import 'package:furniture_store_app/screens/feeds.dart';
import 'package:furniture_store_app/screens/home.dart';
import 'package:furniture_store_app/screens/search.dart';
import 'package:furniture_store_app/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/zocial_icons.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Object>> _pages;
  //late List<Map<String, Widget>> _pages;
  //var _pages;
  int _selectPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': Home(),
      },
      {
        'page': Feeds(),
      },
      {
        'page': Search(),
      },
      {
        'page': CartScreen(),
      },
      {
        'page': UserInfoScreen(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     title: Text(_pages[_selectPageIndex]['title']),
      // ), // AppBar
      body: _pages[_selectPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomAppBar(
        //color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Color(0xFFbf94e4),
              currentIndex: _selectPageIndex,
              selectedLabelStyle: TextStyle(fontSize: 14),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.bag), label: 'Feeds'),
                BottomNavigationBarItem(
                    activeIcon: null, icon: Icon(null), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.cart), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.user), label: 'User'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(MyAppIcons.search),
          onPressed: () => setState(() {
            _selectPageIndex = 2;
          }),
        ),
      ),
    );
  }
}
