import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/profileController.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/tabScreens/userDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen ({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreen();
}

class _SwippingScreen extends State<SwippingScreen> {

  ProfileController profileController = Get.put(ProfileController());
  String senderName ="";
  readUserData()async{
    await FirebaseFirestore.instance.collection("Users").doc(currentUserID).get().then((dataSnapshot){
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return PageView.builder(
          itemCount: profileController.allUsersProfileList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            final eachProfileInfo = profileController.allUsersProfileList[index];

            return DecoratedBox(
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    eachProfileInfo.imageProfile.toString(),
                  ),
                  fit: BoxFit.cover,
                )
            ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      //Filter icon button
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                            onPressed: (){

                            },
                            icon: const Icon(
                              Icons.filter_list,
                              size: 30,
                            )
                          )
                        ),
                      ) ,
                      const Spacer(),
                      //User data
                      GestureDetector(
                        onTap: (){
                          profileController.viewSendAndViewReceived(eachProfileInfo.uid.toString(), senderName);
                          //Send user to profile person userDetail screen
                          Get.to(UserDetailsScreen(userID: eachProfileInfo.uid.toString()),);
                        },
                        child: Column(
                          children: [
                            //name
                             Text(
                              eachProfileInfo.name.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //Age - City
                            Text(
                              "${eachProfileInfo.age} • ${eachProfileInfo.city}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: (){

                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)
                                      )
                                    ),
                                    child: Text(
                                      eachProfileInfo.profession.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                      ),
                                    ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                ElevatedButton(
                                  onPressed: (){

                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16)
                                      )
                                  ),
                                  child: Text(
                                    eachProfileInfo.religion.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: (){

                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16)
                                      )
                                  ),
                                  child: Text(
                                    eachProfileInfo.country.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                ElevatedButton(
                                  onPressed: (){

                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16)
                                      )
                                  ),
                                  child: Text(
                                    eachProfileInfo.ethnicity.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Fav btn
                          GestureDetector(
                            onTap: (){
                              profileController.favoriteSendAndFavoriteReceived(eachProfileInfo.uid.toString(), senderName);
                            },
                            child: Image.asset("images/favorite.png", width: 60),
                          ),

                          //Chat
                          GestureDetector(
                            onTap: (){

                            },
                            child: Image.asset("images/chat.png", width: 70),
                          ),
                          //Like
                          GestureDetector(
                            onTap: (){
                              profileController.likeSendAndLikeReceived(eachProfileInfo.uid.toString(), senderName);
                            },
                            child: Image.asset("images/like.png", width: 60),
                          )
                        ],
                      )
                    ],
                  )
                ),);
          },
        );
      })
    );
  }
}
