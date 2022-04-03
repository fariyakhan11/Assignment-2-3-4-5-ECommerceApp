import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_store_app/screens/feeds.dart';
import 'package:furniture_store_app/screens/upload_product_form.dart';
import 'package:furniture_store_app/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:furniture_store_app/screens/user_info.dart';

import 'bottom_bar.dart';

class MainScreens extends StatefulWidget {
  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // String  ? _uid;
  // bool ? _isAdmin;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }
  //
  // void getData() async {
  //   User? user = _auth.currentUser;
  //   _uid = user!.uid;
  //
  //   //--------------------METHOD 2 TO FETCH Admin Access---------------
  //   final DocumentSnapshot<Map<String, dynamic>> ? userDoc = user.isAnonymous ? null :
  //   await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  //   if(userDoc == null) {
  //     return;
  //   } else {
  //     setState(() {
  //       _isAdmin = userDoc.get('isAdmin');
  //       print("is Admin ${_isAdmin}");
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // return _isAdmin! ? PageView(
    //   children: [BottomBarScreen(), UploadProductForm()]
    // ) :
    // PageView(
    //     children: [BottomBarScreen(), UserInfoScreen()]
    // );
    return PageView(
          children: [BottomBarScreen(), UploadProductForm()]
        );
  }
}
