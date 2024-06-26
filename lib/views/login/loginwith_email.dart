import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:house_to_motive/utils/utils.dart';
import 'package:house_to_motive/widgets/custom_socialbutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/loginbutton.dart';
import '../../widgets/custom_field.dart';
import '../createan_account/signup_screen.dart';
import '../screens/navigation_bar/home_page.dart';
import 'loginwith_phonenumber.dart';

class LoginWithEmailScreen extends StatelessWidget {
  LoginWithEmailScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  void Login() async {
    // final _firebaseMessaging = FirebaseMessaging.instance;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) async {
      // final fCMToken = await _firebaseMessaging.getToken();
      updateDeviceToken();
      prefs.setBool('isLogin', true);
      Get.to(
        () => HomePage(),
        transition: Transition.downToUp,
      );
      Utils().ToastMessage('Login Successfully');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().ToastMessage(error.toString());
    });
  }

  Future<void> updateDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'Device Token': deviceToken});
  }

  // Future<void> getAllToken() async {
  //   FirebaseFirestore.instance.collection('users').doc().get();
  //
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> snapshot =
  //         await FirebaseFirestore.instance.collection('users').get();
  //     List<String> deviceTokens = [];
  //
  //     snapshot.docs.forEach((doc) {
  //       String deviceToken = doc.data()['Device Token'];
  //
  //       if (deviceToken != null || deviceToken.isNotEmpty) {
  //         deviceTokens.add(deviceToken);
  //         print('device token: ${deviceTokens.length}');
  //       }
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.31,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: Image.asset(
                          'assets/pngs/htmimage1.png',
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/svgs/splash-logo.png',
                          width: 144,
                          height: 144,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 50,
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/back_btn.svg',
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    children: [
                      const Text(
                        'Login To Continue',
                        style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff025B8F),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'Welcome back to HouseToMotive!',
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff424B5A),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButtonWithIcon(
                              ontap: () {
                                Get.to(
                                    () => const LoginWithPhoneNumberScreen());
                              },
                              title: 'Phone Number',
                              svg: "assets/svgs/social/Call.svg"),
                          CustomSocialButton(
                              svg: "assets/svgs/social/google.svg",
                              ontap: () {
                                authenticationController.signInWithGoogle();
                              }),
                          CustomSocialButton(
                            svg: "assets/svgs/social/fb.svg",
                            ontap: () {
                              signInWithFacebook();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      const Text(
                        'Or with Email',
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff424B5A),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomEmailField(
                        textEditingController: emailController,
                        title: 'Email',
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      CustomPasswordField(
                          title: 'Enter password',
                          textEditingController: passwordController),
                      SizedBox(height: screenHeight * 0.03),
                      CustomButton(
                        title: "Login",
                        ontap: () {
                          if (loginFormKey.currentState!.validate()) {
                            Login();
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'New User?',
                            style: TextStyle(
                              fontFamily: 'ProximaNova',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff424B5A),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignupScreen());
                            },
                            child: const Text(
                              ' Sign Up',
                              style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff025B8F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationController extends GetxController {
  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          Get.to(() => HomePage());
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            log('Account exists with different credential');
          } else if (e.code == 'invalid-credential') {
            log('Invalid Credential');
          }
        } catch (e) {
          log(e.toString());
        }
      }
    }

    return user;
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}
