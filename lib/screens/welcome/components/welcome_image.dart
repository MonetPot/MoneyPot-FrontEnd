import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "MoneyPot",
          style: TextStyle(
              fontSize: 60,
              color: Colors.blue[900],
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            SizedBox(
              height: 200,
              width: 200,
              child: SvgPicture.asset("assets/icons/pool.svg"),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}