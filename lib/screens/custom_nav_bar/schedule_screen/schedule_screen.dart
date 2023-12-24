import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../widgets/our_show_widget.dart';
import '../widgets/program_schedule_listtile.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Programme Schedule",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.mainColor.withOpacity(0.9),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor.withOpacity(0.9)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("programSchedule").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No Program is Schedule Yet!",
                            style: TextStyle(
                              color: AppColors.mainColor,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: ProgrammeScheduleListTile(data: snapshot.data!.docs[index]),
                          );
                        },
                      );
                    },
                  )),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Our Shows",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.mainColor.withOpacity(0.9),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor.withOpacity(0.9)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("ourShow").snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No Shows Yet!",
                            style: TextStyle(
                              color: AppColors.mainColor,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: OurShowWidget(data: snapshot.data!.docs[index]),
                          );
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
