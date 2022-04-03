import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_store_app/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brands_rail_widget.dart';

class BrandNavigationRailScreen extends StatefulWidget {
  //BrandNavigationRailScreen({required Key key}) : super(key: key);
  BrandNavigationRailScreen();

  static const routeName = '/brands_navigation_rail';
  @override
  _BrandNavigationRailScreenState createState() =>
      _BrandNavigationRailScreenState();
}

class _BrandNavigationRailScreenState extends State<BrandNavigationRailScreen> {
  int _selectedIndex = 0;
  final padding = 8.0;
  String routeArgs = '';
  String brand = '';
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs.substring(1, 2),
    );
    print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        brand = 'Interwood';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'Index';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'Address';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'Themes';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'Renaissance';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'Habit';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'Designer & Depth';
      });
    }
    if (_selectedIndex == 7) {
      setState(() {
        brand = 'All';
      });
    }
    super.didChangeDependencies();
  }

  //---FETCH USER PROFILE
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String  ? _uid;
  String ? _userImageUrl;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    _userImageUrl = user.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: 56.0,
                      groupAlignment: 1.0,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              brand = 'Interwood';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brand = 'Index';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brand = 'Address';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              brand = 'Themes';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              brand = 'Renaissance';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              brand = 'Habitt';
                            });
                          }
                          if (_selectedIndex == 6) {
                            setState(() {
                              brand = 'Designer & Depth';
                            });
                          }
                          if (_selectedIndex == 7) {
                            setState(() {
                              brand = 'All';
                            });
                          }
                          print(brand);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                _userImageUrl ??
                                  "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination('Interwood', padding),
                        buildRotatedTextRailDestination("Index", padding),
                        buildRotatedTextRailDestination("Address", padding),
                        buildRotatedTextRailDestination("Themes", padding),
                        buildRotatedTextRailDestination("Renaissance", padding),
                        buildRotatedTextRailDestination("Habitt", padding),
                        buildRotatedTextRailDestination("Designer & Depth", padding),
                        buildRotatedTextRailDestination("All", padding),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // This is the main content.

          ContentSpace(context, brand)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String brand;
  ContentSpace(BuildContext context, this.brand);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productsBrand = productsData.findByBrand(brand);
    if (brand == 'All') {
      for (int i = 0; i < productsData.products.length; i++) {
        productsBrand.add(productsData.products[i]);
      }
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: productsBrand.length,
            itemBuilder: (BuildContext context, int index) =>
                ChangeNotifierProvider.value(
                    value: productsBrand[index], child: BrandsNavigationRail()),
          ),
        ),
      ),
    );
  }
}