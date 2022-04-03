import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/consts/my_icons.dart';
import 'package:furniture_store_app/provider/cart_provider.dart';
import 'package:furniture_store_app/services/global_methods.dart';
import 'package:furniture_store_app/services/payment.dart';
import 'package:furniture_store_app/widgets/cart_full.dart';
import 'package:furniture_store_app/widgets/empty_cart.dart';
import 'package:flutter/material.dart';
//import 'package:sn_progress_dialog/sn_progress_dialog.dart';
//import 'package:progress_bar/progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class CartScreen extends StatefulWidget {

  //PAYMENT GATEWAY
  // 1) The mount must be an
  // integer
  // 2) The amount must be
  // at least 0.5 USD
  // 3) The amount must be
  // sent in cents.
  static const routeName = '/CartScreen';


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  get amount => null;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  // var response;
  // Future<void> payWithCard({int ? amount}) async {
  //   // ProgressDialog dialog = ProgressDialog(context);
  //   // dialog.style(message: 'Please wait...');
  //   // await dialog.show();
  //   // await showDialog(context: context, builder: (context) =>
  //   // FutureProgressDialog(, message: Text('Please Wait..'))
  //   // );
  //   response = await StripeService.payWithNewCard(
  //       currency: 'USD', amount: amount.toString());
  //   print('response : ${response.success}');
  //   // Scaffold.of(context).showSnackBar(SnackBar(
  //   //   content: Text(response.message),
  //   //   duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
  //   // ));
  // }

  var response;
  Future<void> payWithCard() async{
    response = await StripeService.payWithNewCard(amount: '5', currency: 'USD');
    print('response : ${response.success}');
    //_scaffoldKey.currentState?.showSnackBar(SnackBar(
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  GlobalMethods globalMethods = GlobalMethods();
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              title: Text('Cart (${cartProvider.getCartItems.length})'),
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
                        'Clear cart',
                        'Are you sure you want to empty the cart!',
                        () => cartProvider.clearCart(), context);
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItems.keys.toList()[index],
                        // id: cartProvider.getCartItems.values.toList()[index].id,
                        // productId: cartProvider.getCartItems.keys.toList()[index],
                        // price: cartProvider.getCartItems.values.toList()[index].price,
                        // title: cartProvider.getCartItems.values.toList()[index].title,
                        // imageUrl: cartProvider.getCartItems.values.toList()[index].imageUrl,
                        // quantity: cartProvider.getCartItems.values.toList()[index].quantity,
                      ),
                    );
                  }),
            ));
  }

  /*Widget checkoutSection(BuildContext ctx, double subtotal) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      ColorConsts.gradiendLStart,
                      ColorConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.8
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: payWithCard,
                      // onTap: ({int ? amount}) async{
                      //   response = await StripeService.payWithNewCard(
                      //       currency: 'USD', amount: amount.toString());
                      //   print('response : ${response.success}');
                        // Scaffold.of(context).showSnackBar(SnackBar(
                        //   content: Text(response.message),
                        //   duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
                        // ));
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(ctx).textSelectionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                ' \Rs${subtotal.toStringAsFixed(2)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF4876FF), //(0xFF4876FF darker blue)
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }*/

  Widget checkoutSection(BuildContext ctx, double subtotal) {
    // final cartProvider = Provider.of<CartProvider>(context);
    // var uuid = Uuid();
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorConsts.gradiendLStart,
                      ColorConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () async{
                        response = await StripeService.payWithNewCard(amount: '1558.9', currency: 'USD');
                        print('response : ${response.success}');
                        print('response : ${response.message}');
                        _scaffoldKey.currentState?.showSnackBar(SnackBar(
                        //Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(response.message),
                          duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
                        ));
                      },
                      //onTap: payWithCard,
                      // onTap: () async {
                      //   double amountInCents = subtotal * 1000;
                      //   int intengerAmount = (amountInCents / 10).ceil();
                      //   await payWithCard(amount: intengerAmount);
                      //   if (response.success == true) {
                      //     User user = _auth.currentUser;
                      //     final _uid = user.uid;
                      //     cartProvider.getCartItems
                      //         .forEach((key, orderValue) async {
                      //       final orderId = uuid.v4();
                      //       try {
                      //         await FirebaseFirestore.instance
                      //             .collection('order')
                      //             .doc(orderId)
                      //             .set({
                      //           'orderId': orderId,
                      //           'userId': _uid,
                      //           'productId': orderValue.productId,
                      //           'title': orderValue.title,
                      //           'price': orderValue.price * orderValue.quantity,
                      //           'imageUrl': orderValue.imageUrl,
                      //           'quantity': orderValue.quantity,
                      //           'orderDate': Timestamp.now(),
                      //         });
                      //       } catch (err) {
                      //         print('error occured $err');
                      //       }
                      //     });
                      //   } else {
                      //     globalMethods.authErrorHandle(
                      //         'Please enter your true information', context);
                      //   }
                      //},
                      splashColor: Theme.of(ctx).splashColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(ctx).textSelectionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US ${subtotal.toStringAsFixed(3)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}

