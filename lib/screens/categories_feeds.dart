import 'package:furniture_store_app/models/product.dart';
import 'package:furniture_store_app/provider/products.dart';
import 'package:furniture_store_app/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesFeedsScreen extends StatelessWidget {
  static const routeName = '/CategoriesFeedsScreen';
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final productsList = productsProvider.findByCategory(categoryName);
    return Scaffold(
        // body: FeedProducts(),
        //     StaggeredGridView.countBuilder(
        //     crossAxisCount: 4,
        //     itemCount: 8,
        //     itemBuilder: (BuildContext context, int index) => FeedProducts(
        //     ), // Center // Container
        // staggeredTileBuilder: (int index) =>
        // new StaggeredTile.count(2, index.isEven ? 2 : 1),
        // mainAxisSpacing: 4.0,
        // crossAxisSpacing: 4.0,
        //     )

        body: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 240 / 440,
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