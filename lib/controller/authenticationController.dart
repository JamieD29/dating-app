import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/authenticationScreen/loginScreen.dart';
import 'package:dating_app/homeScreen/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dating_app/models/person.dart' as personModel;

class AuthenticationController extends GetxController
{
  static AuthenticationController authController = Get.find();
  late Rx<User?> firebaseCurrentUser;

  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  pickImageFileFromGallery() async{
     imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(imageFile != null){
      Get.snackbar("Profile Image", "You have successfully picked your profile image from gallery");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFileFromPhoneCamera() async{
     imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(imageFile != null){
      Get.snackbar("Profile Image", "You have successfully captured your profile image using camera");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  Future<String> uploadImageToStorage(File imgFile)async{
    Reference referenceStorage = FirebaseStorage.instance.ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask task = referenceStorage.putFile(imgFile);
    TaskSnapshot snapshot = await task;

    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

    return downloadUrlOfImage;
  }

  createNewUserAccount(
      //Personal Info
      File imageProfile, String email, String password,
      String name,
      String age,String phoneNo,
      String city,String country,
      String profileHeadings,String lookingForInaPartner,
      //Appearance
      String height,String weight,
      String bodyType,
      //LifeStyle
      String drink,String smoke,
      String martialStatus,String haveChildren,
      String noOfChildren,String profession,
      String employmentStatus,String income,
      String livingSituation,String willingToRelocate,
      String relationshipType,
      //Background - Cultural values
      String nationality,String education,
      String languageSpoken,String religion,
      String ethnicity
      ) async
  {
    try{
      //1. authenticate user and create User With Email and Password
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      //2. upload image to storage
      String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);
      //3. save user info to firestore database
      personModel.Person personInstance = personModel.Person(
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        email: email,
        password: password,
        name: name,
        age: int.parse(age),
          phoneNo: phoneNo,
          city: city,
          country: country,
          profileHeadings: profileHeadings,
          lookingForInaPartner: lookingForInaPartner,
          publishedDateTime: DateTime.now().millisecondsSinceEpoch,
        //Appearance
        height: height,
        weight: weight,
        bodyType: bodyType,
        //Lifestyle
        drink: drink,
        smoke: smoke,
        martialStatus: martialStatus,
        haveChildren: haveChildren,
        noOfChildren: noOfChildren,
        profession: profession,
        employmentStatus: employmentStatus,
        income: income,
        livingSituation: livingSituation,
        willingToRelocate: willingToRelocate,
        relationshipType: relationshipType,
        //Background - Cultural values
        nationality: nationality,
        education: education,
        languageSpoken: languageSpoken,
        religion: religion,
        ethnicity: ethnicity,

      );

      await FirebaseFirestore.instance.collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid).set(personInstance.toJson());

      Get.snackbar("Account Created", "Congratulation, your account has been created.");
      Get.to(HomeScreen());
    }catch(errorMsg){
      Get.snackbar("Account Creation Unsuccessful", "Error occurred: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser)async{
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailUser, password: passwordUser);
        Get.snackbar("Logged-in Successful", "You're logged-in successfully");
        Get.to(HomeScreen());
      }catch(errorMsg){
        Get.snackbar("Login Unsuccessful", "Error occurred: $errorMsg");
      }
  }
  checkIfUserIsLoggedIn(User? currentUser){
    if(currentUser == null){
      Get.to(LoginScreen());
    }else{
      Get.to(HomeScreen());
    }
  }

  @override
  void onReady() {
    super.onReady();
    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }
}