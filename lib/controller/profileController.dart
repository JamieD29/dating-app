import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);

  List<Person> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    usersProfileList.bindStream(
      FirebaseFirestore.instance
          .collection("Users")
          .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots().map((QuerySnapshot queryDataSnapshot){
            List<Person> profileList = [];
            for(var eachProfile in queryDataSnapshot.docs){
              profileList.add(Person.fromDataSnapshot(eachProfile));
            }
            return profileList;
      })
    );
  }

  favoriteSendAndFavoriteReceived(String toUserID, String senderName) async{
    var document = await FirebaseFirestore.instance
        .collection("Users").doc(toUserID)
        .collection("favoriteReceived").doc(currentUserID)
        .get();
    //remove the favorite from database
    if(document.exists )
    {
      //remove current userID from the favorite received list of that profile person [toUSerID]
      await FirebaseFirestore.instance
          .collection("Users").doc(toUserID)
          .collection("favoriteReceived").doc(currentUserID)
          .delete();
      //remove profile person [toUserID] from the favorite received list of the current user
      await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID)
          .collection("favoriteSent").doc(toUserID)
          .delete();
    }
    else //mark as favorite in database // add favorite in database
    {
      //add current userID from the favorite received list of that profile person [toUSerID]
      await FirebaseFirestore.instance
          .collection("Users").doc(toUserID)
          .collection("favoriteReceived").doc(currentUserID)
          .set({});
      //add profile person [toUserID] from the favorite received list of the current user
      await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID)
          .collection("favoriteSent").doc(toUserID)
          .set({});
      //send notification
    }
    update();
  }
  likeSendAndLikeReceived(String toUserID, String senderName) async{
    var document = await FirebaseFirestore.instance
        .collection("Users").doc(toUserID)
        .collection("likeReceived").doc(currentUserID)
        .get();
    //remove the like from database
    if(document.exists )
    {
      //remove current userID from the like received list of that profile person [toUSerID]
      await FirebaseFirestore.instance
          .collection("Users").doc(toUserID)
          .collection("likeReceived").doc(currentUserID)
          .delete();
      //remove profile person [toUserID] from the like received list of the current user
      await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID)
          .collection("likeSent").doc(toUserID)
          .delete();
    }
    else //mark as like in database // add like in database
        {
      //add current userID from the like received list of that profile person [toUSerID]
      await FirebaseFirestore.instance
          .collection("Users").doc(toUserID)
          .collection("likeReceived").doc(currentUserID)
          .set({});
      //add profile person [toUserID] from the like received list of the current user
      await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID)
          .collection("likeSent").doc(toUserID)
          .set({});
      //send notification
    }
    update();
  }
  viewSendAndViewReceived(String toUserID, String senderName) async{
    var document = await FirebaseFirestore.instance
        .collection("Users").doc(toUserID)
        .collection("viewReceived").doc(currentUserID)
        .get();
    
    if(document.exists )
    {
     print("Already in view list");
    }
    else //add new view in database
        {
      //add current userID from the like received list of that profile person [toUSerID]
      await FirebaseFirestore.instance
          .collection("Users").doc(toUserID)
          .collection("viewReceived").doc(currentUserID)
          .set({});
      //add profile person [toUserID] from the like received list of the current user
      await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID)
          .collection("viewSent").doc(toUserID)
          .set({});
      //send notification
    }
    update();
  }
}