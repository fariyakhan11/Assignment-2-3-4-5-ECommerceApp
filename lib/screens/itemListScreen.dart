import 'package:furniture_store_app/models/ItemModel.dart';
//import 'package:furniture_store_app/screens/arViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:furniture_store_app/consts/colors.dart';

class ItemListScreen extends StatelessWidget {
  static const routeName = '/ItemListScreen';
  List<ItemModel> assets = [
    ItemModel(
      'Double Bed',
      'assets/bed1.png',
      30000,
    ),
    ItemModel(
      'Ann Double Bed',
      'assets/bed2.png',
      35000,
    ),
    ItemModel(
      'Cortes Bed',
      'assets/bed3.png',
      40000,
    ),
    ItemModel(
      'Hoffman Bedset',
      'assets/bed4.png',
      60000,
    ),
    ItemModel(
      'Meyer Bedset',
      'assets/bed5.png',
      100000,
    ),
    ItemModel(
      'Edler Upholstered',
      'assets/bed6.png',
      110000,
    ),
    ItemModel(
      'Lara Chair',
      'assets/c1.png',
      4000,
    ),
    ItemModel(
      'ELM-Grey Chair',
      'assets/c2.png',
      11000,
    ),
    ItemModel(
      'ELM-Mehroon',
      'assets/c3.png',
      8000,
    ),
    ItemModel(
      'White Chair',
      'assets/c4.png',
      10000,
    ),
    ItemModel(
      'Wooden chair',
      'assets/c5.png',
      7000,
    ),
    ItemModel(
      'Modern Chair',
      'assets/c6.png',
      16000,
    ),
    ItemModel(
      'Kyla-Brown Chair',
      'assets/c7.png',
      9000,
    ),
    ItemModel(
      'Dinning-Black (6)',
      'assets/t1.png',
      22000,
    ),
    ItemModel(
      'Dinning-Wooden (6)',
      'assets/t2.png',
      32000,
    ),
    ItemModel(
      'Dinning-Cream (4)',
      'assets/t3.png',
      42000,
    ),
    ItemModel(
      'Dinning-Brown (6)',
      'assets/t5.png',
      43000,
    ),
    ItemModel(
      'Oak (6)',
      'assets/t6.png',
      50000,
    ),
    ItemModel(
      'Dinning Square',
      'assets/t8.png',
      16,
    ),
    ItemModel(
      'Zoee Single seater',
      'assets/sofa2.png',
      15000,
    ),
    ItemModel(
      'Derry Single seater',
      'assets/sofa3.png',
      27000,
    ),
    ItemModel(
      'Bejorn Single Seater',
      'assets/sofa5.png',
      440000,
    ),
    ItemModel(
      'Zinus Double Seater',
      'assets/sofaset4.png',
      40000,
    ),
    ItemModel(
      'tête-à-tête',
      'assets/sofaset5.png',
      60000,
    ),
    ItemModel(
      'vis-à-vis',
      'assets/sofaset8.png',
      73000,
    ),
    ItemModel(
      'Catalina Table',
      'assets/s1.png',
      12000,
    ),
    ItemModel(
      'Riesle Office Table',
      'assets/s2.png',
      9000,
    ),
    ItemModel(
      'Luisa Study Table',
      'assets/s3.png',
      14000,
    ),
    ItemModel(
      'Derlyum 2 Door Wardrobe',
      'assets/w1.png',
      16000,
    ),
    ItemModel(
      'Farnell 2 Door',
      'assets/w2.png',
      16500,
    ),
    ItemModel(
      'Deonca 2 Door Wardrobe',
      'assets/w3.png',
      33700,
    ),
    ItemModel(
      'Kidwell 3 Door Wardrobe',
      'assets/w4.png',
      32000,
    ),
    ItemModel(
      'Sparks Two Door',
      'assets/w5.png',
      20000,
    ),
    ItemModel(
      'Flower Decor1',
      'assets/p1.png',
      1600,
    ),
    ItemModel(
      'Flower Decor2',
      'assets/p2.png',
      1000,
    ),
    ItemModel(
      'Flower Decor3',
      'assets/p3.png',
      1300,
    ),
    ItemModel(
      'Dishna Floor Lamp',
      'assets/l1.png',
      3000,
    ),
    ItemModel(
      'Amur Floor Lamp',
      'assets/l2.png',
      4000,
    ),
    ItemModel(
      'Lead Black Floor Lamp',
      'assets/l3.png',
      6000,
    ),
    ItemModel(
      'Wild S Floor Lamp',
      'assets/l4.png',
      2300,
    ),
    ItemModel(
      'Laurentium Table lamp',
      'assets/l5.png',
      5000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9370db),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset("assets/logo1.png", height: 70, width: 70),
                  Text(
                    '   interiAR',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  // Text(
                  //   'Furniture',
                  //   style: TextStyle(
                  //       fontSize: 38,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w100),
                  // ),
                  // Text(
                  //   'App',
                  //   style: TextStyle(
                  //       fontSize: 38,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w100),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ARViewScreen(
                          //       itemImg: assets[index].pic,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.asset(
                                "${assets[index].pic}",
                                width: 60,
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: <Widget>[
                                Text(
                                  assets[index].name,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            )),
                            Container(
                              width: 60,
                              child: Text(
                                assets[index].price.toString(),
                                style:
                                    TextStyle(fontSize: 14, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: assets.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
