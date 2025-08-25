import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../home_screen.dart';
import '../signin_screen.dart';

class AuthenticationController extends GetxController {
  bool inProgress = false;
  FirebaseAuth auth = FirebaseAuth.instance;

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
