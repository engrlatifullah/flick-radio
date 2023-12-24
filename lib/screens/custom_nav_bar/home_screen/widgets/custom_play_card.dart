import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_styles.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomPlayCard extends StatefulWidget {
  const CustomPlayCard({Key? key}) : super(key: key);

  @override
  State<CustomPlayCard> createState() => _CustomPlayCardState();
}

class _CustomPlayCardState extends State<CustomPlayCard> {

  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.lightBlackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Artist",
                style: AppTextStyles.heading2
                    .copyWith(fontWeight: FontWeight.w300),
              ),
              const SizedBox(),
              Text(
                "Artist",
                style: AppTextStyles.heading2
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.favorite_border,
                color: AppColors.primaryWhite,
              ),
              Row(
                children: [
                  Icon(
                    Icons.skip_previous,
                    color: AppColors.primaryWhite,
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () async  {
                      if(isPlaying){
                        await player.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      }
                      else {
                        await player.play(UrlSource("https://www.radioking.com/play/flick"));
                       
                        setState(() {
                          isPlaying = true;
                        });
                      }
                      },
                    child: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      size: 40,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.skip_next,
                    color: AppColors.primaryWhite,
                  ),
                ],
              ),
              Icon(
                Icons.add_circle_outline,
                color: AppColors.primaryWhite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
