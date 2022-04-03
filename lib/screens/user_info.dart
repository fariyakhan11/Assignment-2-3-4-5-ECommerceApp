import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/consts/my_icons.dart';
import 'package:furniture_store_app/provider/dark_theme_provider.dart';
import 'package:furniture_store_app/screens/cart.dart';
import 'package:furniture_store_app/screens/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  //const UserInfo({Key? key}) : super(key: key);

  static const routeName = '/UserInfo';

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late ScrollController _scrollController;
  var top = 0.0;

  //---FETCH USER INFO
  final FirebaseAuth _auth = FirebaseAuth.instance;
   String  ? _uid;
   String ? _name;
  String ? _email;
   String ? _joinedAt;
   String ? _userImageUrl;
   int ? _phoneNumber;
  @override
  void initstate() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    //--------------------METHOD 1 TO FETCH DATA---------------------
    //print("user.email ${user.email}");
    print('user.displayName ${user.displayName}');
    print('user.photoURL ${user.photoURL}');
    //--------------------METHOD 2 TO FETCH DATA---------------
    final DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous ? null :
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if(userDoc == null) {
      return;
    } else {
      setState(() {
        _name = userDoc!.get('name');
        //print("name $_name");
        _email = userDoc.get('email');
        _joinedAt =userDoc.get('joinedAt');
        _phoneNumber = userDoc.get('phoneNumber');
        _userImageUrl = userDoc.get('imageurl');
      });
    }
  }

  //----HANDLE LOGOUT
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              //automaticallyImplyLeading: false,
              //controls the shadow that appears below the appBar when the users moves downwards
              elevation: 4,
              //controls the height of the appBar i.e. is the user image box in this case
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
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
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: AnimatedOpacity(
                        opacity: top <= 110.0 ? 1.0 : 0,
                        duration: Duration(microseconds: 300),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              height: kToolbarHeight / 1.8,
                              width: kToolbarHeight / 1.8,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(

                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          _userImageUrl ??
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"
                                      ))),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              //'top.toString()',
                              //_name == null ? 'Guest' : _name,
                              _name ?? 'Guest',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      background: Image(
                        image: NetworkImage(
                            _userImageUrl ??
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: //TITLE WIDGET
                        userTitle('User Bag'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(WishlistScreen.routeName);
                      },
                      splashColor: Colors.red,
                      child: ListTile(
                        title: Text('Wishlist'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(FontAwesome5.heart),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    title: Text('Cart'),
                    trailing: Icon(Icons.chevron_right_rounded),
                    leading: Icon(FontAwesome5.shopping_cart),
                  ),
                  ListTile(
                    title: Text('My Orders'),
                    trailing: Icon(Icons.chevron_right_rounded),
                    leading: Icon(FontAwesome5.shopping_bag),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: //TITLE WIDGET
                        userTitle('User Info'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  //USERLIST WIDGET
                  userListTile(
                      "Email",  _email ?? '', FontAwesome5.envelope, context),
                  userListTile("Phone", _phoneNumber.toString() ?? '', FontAwesome5.phone, context),
                  userListTile("Shipping Adddress", "", Icons.local_shipping,
                      context),
                  userListTile(
                      "Joined Date", _joinedAt ?? '', Icons.watch_later, context),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: //TITLE WIDGET
                        userTitle('User Settings'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  ListTileSwitch(
                    value: themeChange.darkTheme,
                    leading: Icon(FontAwesome5.moon),
                    onChanged: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
                    },
                    switchType: SwitchType.material,
                    switchActiveColor: Colors.indigo,
                    title: Text('Theme'),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () async {
                          // Navigator.canPop(context)
                          //     ? Navigator.pop(context)
                          //     : null;
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: Image.network(
                                          'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Sign Out:'),
                                      ),
                                    ],
                                  ),
                                  content: Text('Do you want to Sign Out?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')),
                                    TextButton(
                                        onPressed: () async {
                                          await _auth.signOut().then((value) =>
                                              Navigator.pop(context));
                                        },
                                        child: Text('OK')),
                                  ],
                                );
                              });
                        },
                        title: Text('Logout'),
                        leading: Icon(Icons.exit_to_app_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildFab(),
      ],
    ));
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down

        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down

        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  } // Positioned

  Widget userTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget userListTile(
      String title, String subTitle, IconData icon, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(icon),
        ),
      ),
    );
  }
} /*flexibleSpace*/
