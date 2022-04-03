import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_store_app/consts/colors.dart';
import 'package:furniture_store_app/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  bool _isLoadingG = false;


  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim()).then ((value) =>
        Navigator.canPop(context) ? Navigator.pop(context): null);
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

  //GOOGLE SIGN IN
  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          //DATE DATE
          var date = DateTime.now().toString();
          var dateparse = DateTime.parse(date);
          var formattedDate ="${dateparse.day}-${dateparse.month}-${dateparse.year}";

          final authResult = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          //--------SAVE USER INFO ON GOOGLE SIGN IN
          await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
            'id': authResult.user!.uid,
            'name': authResult.user!.displayName,
            'email': authResult.user!.email,
            'phoneNumber': authResult.user!.phoneNumber,
            'imageurl': authResult.user!.photoURL,
            'joinedAt': formattedDate,
            'createdAt': Timestamp.now(),
          });
        } on FirebaseAuthException catch (error) {
          _globalMethods.authErrorHandle(error.message, context);
          //print('Error has occurred: ${error.message}');
        }
      }
    }
  }

  void _loginAnonymously() async {
    setState(() {
      _isLoadingG = true;
    });
    try {
      await _auth.signInAnonymously();
      Navigator.canPop(context)? Navigator.pop(context) : null;
    } on FirebaseAuthException catch (error) {
      _globalMethods.authErrorHandle(error.message, context);
      print('Error has occurred: ${error.message}');
    } finally {
      setState(() {
        _isLoadingG = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [ColorConsts.gradiendFStart, ColorConsts.gradiendLStart],
                    [ColorConsts.gradiendFEnd, ColorConsts.gradiendLEnd],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    //  color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.flaticon.com/icons/png/128/869/869636.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
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
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('Password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _obscureText,
                            onEditingComplete: _submitForm,
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context, ForgetPassword.routeName
                                    );
                                  },
                                  child: Text(
                                    'Forget password?',
                                    style: TextStyle(
                                        color: Colors.blue.shade900,
                                        decoration: TextDecoration.underline),
                                  )),
                            ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: ColorConsts.backgroundColor),
                                      ),
                                    )),
                                    onPressed: _submitForm,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Entypo.user,
                                          size: 18,
                                        )
                                      ],
                                    )),
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: ColorConsts.gradiendLStart,
                                  thickness: 2,
                                ),
                              ),
                            ),
                            Text(
                              'Or continue with',
                              style: TextStyle(color: ColorConsts.gradiendLEnd),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Divider(
                                  color: ColorConsts.gradiendLStart,
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlineButton(
                              onPressed: _googleSignIn,
                              shape: StadiumBorder(),
                              highlightedBorderColor: Colors.red.shade200,
                              borderSide: BorderSide(width: 2, color: Colors.red),
                              child: Text('Google +'),
                            ),
                            _isLoadingG ? CircularProgressIndicator() :
                            OutlineButton(
                              onPressed: () {
                                _loginAnonymously();
                                //Navigator.pushNamed(context, BottomBarScreen.routeName);
                              },
                              shape: StadiumBorder(),
                              highlightedBorderColor: Colors.deepPurple.shade200,
                              borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                              child: Text('Sign in as a guest'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
