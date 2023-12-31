import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_radio/screens/auth/login_screen.dart';
import 'package:flick_radio/screens/custom_nav_bar/home_screen/search_screen.dart';
import 'package:flick_radio/theme/colors.dart';
import 'package:flick_radio/utils/navigation.dart';
import 'package:flick_radio/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_magazine_card.dart';
import 'magazine details/magazine_details.dart';

class FlickMagazineScreen extends StatelessWidget {
  const FlickMagazineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          actions: [
            const Icon(Icons.notification_important),
            const SizedBox(width: 10),
            InkWell(
                onTap: () {
                  navigateToPage(context, const SearchScreen());
                },
                child: const Icon(Icons.search)),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("flickMag").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(color: AppColors.mainColor),
                    ),
                  );
                }
                return FirebaseAuth.instance.currentUser!.isAnonymous
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length > 2 ? 2 :snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      navigateToPage(context,  MagazineDetailsPage(
                                          data: snapshot.data!.docs[index]
                                      ));
                                    },
                                    child: CustomMagazineCard(
                                        data: snapshot.data!.docs[index]),
                                  );
                                }),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              title: "Log In",
                              color: AppColors.mainColor.withOpacity(0.95),
                              onPressed: () {
                                navigateToPage(context, const LoginScreen());
                              },
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              navigateToPage(context,  MagazineDetailsPage(
                                  data: snapshot.data!.docs[index]
                              ));
                            },
                            child: CustomMagazineCard(
                                data: snapshot.data!.docs[index]),
                          );
                        });
              }),
        ),
      ),
    );
  }
}
