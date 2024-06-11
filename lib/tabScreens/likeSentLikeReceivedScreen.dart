import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class LikeSentLikeReceivedScreen extends StatefulWidget {
  const LikeSentLikeReceivedScreen({super.key});

  @override
  State<LikeSentLikeReceivedScreen> createState() => _LikeSentLikeReceivedScreenState();
}

class _LikeSentLikeReceivedScreenState extends State<LikeSentLikeReceivedScreen> {
  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likeList = [];
  getLikedListKeys() async {
    if(isLikeSentClicked){
      var likeSentDocument = await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID.toString())
          .collection("likeSent")
          .get();
      for(int i=0; i < likeSentDocument.docs.length; i++){
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(likeSentList);
    }
    else{
      var likeReceivedDocument = await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID.toString())
          .collection("likeReceived")
          .get();
      for(int i=0; i < likeReceivedDocument.docs.length; i++){
        likeReceivedList.add(likeReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(likeReceivedList);
    }



  }
  getKeysDataFromUsersCollection(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance.collection("Users").get();

    for(int i=0; i < allUsersDocument.docs.length; i++){
      for(int k=0 ; k<keysList.length; k++){
        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k]){
          likeList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likeList;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikedListKeys();
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
                likeSentList.clear();
                likeSentList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likeList.clear();
                likeList = [];
                setState(() {
                  isLikeSentClicked = true;
                });
                getLikedListKeys();
              },
              child: Text(
                "My Likes",
                style: TextStyle(
                    color: isLikeSentClicked ? Colors.white : Colors.grey,
                    fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
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
                likeSentList.clear();
                likeSentList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likeList.clear();
                likeList = [];
                setState(() {
                  isLikeSentClicked = false;
                });
                getLikedListKeys();
              },
              child: Text(
                "Liked Me",
                style: TextStyle(
                    color: isLikeSentClicked ? Colors.grey : Colors.white,
                    fontWeight: isLikeSentClicked ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: likeList.isEmpty ? Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white,size: 60,),
      ): GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(likeList.length, (index){
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
                            image: NetworkImage(likeList[index]["imageProfile"]),
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
                              "${likeList[index]["name"]} ⦿ ${likeList[index]["age"]}",
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
                                    "${likeList[index]["city"]}, ${likeList[index]["country"]}",
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
