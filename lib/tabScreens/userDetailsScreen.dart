import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/accountSettingScreen/accountSettingsSccreen.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatefulWidget {
  String? userID;

  UserDetailsScreen({
    super.key,
    this.userID,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreen();
}

class _UserDetailsScreen extends State<UserDetailsScreen> {
  //personal info
  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String country = '';
  String profileHeadings = '';
  String lookingForInaPartner = '';
  //Appearance
  String height = '';
  String weight = '';
  String bodyType = '';
//Life style
  String drink = '';
  String smoke = '';
  String martialStatus = '';
  String haveChildren = '';
  String noOfChildren = '';
  String profession = '';
  String employmentStatus = '';
  String income = '';
  String livingSituation = '';
  String willingToRelocate = '';
  String relationshipType = '';

  //Background and Cultural Values
  String nationality = '';
  String education = '';
  String languageSpoken = '';
  String religion = '';
  String ethnicity = '';

  // Slider Images
  String urlImage1 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-44e1f.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=50521e3e-e58a-425e-a066-8a17a8d82126";
  String urlImage2 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-44e1f.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=50521e3e-e58a-425e-a066-8a17a8d82126";
  String urlImage3 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-44e1f.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=50521e3e-e58a-425e-a066-8a17a8d82126";
  String urlImage4 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-44e1f.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=50521e3e-e58a-425e-a066-8a17a8d82126";
  String urlImage5 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-44e1f.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=50521e3e-e58a-425e-a066-8a17a8d82126";

  retrieveUserInfo() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!["urlImage1"] != null) {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
        }
        setState(() {
          name = snapshot.data()!["name"];
          age = snapshot.data()!["age"].toString();
          phoneNo = snapshot.data()!["phoneNo"];
          city = snapshot.data()!["city"];
          country = snapshot.data()!["country"];
          profileHeadings = snapshot.data()!["profileHeadings"];
          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];
          //Appearance
          height = snapshot.data()!["height"];
          weight = snapshot.data()!["weight"];
          bodyType = snapshot.data()!["bodyType"];
          //Lifestyle
          drink = snapshot.data()!["drink"];
          smoke = snapshot.data()!["smoke"];
          martialStatus = snapshot.data()!["martialStatus"];
          haveChildren = snapshot.data()!["haveChildren"];
          noOfChildren = snapshot.data()!["noOfChildren"];
          profession = snapshot.data()!["profession"];
          employmentStatus = snapshot.data()!["employmentStatus"];
          income = snapshot.data()!["income"];
          livingSituation = snapshot.data()!["livingSituation"];
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          relationshipType = snapshot.data()!["relationshipType"];
          //Background - Cultural values
          nationality = snapshot.data()!["nationality"];
          education = snapshot.data()!["education"];
          languageSpoken = snapshot.data()!["languageSpoken"];
          religion = snapshot.data()!["religion"];
          ethnicity = snapshot.data()!["ethnicity"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          // automaticallyImplyLeading: widget.userID == currentUserID  ? false : true,
          leading: widget.userID != currentUserID
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    size: 30,
                  ),
                )
              : Container(),
          actions: [
            widget.userID == currentUserID
                ? Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(const AccountSettingsScreen());
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 30,
                        ),
                    ),
                  ],
                )
                : Container(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                //Image Slider
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Carousel(
                      indicatorBarColor: Colors.black.withOpacity(0.3),
                      autoScrollDuration: const Duration(seconds: 2),
                      animationPageDuration: const Duration(milliseconds: 500),
                      activateIndicatorColor: Colors.black,
                      animationPageCurve: Curves.easeIn,
                      indicatorBarHeight: 30,
                      indicatorHeight: 10,
                      indicatorWidth: 10,
                      unActivatedIndicatorColor: Colors.grey,
                      stopAtEnd: false,
                      autoScroll: true,
                      items: [
                        Image.network(
                          urlImage1,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage2,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage3,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage4,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage5,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Personal Info Title
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Personal Info:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                //Personal Info Table Data
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(20),
                    child: Table(
                      children: [
                        //Name
                        TableRow(children: [
                          const Text(
                            "Name: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Age
                        TableRow(children: [
                          const Text(
                            "Age: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            age,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Phone number
                        TableRow(children: [
                          const Text(
                            "Phone Number: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            phoneNo,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //City
                        TableRow(children: [
                          const Text(
                            "City: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            city,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Country
                        TableRow(children: [
                          const Text(
                            "Country: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            country,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Seeking
                        TableRow(children: [
                          const Text(
                            "Seeking: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            lookingForInaPartner,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                      ],
                    )),
                //Appearance
                //Appearance Title
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Appearance:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                //Appearance Info Table Data
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(20),
                    child: Table(
                      children: [
                        //Height
                        TableRow(children: [
                          const Text(
                            "Height: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            height,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Weight
                        TableRow(children: [
                          const Text(
                            "Weight: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            weight,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Body Type
                        TableRow(children: [
                          const Text(
                            "Body Type: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            bodyType,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                      ],
                    )),
                //Life Style
                //Life style Title
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Life Style:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                //LF Info Table Data
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(20),
                    child: Table(
                      children: [
                        //Drink
                        TableRow(children: [
                          const Text(
                            "Drinking: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            drink,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Smoke
                        TableRow(children: [
                          const Text(
                            "Smoking: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            smoke,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //Martial Status
                        TableRow(children: [
                          const Text(
                            "Martial Status: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            martialStatus,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //haveChildren
                        TableRow(children: [
                          const Text(
                            "Having children: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            haveChildren,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //noOfChildren
                        TableRow(children: [
                          const Text(
                            "Number of children: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            noOfChildren,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //profession
                        TableRow(children: [
                          const Text(
                            "Profession: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            profession,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //employmentStatus
                        TableRow(children: [
                          const Text(
                            "Employment Status: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            employmentStatus,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //income
                        TableRow(children: [
                          const Text(
                            "Income: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            income,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //livingSituation
                        TableRow(children: [
                          const Text(
                            "Living Situation: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            livingSituation,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //willingToRelocate
                        TableRow(children: [
                          const Text(
                            "Willing To Relocate: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            willingToRelocate,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //relationshipType
                        TableRow(children: [
                          const Text(
                            "Looking for relationship: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            relationshipType,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                      ],
                    )),
                //Background and Cultural values
                //BGnC Title
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Background - Cultural Values:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                //BGnC Info Table Data
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(20),
                    child: Table(
                      children: [
                        //nationality
                        TableRow(children: [
                          const Text(
                            "Nationality: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            nationality,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //education
                        TableRow(children: [
                          const Text(
                            "Education: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            education,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        //Extra row
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //language
                        TableRow(children: [
                          const Text(
                            "Language: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            languageSpoken,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //religion
                        TableRow(children: [
                          const Text(
                            "Religion: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            religion,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                        const TableRow(children: [
                          Text(""),
                          Text(""),
                        ]),
                        //ethnicity
                        TableRow(children: [
                          const Text(
                            "Ethnicity: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            ethnicity,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ]),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
