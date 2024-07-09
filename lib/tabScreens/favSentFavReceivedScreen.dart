import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FavSentFavReceivedScreen extends StatefulWidget {

  const FavSentFavReceivedScreen({super.key});

  @override
  State<FavSentFavReceivedScreen> createState() => _FavSentFavReceivedScreenState();
}

class _FavSentFavReceivedScreenState extends State<FavSentFavReceivedScreen> {
  //all user
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);

  List<Person> get allUsersProfileList => usersProfileList.value;

  bool isFavoriteSentClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoriteList = [];
  List matchedList = [];

  startChattingInWhatsApp(String receiverPhoneNumber) async{
    var androidUrl = "whatsapp://send?phone=$receiverPhoneNumber&text=Hi, I found your profile on dating app.";
    var iosUrl ="https://wa.me/$receiverPhoneNumber?text=${Uri.parse('Hi, I found your profile on dating app.')}";

    try{
      if(Platform.isIOS){
        await launchUrl((Uri.parse(iosUrl)));
      }
      else{
        await launchUrl((Uri.parse(androidUrl)));
      }
    }
    on Exception{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text("Whatsapp Not Found"),
              content: const Text("Whatsapp is not installed."),
              actions: [
                TextButton(
                    onPressed: (){
                      Get.back();
                    },
                    child: const Text("Ok"))
              ],
            );
          }
      );
    }
  }

  getAllUsers(){
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


  getFavoriteListKeys() async {
    if(isFavoriteSentClicked){
      var favoriteSentDocument = await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID.toString())
          .collection("favoriteSent")
          .get();
      for(int i=0; i < favoriteSentDocument.docs.length; i++){
          favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favoriteSentList);
    }
    else{

      //print(allUsersProfileList);

      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID.toString())
          .collection("favoriteReceived")
          .get();
      for(int i=0; i < favoriteReceivedDocument.docs.length; i++){
        favoriteReceivedList.add(favoriteReceivedDocument.docs[i].id);
      }

      for(int i = 0; i < allUsersProfileList.length ;i++){
        // print(allUsersProfileList[i].uid);
        List<String> otherFavSentList = [];
        var  otherFavSentDocument = await FirebaseFirestore.instance
        .collection("Users").doc(allUsersProfileList[i].uid)
        .collection("favoriteSent").get();

        for(int i=0; i < otherFavSentDocument.docs.length; i++){
          otherFavSentList.add(otherFavSentDocument.docs[i].id);
        }
        List.generate(otherFavSentList.length, (index){
          otherFavSentList[index] == currentUserID ? matchedList.add(allUsersProfileList[i].uid) : null;
        });

      }

      getKeysDataFromUsersCollection(favoriteReceivedList);
    }


  }

  getKeysDataFromUsersCollection(List<String> keysList)async{
    // var allUsersDocument = await FirebaseFirestore.instance.collection("Users").get();
    //
    // for(int i=0; i < allUsersDocument.docs.length; i++){
    //   for(int k=0 ; k<keysList.length; k++){
    //     if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k]){
    //       favoriteList.add(allUsersDocument.docs[i].data());
    //     }
    //   }
    // }
    // setState(() {
    //   favoriteList;
    // });
    var allUsersDocument = await FirebaseFirestore.instance.collection("Users").get();

    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      var userData = allUsersDocument.docs[i].data();
      String userUID = userData["uid"];

      if (keysList.contains(userUID)) {
        // Add both the user data and the UID to the favorite list
        favoriteList.add({
          'uid': userUID,
          ...userData,
        });
      }
    }

    setState(() {
      // Notify the UI of the update to the favorite list
      favoriteList;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteListKeys();
    getAllUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                favoriteSentList.clear();
                favoriteSentList = [];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoriteList.clear();
                favoriteList = [];
                setState(() {
                  isFavoriteSentClicked = true;
                });
                getFavoriteListKeys();
              },
              child: Text(
                "My Favorites",
                style: TextStyle(
                  color: isFavoriteSentClicked ? Colors.white : Colors.grey,
                  fontWeight: isFavoriteSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14
                ),
              ),
            ),
            const Text(
              "   |   ",
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            TextButton(
              onPressed: (){
                favoriteSentList.clear();
                favoriteSentList = [];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoriteList.clear();
                favoriteList = [];
                setState(() {
                  isFavoriteSentClicked = false;
                });
                getFavoriteListKeys();
              },
              child: Text(
                "In their favorites",
                style: TextStyle(
                    color: isFavoriteSentClicked ? Colors.grey : Colors.white,
                    fontWeight: isFavoriteSentClicked ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: favoriteList.isEmpty ? const Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white,size: 60,),
      ): GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(favoriteList.length, (index){
          // print(favoriteList[index]["uid"]);
          // print(matchedList);

          bool isMatched = matchedList.contains(favoriteList[index]["uid"]);

          return GridTile(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Card(
                color: Colors.blue.shade200,
                child: GestureDetector(
                  onTap: (){

                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(favoriteList[index]["imageProfile"]),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isMatched)
                              GestureDetector(
                                onTap: () {
                                  startChattingInWhatsApp(favoriteList[index]["phoneNo"].toString());
                                },
                                child: Image.asset("images/chat.png", width: 70),
                              ),
                            const Spacer(),
                            //Name - Age
                            Text(
                              "${favoriteList[index]["name"]} ⦿ ${favoriteList[index]["age"]}",
                              maxLines: 2,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // Icon - city - country
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "${favoriteList[index]["city"]}, ${favoriteList[index]["country"]}",
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
