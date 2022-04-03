import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/consts/my_icons.dart';
import 'package:furniture_store_app/provider/favs_provider.dart';
import 'package:furniture_store_app/services/global_methods.dart';
import 'package:furniture_store_app/widgets/wishlist_empty.dart';
import 'package:furniture_store_app/widgets/wishlist_full.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return favsProvider.getFavsItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist (${favsProvider.getFavsItems.length})'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [ColorConsts.starterColor,
                          ColorConsts.endcolor])),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Clear Wishlist',
                        'Are you sure you want to clear your wishlist!',
                        () => favsProvider.clearFavs(), context);
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: favsProvider.getFavsItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                  value: favsProvider.getFavsItems.values.toList()[index],
                  child: WishlistFull(
                    productId: favsProvider.getFavsItems.keys.toList()[index],
                  ));
              },
            ),
          );
  }
}
