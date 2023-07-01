import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilities/app_color.dart';
import '../../model/user_dm.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "register screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: const Text(
          "Register",
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                      labelText: "user name",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: AppColors.hintColor,
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
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
                      //todo: will make function to take data and go to home page
                      createAccount();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create account",
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: 30,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    try {
      showLoading();
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      hideLoading();
      await saveUserInFireStore(credential.user!.uid, emailController.text, userController.text);
      UserDM.currentUser = UserDM(
          id: credential.user!.uid,
          email: emailController.text,
          userName: userController.text);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } on FirebaseAuthException catch (exception) {
      hideLoading();
      if (exception.code == 'weak-password') {
        showMyDialog(
            message:
                "weak password. please try another one with character length more than 6");
      } else if (exception.code == 'email-already-in-use') {
        showMyDialog(
            message: "the email is already in use please try another one");
      }
    } catch (e) {
      showMyDialog(title: "error");
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

  Future saveUserInFireStore(String uid, String email, String userName) {
    CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
    DocumentReference userDocument = userCollection.doc(uid);
    return userDocument.set({"id": uid, "email": email, "username": userName});
  }
}
