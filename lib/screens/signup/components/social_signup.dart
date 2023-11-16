import 'package:flutter/material.dart';
import 'package:money_pot/screens/signup/services/auth_service.dart';

import '../../../screens/signup/components/divider.dart';
import '../../../screens/signup/components/social_icon.dart';
import '../phone/phone.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialIcon(
              iconSrc: "assets/icons/phone.svg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Phone();
                    },
                  ),
                );
              },
            ),
            // SocialIcon(
            //   iconSrc: "assets/icons/apple.svg",
            //   onTap: () => AuthService().signInWithApple(context),
            // ),
            // SocialIcon(
            //   iconSrc: "assets/icons/google.svg",
            //   onTap: () => AuthService().signInWithGoogle(context),
            // ),
            // SocialIcon(
            //   iconSrc: "assets/icons/facebook.svg",
            //   onTap: () {},
            // ),
          ],
        ),
      ],
    );
  }
}