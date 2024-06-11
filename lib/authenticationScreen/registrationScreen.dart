import 'dart:io';

import 'package:dating_app/authenticationScreen/loginScreen.dart';
import 'package:dating_app/controller/authenticationController.dart';
import 'package:dating_app/widgets/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Personal Info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController = TextEditingController();
  TextEditingController lookingForInaPartnerTextEditingController = TextEditingController();

  //Appearance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();
  //Life Style
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController martialStatusTextEditingController = TextEditingController();
  TextEditingController haveChildrenTextEditingController = TextEditingController();
  TextEditingController noOfChildrenTextEditingController = TextEditingController();
  TextEditingController professionTextEditingController = TextEditingController();
  TextEditingController employmentStatusTextEditingController = TextEditingController();
  TextEditingController incomeTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController = TextEditingController();
  TextEditingController willingToRelocateTextEditingController = TextEditingController();
  TextEditingController relationshipTypeTextEditingController = TextEditingController();
  //Background - Cultural values
  TextEditingController nationalityTextEditingController = TextEditingController();
  TextEditingController educationTextEditingController = TextEditingController();
  TextEditingController languageSpokenTextEditingController = TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController ethnicityTextEditingController = TextEditingController();

  bool showProgressBar = false;

  var authenticationController = AuthenticationController.authController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "to get Started Now",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white60,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              authenticationController.imageFile == null ?
              //Choose Img Circle
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    "images/profile_avatar.jpg"
                ),
                backgroundColor: Colors.black,
              ) : Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: FileImage(
                      File(
                        authenticationController.imageFile!.path,
                      )
                    ),
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed:() async{
                    await authenticationController.pickImageFileFromGallery();
                    setState(() {
                      authenticationController.imageFile;
                    });
                  } , icon: Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 30,
                  ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(onPressed:() async {
                   await  authenticationController.captureImageFileFromPhoneCamera();
                   setState(() {
                     authenticationController.imageFile;
                   });
                  } , icon: Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                    size: 30,
                  ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Personal Information: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              //Name
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: nameTextEditingController,
                  labelText: "Name",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
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
                height: 24,
              ),
              //Age
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: ageTextEditingController,
                  labelText: "Age",
                  iconData: Icons.numbers,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //PhoneNo
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: phoneNoTextEditingController,
                  labelText: "Phone number",
                  iconData: Icons.phone_outlined,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //City
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: cityTextEditingController,
                  labelText: "City",
                  iconData: Icons.location_city,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Country
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: countryTextEditingController,
                  labelText: "Country",
                  iconData: Icons.location_city,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //profileHeading
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: profileHeadingTextEditingController,
                  labelText: "Profile Heading",
                  iconData: Icons.text_fields,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Looking For a partner
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: lookingForInaPartnerTextEditingController,
                  labelText: "What's you looking for in a partner",
                  iconData: Icons.face,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Appearance
              const Text(
                "Appearance: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              //Height
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: heightTextEditingController,
                  labelText: "Height",
                  iconData: Icons.insert_chart,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),

              //Weight
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: weightTextEditingController,
                  labelText: "Weight",
                  iconData: Icons.table_chart,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Body Type
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: bodyTypeTextEditingController,
                  labelText: "Body Type",
                  iconData: Icons.type_specimen,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Appearance
              const Text(
                "Life Style: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              //Drink
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: drinkTextEditingController,
                  labelText: "Drinking",
                  iconData: Icons.local_drink,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Smoke
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: smokeTextEditingController,
                  labelText: "Smoking",
                  iconData: Icons.smoking_rooms,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Martial Status
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: martialStatusTextEditingController,
                  labelText: "Martial Status",
                  iconData: CupertinoIcons.person_2,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Children
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: haveChildrenTextEditingController,
                  labelText: "Do you have children?",
                  iconData: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height: 24,
              ),
              //Number of Children
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: noOfChildrenTextEditingController,
                  labelText: "Number of Children",
                  iconData: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //profession
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: professionTextEditingController,
                  labelText: "Profession",
                  iconData: Icons.business_center,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Employment
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: employmentStatusTextEditingController,
                  labelText: "Employment",
                  iconData: CupertinoIcons.rectangle_stack_person_crop_fill,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Income
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: incomeTextEditingController,
                  labelText: "Income",
                  iconData: CupertinoIcons.money_dollar_circle_fill,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //living situation
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: livingSituationTextEditingController,
                  labelText: "Living Situation",
                  iconData: Icons.living,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Willing to Relocate
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: willingToRelocateTextEditingController,
                  labelText: "Are you willing to relocate?",
                  iconData: Icons.question_mark,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //relationship type
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: relationshipTypeTextEditingController,
                  labelText: "What relationship type are you looking for?",
                  iconData: Icons.people,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Background and Cultural values
              const Text(
                "Background and Cultural Values: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              //nationality
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: nationalityTextEditingController,
                  labelText: "Nationality",
                  iconData: Icons.flag,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Education
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: educationTextEditingController,
                  labelText: "Education",
                  iconData: Icons.book,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Language
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: languageSpokenTextEditingController,
                  labelText: "Languages",
                  iconData: CupertinoIcons.t_bubble,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Religion
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: religionTextEditingController,
                  labelText: "Religion",
                  iconData: Icons.book,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Ethnicity
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: ethnicityTextEditingController,
                  labelText: "Ethnicity",
                  iconData: CupertinoIcons.eye,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //Btn Sign upppp
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
                    if(authenticationController.imageFile != null){
                      if(
                      nameTextEditingController.text.trim().isNotEmpty
                          && emailTextEditingController.text.trim().isNotEmpty
                      && passwordTextEditingController.text.trim().isNotEmpty
                      && ageTextEditingController.text.trim().isNotEmpty
                      && phoneNoTextEditingController.text.trim().isNotEmpty
                      && cityTextEditingController.text.trim().isNotEmpty
                      && countryTextEditingController.text.trim().isNotEmpty
                      && profileHeadingTextEditingController.text.trim().isNotEmpty
                      && lookingForInaPartnerTextEditingController.text.trim().isNotEmpty
                      //Appearance
                      && heightTextEditingController.text.trim().isNotEmpty
                      && weightTextEditingController.text.trim().isNotEmpty
                      && bodyTypeTextEditingController.text.trim().isNotEmpty
                      //Life style
                      && drinkTextEditingController.text.trim().isNotEmpty
                      && smokeTextEditingController.text.trim().isNotEmpty
                      && martialStatusTextEditingController.text.trim().isNotEmpty
                      && haveChildrenTextEditingController.text.trim().isNotEmpty
                      && noOfChildrenTextEditingController.text.trim().isNotEmpty
                      && professionTextEditingController.text.trim().isNotEmpty
                      && employmentStatusTextEditingController.text.trim().isNotEmpty
                      && incomeTextEditingController.text.trim().isNotEmpty
                      && livingSituationTextEditingController.text.trim().isNotEmpty
                      && willingToRelocateTextEditingController.text.trim().isNotEmpty
                      && relationshipTypeTextEditingController.text.trim().isNotEmpty
                          //Background - Cultural values
                      && nationalityTextEditingController.text.trim().isNotEmpty
                      && educationTextEditingController.text.trim().isNotEmpty
                      && languageSpokenTextEditingController.text.trim().isNotEmpty
                      && religionTextEditingController.text.trim().isNotEmpty
                      && ethnicityTextEditingController.text.trim().isNotEmpty

                      ){
                        setState(() {
                          showProgressBar = true;
                        });
                       await authenticationController.createNewUserAccount(
                          authenticationController.profileImage!,
                          emailTextEditingController.text.trim(),
                          passwordTextEditingController.text.trim(),
                          nameTextEditingController.text.trim(),
                          ageTextEditingController.text.trim(),
                          phoneNoTextEditingController.text.trim(),
                          cityTextEditingController.text.trim(),
                          countryTextEditingController.text.trim(),
                          profileHeadingTextEditingController.text.trim(),
                          lookingForInaPartnerTextEditingController.text.trim(),
                          //Appearance
                          heightTextEditingController.text.trim(),
                          weightTextEditingController.text.trim(),
                          bodyTypeTextEditingController.text.trim(),
                          //Lifestyle
                          drinkTextEditingController.text.trim(),
                          smokeTextEditingController.text.trim(),
                          martialStatusTextEditingController.text.trim(),
                          haveChildrenTextEditingController.text.trim(),
                          noOfChildrenTextEditingController.text.trim(),
                          professionTextEditingController.text.trim(),
                          employmentStatusTextEditingController.text.trim(),
                          incomeTextEditingController.text.trim(),
                          livingSituationTextEditingController.text.trim(),
                          willingToRelocateTextEditingController.text.trim(),
                          relationshipTypeTextEditingController.text.trim(),
                          //Background - Cultural values
                          nationalityTextEditingController.text.trim(),
                          educationTextEditingController.text.trim(),
                          languageSpokenTextEditingController.text.trim(),
                          religionTextEditingController.text.trim(),
                          ethnicityTextEditingController.text.trim(),

                        );
                        setState(() {
                          showProgressBar = false;
                          authenticationController.imageFile = null ;
                        });



                      }else{
                        Get.snackbar("A field is Empty", "Please fill out all field in text fields");
                      }
                    }else{
                      Get.snackbar("Image File Missing", "Please choose your image from gallery or capture with Camera");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Create",
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
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Get.to(LoginScreen());
                    },
                    child: const Text(
                      "Log in",
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
