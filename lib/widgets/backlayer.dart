// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/consts/my_icons.dart';
import 'package:furniture_store_app/screens/itemListScreen.dart';
import 'package:furniture_store_app/screens/upload_product_form.dart';
import 'package:furniture_store_app/screens/cart.dart';
import 'package:furniture_store_app/screens/feeds.dart';
import 'package:furniture_store_app/screens/wishlist.dart';
import 'package:flutter/material.dart';

class BackLayerMenu extends StatefulWidget {

  @override
  State<BackLayerMenu> createState() => _BackLayerMenuState();


}

class _BackLayerMenuState extends State<BackLayerMenu> {

  //---FETCH USER PROFILE
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String  ? _uid;
  String ? _userImageUrl;
  //bool ? _isAdmin;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    _userImageUrl = user.photoURL;

    //--------------------METHOD 2 TO FETCH Admin Access---------------
    final DocumentSnapshot<Map<String, dynamic>> ? userDoc = user.isAnonymous ? null :
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if(userDoc == null) {
      return;
    } else {
      setState(() {
        //_isAdmin = userDoc.get('isAdmin');
        //print("is Admin ${_isAdmin}");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  ColorConsts.starterColor,
                  ColorConsts.endcolor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Positioned(
          top: -100.0,
          left: 140.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 250,
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 100.0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 300,
            ),
          ),
        ),
        Positioned(
          top: -50.0,
          left: 60.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 200,
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 0.0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 200,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(50),
    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      //   clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                _userImageUrl ??
                                'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                content(
                    ctx: context,
                    text: 'Feeds',
                    index: 0,
                    routeName: Feeds.routeName),
                const SizedBox(height: 10.0),
                content(
                    ctx: context,
                    text: 'Cart',
                    index: 1,
                    routeName: CartScreen.routeName),
                const SizedBox(height: 10.0),
                content(
                    ctx: context,
                    text: 'View Products in AR ',
                    index: 2,
                    routeName: ItemListScreen.routeName),
                    //routeName: Feeds.routeName),
                const SizedBox(height: 10.0),
                content(
                    ctx: context,
                   text: 'Upload a new product' ,
                    index: 3,
                    routeName: UploadProductForm.routeName
                    //routeName: UploadScreen.routeName,
                    )
              ],
            )
    //         child: _isAdmin! ? Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             Center(
    //               child: Container(
    //                 padding: const EdgeInsets.all(8.0),
    //                 height: 100,
    //                 width: 100,
    //                 decoration: BoxDecoration(
    //                     color: Theme.of(context).backgroundColor,
    //                     borderRadius: BorderRadius.circular(10.0)),
    //                 child: Container(
    //                   //   clipBehavior: Clip.antiAlias,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(20.0),
    //                       image: DecorationImage(
    //                         image: NetworkImage(
    //                             _userImageUrl ??
    //                             'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
    //                         fit: BoxFit.fill,
    //                       )),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 10.0),
    //             content(
    //                 ctx: context,
    //                 text: 'Feeds',
    //                 index: 0,
    //                 routeName: Feeds.routeName),
    //             const SizedBox(height: 10.0),
    //             content(
    //                 ctx: context,
    //                 text: 'Cart',
    //                 index: 1,
    //                 routeName: CartScreen.routeName),
    //             const SizedBox(height: 10.0),
    //             content(
    //                 ctx: context,
    //                 text: 'View Products in AR ',
    //                 index: 2,
    //                 routeName: ItemListScreen.routeName),
    //                 //routeName: Feeds.routeName),
    //             const SizedBox(height: 10.0),
    //             content(
    //                 ctx: context,
    //                text: 'Upload a new product' ,
    //                 index: 3,
    //                 routeName: UploadProductForm.routeName
    //                 //routeName: UploadScreen.routeName,
    //                 )
    //           ],
    //         ):
    //
    // Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.stretch,
    // children: [
    // Center(
    // child: Container(
    // padding: const EdgeInsets.all(8.0),
    // height: 100,
    // width: 100,
    // decoration: BoxDecoration(
    // color: Theme.of(context).backgroundColor,
    // borderRadius: BorderRadius.circular(10.0)),
    // child: Container(
    // //   clipBehavior: Clip.antiAlias,
    // decoration: BoxDecoration(
    // borderRadius: BorderRadius.circular(20.0),
    // image: DecorationImage(
    // image: NetworkImage(
    // _userImageUrl ??
    // 'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
    // fit: BoxFit.fill,
    // )),
    // ),
    // ),
    // ),
    // const SizedBox(height: 10.0),
    // content(
    // ctx: context,
    // text: 'Feeds',
    // index: 0,
    // routeName: Feeds.routeName),
    // const SizedBox(height: 10.0),
    // content(
    // ctx: context,
    // text: 'Cart',
    // index: 1,
    // routeName: CartScreen.routeName),
    // const SizedBox(height: 10.0),
    // content(
    // ctx: context,
    // text: 'Wishlist',
    // index: 2,
    // routeName: WishlistScreen.routeName),
    // //routeName: Feeds.routeName),
    // const SizedBox(height: 10.0),
    // ],
    // ),
          ),
        ),
      ],
    );
  }

  List _contentIcons = [
    MyAppIcons.rss,
    MyAppIcons.bag,
    FontAwesome5.camera,
    MyAppIcons.upload
  ];

  Widget content(
      {required BuildContext ctx,
      required String routeName,
      required int index,
      required String text}) {
    return InkWell(
      onTap: () => Navigator.of(ctx).pushNamed(routeName),
      //onTap: (){},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index])
        ],
      ),
    );
  }
}
