import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_screen.dart';
import '../signin_screen.dart';

class AuthenticationController extends GetxController {
  bool inProgress = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn signIn=GoogleSignIn.instance;

  Future<void> getResetPassword(String email)async{
    inProgress=true;
    update();
    try{
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Check your email');
      Get.offAll(() => SignInScreen());
    }catch(e){
      Get.snackbar('Error', e.toString());
    }finally{
      inProgress=false;
      update();
    }
  }

  Future<bool> getSignUP(String email, String password) async {
    inProgress = true;
    update();
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('Registration successfully');
      return true;
    } catch (e) {
      log("Registration failed $e");
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      inProgress = false;
      update();
    }
  }

  Future<bool> getSignIn(String email, String password) async {
    inProgress = true;
    update();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      log("Sign in successful");
      return true;                                            
    } catch (e) {
      log("sign in failed $e");
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      inProgress = false;
      update();
    }
  }

  void continueWithGoogle() async {
    String webClientId = '766022526722-1846omc3drbkqurjvejugpbq29mp2s03.apps.googleusercontent.com';
    try {
      await signIn.initialize(serverClientId: webClientId);
      GoogleSignInAccount account = await signIn.authenticate();
      GoogleSignInAuthentication googleAuth = account.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken
      );
      inProgress = true;
      update();
      await auth.signInWithCredential(credential);
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar('Failed!', e.toString());
    } finally {
      inProgress = false;
      update();
    }

  }



  @override
  void onInit() {
    super.onInit();
    nextScreen();
  }
  void nextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      Get.offAll(() => user == null ? SignInScreen() : HomeScreen());
    });
  }
}
