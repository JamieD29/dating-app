import 'package:cloud_firestore/cloud_firestore.dart';

class Person{
  //Personal Info
  String? uid;
  String? imageProfile;
  String? email;
  String? password;
  String? name;
  int? age;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeadings;
  String? lookingForInaPartner;
  int? publishedDateTime;
  //Appearance
  String? height;
  String? weight;
  String? bodyType;
  //Lifestyle
  String? drink;
  String? smoke;
  String? martialStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipType;
  //Background - Cultural values
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;
  String? ethnicity;

  Person({
    this.uid,
    this.imageProfile,
    this.email,
    this.password,
    this.name,
    this.age,
    this.phoneNo,
    this.city,
    this.country,
    this.profileHeadings,
    this.lookingForInaPartner,
    this.publishedDateTime,
    //Appearance
    this.height,
    this.weight,
    this.bodyType,
    //Lifestyle
    this.drink,
    this.smoke,
    this.martialStatus,
    this.haveChildren,
    this.noOfChildren,
    this.profession,
    this.employmentStatus,
    this.income,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipType,
    //Background - Cultural values
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
    this.ethnicity,
  });

  static Person fromDataSnapshot(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return Person(
      uid: dataSnapshot["uid"],
      name: dataSnapshot["name"],
      imageProfile: dataSnapshot["imageProfile"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      age: dataSnapshot["age"],
      phoneNo: dataSnapshot["phoneNo"],
      city: dataSnapshot["city"],
      country: dataSnapshot["country"],
      profileHeadings: dataSnapshot["profileHeadings"],
      lookingForInaPartner: dataSnapshot["lookingForInaPartner"],
      publishedDateTime: dataSnapshot["publishedDateTime"],
      //Appearance
      height: dataSnapshot["height"],
      weight: dataSnapshot["weight"],
      bodyType: dataSnapshot["bodyType"],
      //Lifestyle
      drink: dataSnapshot["drink"],
      smoke: dataSnapshot["smoke"],
      martialStatus: dataSnapshot["martialStatus"],
      haveChildren: dataSnapshot["haveChildren"],
      noOfChildren: dataSnapshot["noOfChildren"],
      profession: dataSnapshot["profession"],
      employmentStatus: dataSnapshot["employmentStatus"],
      income: dataSnapshot["income"],
      livingSituation: dataSnapshot["livingSituation"],
      willingToRelocate: dataSnapshot["willingToRelocate"],
      relationshipType: dataSnapshot["relationshipType"],
      //Background - Cultural values
      nationality: dataSnapshot["nationality"],
      education: dataSnapshot["education"],
      languageSpoken: dataSnapshot["languageSpoken"],
      religion: dataSnapshot["religion"],
      ethnicity: dataSnapshot["ethnicity"],
    );
  }

  Map<String, dynamic> toJson()=>{
    "uid": uid,
    "imageProfile": imageProfile,
    "email": email,
    "password": password,
    "name": name,
    "age": age,
    "phoneNo": phoneNo,
    "city": city,
    "country": country,
    "profileHeadings": profileHeadings,
    "lookingForInaPartner": lookingForInaPartner,
    "publishedDateTime": publishedDateTime,
    "height": height,
    "weight": weight,
    "bodyType": bodyType,
    "drink": drink,
    "smoke": smoke,
    "martialStatus": martialStatus,
    "haveChildren": haveChildren,
    "noOfChildren": noOfChildren,
    "profession": profession,
    "employmentStatus": employmentStatus,
    "income": income,
    "livingSituation": livingSituation,
    "willingToRelocate": willingToRelocate,
    "relationshipType": relationshipType,
    "nationality": nationality,
    "education": education,
    "languageSpoken": languageSpoken,
    "religion": religion,
    "ethnicity": ethnicity,
  };
}