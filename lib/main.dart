import 'package:furniture_store_app/consts/theme_data.dart';
import 'package:furniture_store_app/inner_screens/product_details.dart';
import 'package:furniture_store_app/screens/auth/forget_password.dart';
import 'package:furniture_store_app/screens/itemListScreen.dart';
import 'package:furniture_store_app/screens/upload_product_form.dart';
import 'package:furniture_store_app/provider/cart_provider.dart';
import 'package:furniture_store_app/provider/dark_theme_provider.dart';
import 'package:furniture_store_app/provider/favs_provider.dart';
import 'package:furniture_store_app/provider/products.dart';
import 'package:furniture_store_app/screens/auth/login.dart';
import 'package:furniture_store_app/screens/auth/sign_up.dart';
import 'package:furniture_store_app/screens/bottom_bar.dart';
import 'package:furniture_store_app/screens/cart.dart';
import 'package:furniture_store_app/screens/categories_feeds.dart';
import 'package:furniture_store_app/screens/feeds.dart';
import 'package:furniture_store_app/screens/user_info.dart';
import 'package:furniture_store_app/screens/user_state.dart';
import 'package:furniture_store_app/screens/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inner_screens/brands_navigation_rail.dart';

void main() {
  //Ensures the app is initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // will declare a variable of class DarkThemeProvider
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                  create: (_) => Products(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => FavsProvider(),
                )
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  //initialRoute: '/',
                  routes: {
                    //   '/': (ctx) => LandingPage(),
                    BrandNavigationRailScreen.routeName: (ctx) =>
                        BrandNavigationRailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    Feeds.routeName: (ctx) => Feeds(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    CategoriesFeedsScreen.routeName: (ctx) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                    UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
                    ItemListScreen.routeName: (ctx) => ItemListScreen()
                  },
                );
              }));
        });
  }
}

//In order to switch between light and dark mode provider package was used.
