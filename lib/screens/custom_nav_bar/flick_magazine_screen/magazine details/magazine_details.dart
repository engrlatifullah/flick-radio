import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class MagazineDetailsPage extends StatelessWidget {
  final  dynamic data;
  const MagazineDetailsPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.grey,
        title: const Text('Magazine Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(data['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              data['title'],
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 10,),
            Text(
              data['description'],
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
