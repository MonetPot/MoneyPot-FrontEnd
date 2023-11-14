// import 'package:flutter/material.dart';
//
// import '../../components/background.dart';
// import '../../responsive.dart';
// import 'components/login_signup_btn.dart';
// import 'components/welcome_image.dart';
//
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: SingleChildScrollView(
//         child: SafeArea(
//           child: Responsive(
//             desktop: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const Expanded(
//                   child: WelcomeImage(),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       SizedBox(
//                         width: 450,
//                         child: LoginAndSignupBtn(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             mobile: const MobileWelcomeScreen(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MobileWelcomeScreen extends StatelessWidget {
//   const MobileWelcomeScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const WelcomeImage(),
//         Row(
//           children: const [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: LoginAndSignupBtn(),
//             ),
//             Spacer(),
//           ],
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/login_signup_button.dart';
import 'components/welcome_image.dart';

import 'components/reset_password.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  // Navigation function
  void _navigateToResetPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPassword(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: WelcomeImage(),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 450,
                            child: LoginAndSignupBtn(),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => _navigateToResetPassword(context),
                        child: Text("Reset Password"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: const MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  void _navigateToResetPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPassword(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       padding: EdgeInsets.only(top: 64.0),
  //       decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
  //       child: ListView(
  //         physics: BouncingScrollPhysics(),
  //         children: <Widget>[
  //           // Center(
  //           //   child: Image.asset(
  //           //     'assets/icons/login.svg',
  //           //     width: 100.0,
  //           //     height: 100.0,
  //           //     fit: BoxFit.cover,
  //           //   ),
  //           // ),
  //           Center(
  //             child: SvgPicture.asset(
  //               'assets/icons/login.svg',
  //               width: 100.0,
  //               height: 100.0,
  //             ),
  //           ),
  //           // headlinesWidget(),
  //           // emailTextFieldWidget(),
  //           // passwordTextFieldWidget(),
  //           // loginButtonWidget(),
  //           // signupWidget(context)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const WelcomeImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ResetPassword();
                },
              ),
            );
          },
          child: Text("Reset Password"),
        ),
      ],
    );
  }
}