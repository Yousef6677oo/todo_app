import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/utilities/app_color.dart';

import '../../model/user_dm.dart';
import '../home_screen/home_screen.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "login screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SettingsProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: AppColors.hintColor,
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: AppColors.hintColor,
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      login();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: 30,
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text(
                    "Create account",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.hintColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    try {
      showLoading();
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      UserDM user = await getUserFromFireStore(credential.user!.uid);
      UserDM.currentUser = user;
      hideLoading();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (exception) {
      hideLoading();
      if (exception.code == 'user-not-found') {
        showMyDialog(
            message:
                "Wrong email address please make sure you wrote right one!");
      } else if (exception.code == 'wrong-password') {
        showMyDialog(
            message: "Wrong password please make sure you wrote right one!");
      } else {
        print("login exception: $exception");
        showMyDialog();
      }
    }
  }

  void showLoading() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Row(
              children: [
                Text("Loading..."),
                Spacer(),
                CircularProgressIndicator()
              ],
            ),
          );
        },
        barrierDismissible: false);
  }

  void hideLoading() {
    Navigator.pop(context);
  }

  void showMyDialog(
      {String? title,
      String message = "something went wrong, please try again later"}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: title == null
                ? const SizedBox()
                : Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
            content: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ok"))
            ],
          );
        },
        barrierDismissible: false);
  }

  Future<UserDM> getUserFromFireStore(String uid) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection("users");
    DocumentReference doc = userCollection.doc(uid);
    DocumentSnapshot snapshot = await doc.get();
    Map json = snapshot.data() as Map;
    UserDM user = UserDM(
        id: uid, email: emailController.text, userName: json["username"]);
    return user;
  }
}
