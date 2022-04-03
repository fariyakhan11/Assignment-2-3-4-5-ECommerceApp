import 'package:badges/badges.dart';
import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/consts/my_icons.dart';
import 'package:furniture_store_app/models/product.dart';
import 'package:furniture_store_app/provider/cart_provider.dart';
import 'package:furniture_store_app/provider/favs_provider.dart';
import 'package:furniture_store_app/provider/products.dart';
import 'package:furniture_store_app/screens/wishlist.dart';
import 'package:furniture_store_app/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.dart';


class Feeds extends StatelessWidget {
  static const routeName = '/Feeds';
  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments;
    final productsProvider = Provider.of<Products>(context);
    List<Product> productsList = productsProvider.products;
    if (popular == 'popular') {
      productsList = productsProvider.popularProducts;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Feeds'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ColorConsts.starterColor,
                    ColorConsts.endcolor])),
        ),
        actions: [
          Consumer<FavsProvider>(
                    builder: (_, favs, ch) => Badge(
                      badgeColor: ColorConsts.favBadgeColor,
                      badgeContent: Text(
                        favs.getFavsItems.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(top: 5, end: 7),
                      child: IconButton(
                        icon: Icon(
                          MyAppIcons.wishlist,
                          color: ColorConsts.favColor,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(WishlistScreen.routeName);
                        },
                      ),
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (_, cart, ch) => Badge(
                      badgeColor: ColorConsts.cartBadgeColor,
                      badgeContent: Text(
                        cart.getCartItems.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(top: 5, end: 7),
                      child: IconButton(
                        icon: Icon(
                          MyAppIcons.cart,
                          color: ColorConsts.cartColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                      ),
                    ),
                  ),
        ],),
        body: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 240 / 445,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(
        productsList.length,
        (index) {
          return ChangeNotifierProvider.value(
            value: productsList[index],
            child: FeedProducts(),
          );
        },
      ),
    ) // List.generate // Gridview.count
        );
  }
}// Scaffold