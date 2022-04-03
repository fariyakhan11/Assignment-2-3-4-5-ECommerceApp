import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/inner_screens/brands_navigation_rail.dart';
import 'package:furniture_store_app/provider/products.dart';
import 'package:furniture_store_app/screens/feeds.dart';
import 'package:furniture_store_app/screens/popular_products.dart';
import 'package:furniture_store_app/screens/user_info.dart';
import 'package:furniture_store_app/widgets/backlayer.dart';
import 'package:furniture_store_app/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:furniture_store_app/screens/user_info.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;

  List _carouselIcons = [
    'https://cdn.pixabay.com/photo/2019/06/13/17/08/round-window-4272049_960_720.jpg',
    'https://cdn.pixabay.com/photo/2021/10/06/15/05/dining-room-6686053_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/20/10/33/room-4779953_960_720.jpg',
    'https://i.pinimg.com/564x/a9/cc/f8/a9ccf898fd38a5c45a157276c6f52578.jpg',
    'https://cdn.pixabay.com/photo/2018/07/27/00/32/apartment-3564955__340.jpg'
  ];

  List _brandImages = [
    'https://saleboard.pk/storage/app/public/brands/Interwood/interwood_logo.png', //interwood
    'http://www.citysearch.pk/UF/Companies/8651/index-furniture-logo.png', //index
    'http://www.citysearch.pk/UF/Companies/6195/habitt-logo.jpg', //habit
    'https://themes.pk/wp-content/uploads/2020/05/THEMES-Logo.jpg', //themes
  ];

  //---------------------fetch profile pic------------------

  //---FETCH USER PROFILE
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _userImageUrl;

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   setState(() {});
    // });
    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    _userImageUrl = user.photoURL;
    //print('user.photoURL ${user.photoURL}');
    //--------------------METHOD 1 TO FETCH DATA---------------------
    //print("user.email ${user.email}");
    //print('user.displayName ${user.displayName}');
    // print('user.photoURL ${user.photoURL}');
    // //--------------------METHOD 2 TO FETCH DATA---------------
    // final DocumentSnapshot<Map<String, dynamic>> ? userDoc = user.isAnonymous ? null :
    // await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    // if(userDoc == null) {
    //   return;
    // } else {
    //   setState(() {
    //     _userImageUrl = user.photoURL;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    productsData.FetchProducts();
    final popularItems = productsData.popularProducts;
    return Scaffold(
      body: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text('interiAR'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [ColorConsts.starterColor, ColorConsts.endcolor])),
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 10,
              padding: const EdgeInsets.all(10),
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(_userImageUrl ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png')),
              ),
              onPressed: () {
                //Navigator.pushNamed(context,UserInfo.routeName );
              },
            )
          ],
        ),
        backLayer: BackLayerMenu(),
        frontLayer: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250.0,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Column(
                      children: [
                        //--------------------------CAROUSEL--------------------------------------
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 190,
                            //1 PICTURE AT A TIME
                            //viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            //pageSnapping: false,
                            //enableInfiniteScroll: false,
                            //rev erse: true
                            //reverse: true,
                            autoPlayInterval: Duration(seconds: 2),

                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                          itemCount: _carouselIcons.length,
                          itemBuilder: (context, index, realIndex) {
                            final icon = _carouselIcons[index];

                            return buildImage(icon, index);
                          },
                        ),
                        const SizedBox(height: 32),
                        buildIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
              //SizedBox(height:80),
              //--------------------------CATEGORIES WIDGET--------------------------------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
              Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return CategoryWidget(index: index);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Popular Brands',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {
                            7,
                          },
                        );
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xFF6a5acd)),
                      ),
                    )
                  ],
                ),
              ),
              //--------------------------SWIPER--------------------------------------
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Swiper(
                  itemCount: _brandImages.length,
                  autoplay: true,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  onTap: (index) {
                    Navigator.of(context).pushNamed(
                      BrandNavigationRailScreen.routeName,
                      arguments: {
                        index,
                      },
                    );
                  },
                  itemBuilder: (BuildContext ctx, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.blueGrey,
                        child: Image.network(
                          _brandImages[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              //--------------------------POPULAR PRODUCT WIDGET-------------------------------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Popular Products',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Feeds.routeName, arguments: 'popular');
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xFF6a5acd)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularItems.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                        value: popularItems[index],
                        child: PopularProducts(
                            // imageUrl: popularItems[index].imageUrl,
                            // title: popularItems[index].title,
                            // description: popularItems[index].description,
                            // price: popularItems[index].price,
                            ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String icon, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          icon,
          fit: BoxFit.cover,
        ), // Image.network
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: _carouselIcons.length,
        effect: SlideEffect(
          dotWidth: 16,
          dotHeight: 16,
          activeDotColor: Color(0xFFbf94e4),
          dotColor: Colors.grey,
        ), // SlideEffect
      );
}
