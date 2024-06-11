import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class ViewSentViewReceivedScreen extends StatefulWidget {
  const ViewSentViewReceivedScreen({super.key});

  @override
  State<ViewSentViewReceivedScreen> createState() => _ViewSentViewReceivedScreenState();
}

class _ViewSentViewReceivedScreenState extends State<ViewSentViewReceivedScreen> {
  bool isViewSentClicked = true;
  List<String> viewSentList = [];
  List<String> viewReceivedList = [];
  List viewList = [];
  getViewsListKeys() async {
    if(isViewSentClicked){
      var viewSentDocument = await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID.toString())
          .collection("viewSent")
          .get();
      for(int i=0; i < viewSentDocument.docs.length; i++){
        viewSentList.add(viewSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(viewSentList);
    }
    else{
      var viewReceivedDocument = await FirebaseFirestore.instance
          .collection("Users").doc(currentUserID.toString())
          .collection("viewReceived")
          .get();
      for(int i=0; i < viewReceivedDocument.docs.length; i++){
        viewReceivedList.add(viewReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(viewReceivedList);
    }



  }
  getKeysDataFromUsersCollection(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance.collection("Users").get();

    for(int i=0; i < allUsersDocument.docs.length; i++){
      for(int k=0 ; k<keysList.length; k++){
        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k]){
          viewList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      viewList;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getViewsListKeys();
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
                viewSentList.clear();
                viewSentList = [];
                viewReceivedList.clear();
                viewReceivedList = [];
                viewList.clear();
                viewList = [];
                setState(() {
                  isViewSentClicked = true;
                });
                getViewsListKeys();
              },
              child: Text(
                "Profile I saw",
                style: TextStyle(
                    color: isViewSentClicked ? Colors.white : Colors.grey,
                    fontWeight: isViewSentClicked ? FontWeight.bold : FontWeight.normal,
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
                viewSentList.clear();
                viewSentList = [];
                viewReceivedList.clear();
                viewReceivedList = [];
                viewList.clear();
                viewList = [];
                setState(() {
                  isViewSentClicked = false;
                });
                getViewsListKeys();
              },
              child: Text(
                "View My Profile",
                style: TextStyle(
                    color: isViewSentClicked ? Colors.grey : Colors.white,
                    fontWeight: isViewSentClicked ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: viewList.isEmpty ? Center(
        child: Icon(Icons.person_off_sharp, color: Colors.white,size: 60,),
      ): GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(viewList.length, (index){
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
                            image: NetworkImage(viewList[index]["imageProfile"]),
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
                              "${viewList[index]["name"]} ⦿ ${viewList[index]["age"]}",
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
                                    "${viewList[index]["city"]}, ${viewList[index]["country"]}",
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
