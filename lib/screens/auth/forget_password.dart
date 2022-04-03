import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/services/global_methods.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/ForgetPassword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _emailAddress = '';

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalMethods _globalMethods = GlobalMethods();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    void _submitForm() async {
      final bool isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        setState(() {
          _isLoading = true;
        });
        _formKey.currentState!.save();
        try {
          await _auth.sendPasswordResetEmail(email: _emailAddress.trim().toLowerCase());

          Fluttertoast.showToast(
              msg: "An email has been sent",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.canPop(context)? Navigator.pop(context) : null;

        } on FirebaseAuthException catch (error) {
          _globalMethods.authErrorHandle(error.message, context);
          print('Error has occurred: ${error.message}');
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }

    return Scaffold(

        body:
        Column(
          //mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 120,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Forget password",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: TextFormField(
              key: ValueKey('email'),
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email Address',
                  fillColor: Theme.of(context).backgroundColor),
              onSaved: (value) {
                _emailAddress = value!;
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        _isLoading
            ? Positioned(
            right: 50.0,
            child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),

                      side: BorderSide(
                          color: Theme.of(context).cardColor),
                    ),
                  )),
              onPressed: _submitForm,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Entypo.key,
                    size: 18,
                  )
                ],
              )),
            ),
      ],
    ));
  }

    /*var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ColorConsts.gradiendFStart,
                ColorConsts.gradiendLStart])),
          //new LinearGradient(colors: [Colors.blue, Colors.indigoAccent])),
        //[ColorConsts.gradiendFStart, ColorConsts.gradiendLStart],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: height * 0.15,
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.15),
              height: height * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: ListView(
                children: [
                  SizedBox(height: height * 0.08),
                  Text(
                    'reset password'.toUpperCase(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: width * 0.8,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Your Email * ",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.blue),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Center(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [ColorConsts.starterColor,
                                ColorConsts.endcolor]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey,
                                offset: Offset(2, 2))
                          ]),
                      child: Text(
                        "Reset".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }*/
}
