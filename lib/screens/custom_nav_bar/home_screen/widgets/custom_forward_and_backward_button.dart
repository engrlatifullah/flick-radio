import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class CustomForwardAndBackButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  const CustomForwardAndBackButton({Key? key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightBlackColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 25,
          color: AppColors.primaryWhite,
        ),
      ),
    );
  }
}
