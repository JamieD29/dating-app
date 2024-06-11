import 'dart:ui';
import 'package:dating_app/authenticationScreen/registrationScreen.dart';
import 'package:dating_app/controller/authenticationController.dart';
import 'package:dating_app/widgets/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;
  var  controllerAuth = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Image.asset(
                "images/logo.png",
                width: 300,
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const Text(
                "Login to find your partner",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              //Email
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: emailTextEditingController,
                  labelText: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Password
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //Btn Login
              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: InkWell(
                  onTap: () async
                  {
                    String emailUser = emailTextEditingController.text.trim();
                    String passwordUser = passwordTextEditingController.text.trim();
                    if(emailUser.isNotEmpty
                    && passwordUser.isNotEmpty){
                      setState(() {
                        showProgressBar = true;
                      });
                      await controllerAuth.loginUser(emailUser, passwordUser);
                      setState(() {
                        showProgressBar = false;
                      });
                    }else{
                      Get.snackbar("Email or password is incorrect", "Please try again.");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //Don't have an account, create a new one.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account yet? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Get.to(RegistrationScreen());
                    },
                    child: const Text(
                      "Create a new account",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              showProgressBar == true ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
              ):Container(),
            ],
          ),
        ),
      ),
    );

}
}
