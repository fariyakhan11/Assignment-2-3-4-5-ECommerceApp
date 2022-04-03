import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/inner_screens/product_details.dart';
import 'package:furniture_store_app/models/cart_attr.dart';
import 'package:furniture_store_app/provider/cart_provider.dart';
import 'package:furniture_store_app/provider/dark_theme_provider.dart';
import 'package:furniture_store_app/services/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({this.productId = ''});

  // final String id;
  // final String productId;
  // final String title;
  // final double price;
  // final int quantity;
  // final String imageUrl;

  // const CartFull(
  //     {@required this.id = '',
  //     @required this.productId = '',
  //     @required this.title = '',
  //     @required this.price = 0.0,
  //     @required this.quantity = 0,
  //     @required this.imageUrl = ''});
  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = cartAttr.price * cartAttr.quantity;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: widget.productId),
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cartAttr.imageUrl),
                  //fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            cartAttr.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              globalMethods.showDialogg(
                                  'Remove Item',
                                  'Are you sure you want to remove this item from the cart!',
                                  () => cartProvider
                                      .removeItem(widget.productId), context);
                            },
                            child: Container(
                              height: 55,
                              width: 50,
                              child: Icon(
                                FontAwesome5.times,
                                color: Color(0xffef1919),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${cartAttr.price}\Rs',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.cyan),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Sub Total:'),
                        SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            '${subTotal.toStringAsFixed(2)}\Rs',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: themeChange.darkTheme
                                    ? Colors.cyan
                                    : Theme.of(context).accentColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Ships Free',
                          style: TextStyle( fontWeight: FontWeight.w500, fontSize: 14,
                              color: themeChange.darkTheme
                                  ? Colors.black
                                  : Theme.of(context).accentColor
                          ),

                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: cartAttr.quantity < 2
                                ? null
                                : () {
                                    cartProvider
                                        .reduceItemByOne(widget.productId);
                                  },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  FontAwesome5.minus,
                                  color: cartAttr.quantity < 2
                                      ? Colors.black
                                      : Colors.red,
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorConsts.gradiendLStart,
                                ColorConsts.gradiendLEnd,
                              ], stops: [0.0,
                                         0.8]),
                            ),
                            child: Text(
                              '${cartAttr.quantity}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: () {
                              cartProvider.addProductToCart(
                                  widget.productId,
                                  cartAttr.price,
                                  cartAttr.title,
                                  cartAttr.imageUrl);
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  FontAwesome5.plus,
                                  color: Colors.black, //(0xFF4876FF darker blue)
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
