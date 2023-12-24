import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_radio/screens/custom_nav_bar/home_screen/search_screen.dart';
import 'package:flick_radio/screens/custom_nav_bar/home_screen/widgets/custom_forward_and_backward_button.dart';
import 'package:flick_radio/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../utils/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _count = 0;
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  playAudio(String url) async {
    if (isPlaying) {
      await player.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await player.play(UrlSource(url));
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryBlack,
          elevation: 0,
          title: SizedBox(
            height: 100,
            width: 90,
            child: Image.asset('images/logo.png'),
          ),
          actions: [
            InkWell(
              onTap: () {
                navigateToPage(context, const SearchScreen());
              },
              child: Icon(
                Icons.search,
                color: AppColors.primaryWhite.withOpacity(0.6),
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('homeScreen')
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  var imageLists = snapshot.data!.docs
                      .map((doc) => doc['images'] as List<dynamic>)
                      .toList();
                  var images = imageLists
                      .expand((imageList) => imageList)
                      .toList()
                      .cast<String>();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(08),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(images[_count]),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomForwardAndBackButton(
                                icon: Icons.keyboard_arrow_left,
                                onPressed: () {
                                  if (_count > 0) {
                                    setState(() {
                                      _count--;
                                    });
                                  }
                                },
                              ),
                              CustomForwardAndBackButton(
                                icon: Icons.keyboard_arrow_right,
                                onPressed: () {
                                  setState(() {
                                    if (_count < images.length - 1) {
                                      setState(() {
                                        _count++;
                                      });
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('mp3')
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  final data = snapshot.data!.docs;
                  return Row(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 120,
                        child: Image.asset('images/logo.png'),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: InkWell(
                            onTap: () async {
                              await playAudio(data[0]["link"] as String);
                            },
                            child: Icon(
                              isPlaying ? Icons.pause_circle : Icons.play_circle,
                              size: 40,
                              color: AppColors.primaryLightYellow,
                            ),
                          ),
                          title: Text(
                            data[0]["musicianName"] as String,
                            style: AppTextStyles.heading2.copyWith(
                                color: AppColors.primaryLightYellow,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            data[0]["musicName"] as String,
                            style: AppTextStyles.heading2.copyWith(
                                color: AppColors.primaryLightYellow,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
