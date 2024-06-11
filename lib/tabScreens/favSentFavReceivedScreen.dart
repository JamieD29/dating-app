import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class FavSentFavReceivedScreen extends StatefulWidget {
  const FavSentFavReceivedScreen({super.key});

  @override
  State<FavSentFavReceivedScreen> createState() => _FavSentFavReceivedScreenState();
}

class _FavSentFavReceivedScreenState extends State<FavSentFavReceivedScreen> {
  bool isFavoriteSentClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoriteList = [];
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
      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID.toString())
          .collection("favoriteReceived")
          .get();
      for(int i=0; i < favoriteReceivedDocument.docs.length; i++){
        favoriteReceivedList.add(favoriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favoriteReceivedList);
    }



  }
  getKeysDataFromUsersCollection(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance.collection("Users").get();

    for(int i=0; i < allUsersDocument.docs.length; i++){
      for(int k=0 ; k<keysList.length; k++){
        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k]){
          favoriteList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      favoriteList;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteListKeys();
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
      body: favoriteList.isEmpty ? Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white,size: 60,),
      ): GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(favoriteList.length, (index){
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
                                Icon(
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
