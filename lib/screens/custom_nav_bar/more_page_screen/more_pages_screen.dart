import 'package:flick_radio/screens/auth/login_screen.dart';
import 'package:flick_radio/screens/custom_nav_bar/more_page_screen/submit_music_screen/submit_music_screen.dart';
import 'package:flick_radio/screens/custom_nav_bar/widgets/custom_list_tile_for_more_screen.dart';
import 'package:flick_radio/services/auth_services.dart';
import 'package:flick_radio/theme/colors.dart';
import 'package:flick_radio/utils/lauchers.dart';
import 'package:flick_radio/utils/navigation.dart';
import 'package:flick_radio/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/social_accounts.dart';
import 'contact_us_screen/contact_us_screen.dart';

class MorePagesScreen extends StatelessWidget {
  const MorePagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: AppColors.primaryBlack,
          title: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('images/logo.png'),
          ),
        ),
        body: Column(
          children: [
            Main3DButton(
                widget: const CustomListTileForMoreScreen(
                    title: 'Contact Us', icon: Icons.contacts),
                onPressed: () {
                  navigateToPage(
                    context,
                    const ContactUsScreen(),
                  );
                }),
            Main3DButton(
                widget: const CustomListTileForMoreScreen(
                    title: 'Submit Music', icon: Icons.music_note),
                onPressed: () {
                  navigateToPage(
                    context,
                    const SubmitMusicScreen(),
                  );
                }),

            //todo fixing it

            FirebaseAuth.instance.currentUser!.email == null
                ? Main3DButton(
                    widget: const CustomListTileForMoreScreen(
                        title: 'Login', icon: Icons.login),
                    onPressed: () {
                      navigateToPage(context, const LoginScreen());
                    })
                : Main3DButton(
                    widget: const CustomListTileForMoreScreen(
                        title: 'LogOut', icon: Icons.logout),
                    onPressed: () {
                      AuthServices.signOut(context);
                    }),
            const SizedBox(height: 60),
            Text(
              'Get Social With Us',
              style: TextStyle(
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Main3DButton(
                    widget: const SocialAccounts(
                        socialIcon: FontAwesomeIcons.facebook),
                    onPressed: () {
                      AppLaunchers.launchFacebook();
                    }),
                Main3DButton(
                    widget: const SocialAccounts(
                        socialIcon: FontAwesomeIcons.twitter),
                    onPressed: () {}),
                Main3DButton(
                    widget: const SocialAccounts(
                        socialIcon: FontAwesomeIcons.instagram),
                    onPressed: () {
                      AppLaunchers.launchInstagram();
                    }),
                Main3DButton(
                    widget: const SocialAccounts(
                        socialIcon: FontAwesomeIcons.youtube),
                    onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
