import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/models/fav_attr.dart';
import 'package:furniture_store_app/provider/favs_provider.dart';
import 'package:furniture_store_app/services/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistFull extends StatefulWidget {
  final String productId;

  const WishlistFull({this.productId = ''});
  @override
  _WishlistFullState createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    final favsAttr = Provider.of<FavsAttr>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, top: 20.0, left: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(favsAttr.imageUrl),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favsAttr.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\Rs ${favsAttr.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(widget.productId),
      ],
    );
  }

  Widget positionedRemove(String productId) {
    GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return Positioned(
      top: 30,
      right: 20,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          color: ColorConsts.favColor,
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            globalMethods.showDialogg(
                'Remove Wish',
                'Are you sure you want to remove this item from wishlist!',
                () => favsProvider.removeItem(productId),
                context);
          },
        ),
      ),
    );
  }
}
