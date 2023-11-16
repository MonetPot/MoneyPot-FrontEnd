import 'package:flutter/material.dart';
import 'color_const.dart';

const LinearGradient SIGNUP_BACKGROUND = LinearGradient(
  begin: FractionalOffset(0.0, 0.5), end: FractionalOffset(0.9, 0.7),
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.5], colors: [GREEN, BLUE],
);



const LinearGradient GROUP_SCREEN = LinearGradient(
  begin: FractionalOffset(0.0, 0.5), end: FractionalOffset(0.9, 0.7),
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.5], colors: [GREEN, BLUE_DEEP],
);

const LinearGradient GROUP_SCREEN_APPBAR = LinearGradient(
  begin: FractionalOffset(0.0, 0.5), end: FractionalOffset(0.9, 0.7),
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.5], colors: [GREEN, GREEN],
);

final BoxDecoration groupScreenDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: FractionalOffset(0.0, 0.5), end: FractionalOffset(0.9, 0.7),
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: [0.1, 0.5], colors: [GREEN, BLUE_DEEP],
    // begin: Alignment.topLeft,
    // end: Alignment.bottomRight,
    // colors: [Colors.blue, Colors.purple], // Replace with your gradient colors
  ),
);


const LinearGradient SIGNUP_CARD_BACKGROUND = LinearGradient(
  tileMode: TileMode.clamp,
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  stops: [0.1, 1.0],
  colors: [SIGNUP_LIGHT_RED, SIGNUP_RED],
);

const LinearGradient SIGNUP_CIRCLE_BUTTON_BACKGROUND = LinearGradient(
  tileMode: TileMode.clamp,
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.4, 1],
  colors: [Colors.black, Colors.black54],
);


// Group Screen Gradient: Light to Dark Blue
const LinearGradient groupScreenGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [BLUE_LIGHT, BLUE_DEEP],
);

// Group Details Screen Gradient: Purple to Dark Blue
const LinearGradient groupDetailsGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [PURPLE, BLUE_DEEP],
);

// User Screen Gradient: Warm Red to Light Red
const LinearGradient userScreenGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [SIGNUP_RED, RED_LIGHT],
);

// Settings Page Gradient: Neutral Dark to Main Color
const LinearGradient settingsPageGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [DARK_COLOR, MAIN_COLOR],
);

// Search Screen Gradient: Light Blue to Green
const LinearGradient searchScreenGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [BLUE_LIGHT, GREEN],
);