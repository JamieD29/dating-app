import 'package:dating_app/tabScreens/favSentFavReceivedScreen.dart';
import 'package:dating_app/tabScreens/likeSentLikeReceivedScreen.dart';
import 'package:dating_app/tabScreens/swippingScreen.dart';
import 'package:dating_app/tabScreens/userDetailsScreen.dart';
import 'package:dating_app/tabScreens/viewSentViewReceivedScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  // String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
  List tabScreenList = [
    const SwippingScreen(),
    const ViewSentViewReceivedScreen(),
    const FavSentFavReceivedScreen(),
    const LikeSentLikeReceivedScreen(),
    UserDetailsScreen(userID: FirebaseAuth.instance.currentUser!.uid,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber){
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        items: const[
          //Swipping Screen
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: ""
          ),
          //View
          BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
                size: 30,
              ),
              label: ""
          ),
          //Favorite
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: ""
          ),
          //Like
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: ""
          ),
          //User Details
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: ""
          )
        ],
      ),
      body: tabScreenList[screenIndex],
    );
  }
}
