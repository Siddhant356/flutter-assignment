import 'package:flutter/material.dart';

const Widget horizontal4px = SizedBox(width: 4.0);
const Widget vertical4px = SizedBox(height: 4.0);

const Widget horizontal6px = SizedBox(width: 6.0);
const Widget vertical6px = SizedBox(height: 6.0);

const Widget horizontal8px = SizedBox(width: 8.0);
const Widget vertical8px = SizedBox(height: 8.0);

const Widget horizontal12px = SizedBox(width: 12.0);
const Widget vertical12px = SizedBox(height: 12.0);

const Widget horizontal16px = SizedBox(width: 16.0);
const Widget vertical16px = SizedBox(height: 16.0);

const Widget horizontal24px = SizedBox(width: 24.0);
const Widget vertical24px = SizedBox(height: 24.0);

const Widget horizontal32px = SizedBox(width: 32.0);
const Widget vertical32px = SizedBox(height: 32.0);

const Widget horizontal40px = SizedBox(width: 40.0);
const Widget vertical40px = SizedBox(height: 40.0);

const Widget horizontal48px = SizedBox(width: 48.0);
const Widget vertical48px = SizedBox(height: 48.0);

const Widget horizontal56px = SizedBox(width: 56.0);
const Widget vertical56px = SizedBox(height: 56.0);

const Widget horizontal72px = SizedBox(width: 72.0);
const Widget vertical72px = SizedBox(height: 72.0);

const Widget horizontal80px = SizedBox(width: 80.0);
const Widget vertical80px = SizedBox(height: 80.0);

// Screen Size helpers

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) => screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) => screenWidth(context) * percentage;
