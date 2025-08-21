import 'dart:developer';
import 'package:firebase_ahthentication_app/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   FirebaseAuth auth = FirebaseAuth.instance;
   Future<void> getLogOut()async{
     try{
       auth.signOut();
       Get.snackbar('Logout', 'Logout successful');
       Get.offAll(() => SignInScreen());
     }catch(e){
       Get.snackbar('Failed', 'logout failed');
       log("logout failed $e");
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(child: Text('AppBar')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                getLogOut();
              },
              icon: Icon(Icons.logout, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
