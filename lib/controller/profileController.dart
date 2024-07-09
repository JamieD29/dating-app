import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController{
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);

  List<Person> get allUsersProfileList => usersProfileList.value;

  getResults(){
    onInit();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if(chosenGender == null || chosenAge == null || chosenCountry == null){
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
    }else{
      usersProfileList.bindStream(
          FirebaseFirestore.instance
              .collection("Users")
              .where("gender", isEqualTo: chosenGender.toString().toLowerCase())
              .where("age", isGreaterThanOrEqualTo: int.parse(chosenAge.toString()))
              .where("country", isEqualTo: chosenCountry.toString())
              .snapshots().map((QuerySnapshot queryDataSnapshot){
            List<Person> profileList = [];
            for(var eachProfile in queryDataSnapshot.docs){
              profileList.add(Person.fromDataSnapshot(eachProfile));
            }
            return profileList;
          })
      );
    }


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


      sendNotificationToUser(toUserID, "Favorite", senderName);
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
      sendNotificationToUser(toUserID, "Like", senderName);
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
      sendNotificationToUser(toUserID, "View", senderName);
    }
    update();
  }
  sendNotificationToUser(receiverID, featureType, senderName) async{
    String userDeviceToken = "";
    await FirebaseFirestore.instance
    .collection("Users")
    .doc(receiverID).get()
    .then((snapshot){
      if(snapshot.data()!["userDeviceToken"] != null){
        userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
      }
    });
    notificationFormat(
      userDeviceToken,
      receiverID,
      featureType,
      senderName
    );
  }

  // Future<String> getAccessToken() async {
  //   final serviceAccountFile = File('service-account.json');
  //   final serviceAccountJson = await serviceAccountFile.readAsString();
  //
  //   final scopes = [
  //     'https://www.googleapis.com/auth/cloud-platform'  // Example scope, replace with your needs
  //   ];
  //
  //   final serviceAccountCredentials = ServiceAccountCredentials.fromJson(serviceAccountJson);
  //
  //   final client = await clientViaServiceAccount(serviceAccountCredentials, scopes);
  //
  //   final accessToken = client.credentials.accessToken.data;
  //
  //   client.close();
  //
  //   return accessToken;
  // }


  // notificationFormat(userDeviceToken, receiverID, featureType, senderName) async{
  //   String fcmToken = "ya29.c.c0AY_VpZiZ8uTV4g_sNfuzyus0xqIlINWm6boSzW3ikKCGQzA3ozMhsQF-vVNb3GSdu70-kjXeTDjbnFAL23rRxf38cGs8N2kYD1sQNOU4EZjW6S85TamgljsyYvzUaN0-rES9r-hnBcvVwSfjv6iPt0h8ulTNy97j2XfKrKbOGloS8pr3vSquRcUmduoqJr17tZ4auVT9rheJ4HTZWtgV6Q5tYU5VPLAUSVpAjB_xSEoyMMtM2h6Qz3PVy1toqg3X8lXdb1lzPO_5OFDYRSU-IhtHezUBeD7wXNBnRNSVKe91eFFdjvSoa60cAv1n1aQynBB9yySge5exxRwRQ55u0lSrohDyVA-aRMfwB-8IEh47UW6LnP4tOdYG384PFfi12y55lbX8wmQOIBgqoJ3v7wiO26IcUnIaM-p3vqaZ0-MaM-9IwlkOSvdOB2F6FBzjth5UXFi94wIsS72v8b737q5Bi4U-Qnd8w65_rnsOujbfgoU52r9shSByQ7hIUcajom-X4Wz_z527WObtrm1sb1w4szpMJor9S_t8FnSlgSWYJMIuMsk6vZow4mh3MblvmdWcVsSxZlVydyVtl9a9jlc378Zys2oSlajFz6a7Rp4jXhiIRWsg7IOVOoxgzf9ZxIfjb5qgpIzYiOBkUn0pSI1Qu6OZpi4XMM72t_lbhjxViI8frrV_faS9n5frfo72bfI2JQOuhih2xwUq6OBa2_efp-RZOeuY_J2BVxM9jU9nehmB1O3w_x6znJb72wpa0-WaVp-QSlJSMdXsbhliR5bUqy2eq8v_bI5I8Yz7j3g1aQmMqe_4r9fmyOmvZB0-V69agkJwxZtqp-_qOtyWfdu0Op0JQqy-02quaXecUIuhv21JsSISJ7zaM0d_mM526_zt27eg7y59cyhzlW__qno9_qYSs0e0siswrtjSJgj_8iaake-pjrxgM4SskQX-zwpxtI6c8UWY8For8Vkkn6IsBf5YynFoUv_mWkU60dw-Qk59U8q8gpm";
  //
  //   Map<String, String> headerNotification = {
  //     "Content-type": "application/json",
  //     "Authentication": "Bearer $fcmToken"
  //   };
  //
  //   Map bodyNotification = {
  //     "body": "you have received a new $featureType from $senderName. Click to see.",
  //     "title": "New $featureType",
  //   };
  //   Map dataMap = {
  //     "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //     "id": 1,
  //     "status": "done",
  //     "userID": receiverID,
  //     "senderID": currentUserID
  //   };
  //   Map notificationOfficialFormat = {
  //     // "notification": bodyNotification,
  //     // "data": dataMap,
  //     // "priority": "high",
  //     // "to" : userDeviceToken,
  //     "message":{
  //       "token": userDeviceToken,
  //       "notification": bodyNotification
  //     },
  //     "data": dataMap
  //   };
  //
  //   http.post(
  //     Uri.parse("https://fcm.googleapis.com/v1/fcm/send"),
  //     headers: headerNotification,
  //     body: jsonEncode(notificationOfficialFormat)
  //   );
  //
  // }

  notificationFormat(userDeviceToken, receiverID, featureType, senderName) async {
    final serviceAccountFile = File('C:/User/Asus/Desktop/dating_app/lib/utils/dating-app-44e1f-firebase-adminsdk-s7ldo-9cd00cad62.json');
    final serviceAccountJson = json.decode(await serviceAccountFile.readAsString());
    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    var client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    var url = Uri.parse('https://fcm.googleapis.com/v1/projects/dating-app-44e1f/messages:send');

    Map<String, dynamic> notification = {
      "message": {
        "token": userDeviceToken,
        "notification": {
          "body": "You have received a new $featureType from $senderName. Click to see.",
          "title": "New $featureType"
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done",
          "userID": receiverID,
          "senderID": currentUserID
        }
      }
    };

    var response = await client.post(url, body: json.encode(notification));

    if (response.statusCode == 200) {
      print("Notification sent successfully.");
    } else {
      print("Failed to send notification. Status code: ${response.statusCode}");
    }

    client.close();
  }

}