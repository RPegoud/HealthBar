import 'package:flutter/material.dart';

const lightBlue = Color(0xff01C3FF);
const middleBlue = Color(0xff0086FF);
const darkBlue = Color(0xff1279D4);

const lightOrange = Color(0xffFAC32B);
const middleOrange = Color(0xffFC9A38);
const darkOrange = Color(0xffFE6D46);

const lightRed = Color(0xffE93B4C);
const middleRed = Color(0xffAC3B67);
const darkRed = Color(0xff4F3B90);

const lightPurple = Color(0xffE93B4C);
const middlePurple = Color(0xffAC3B67);
const darkPurple = Color(0xff4F3B90);

const lightBeige = Color(0xffFAB374);
const middleBeige = Color(0xffE87242);
const darkBeige = Color(0xffDA3F19);
const List<List<Color>> colorList = [
  [
    Color(0xffFAC32B),
    Color(0xffFC9A38),
    Color(0xffFE6D46),
  ],
  [
    Color(0xffFAB374),
    Color(0xffE87242),
    Color(0xffDA3F19),
  ],
  [
    Color(0xffE93B4C),
    Color(0xffAC3B67),
    Color(0xff4F3B90),
  ]
];

const lightGreen = Color(0xff45DA9E);
const neumorphicBlue =  Color.fromRGBO(193, 214, 233, 1);


  final List radioTitles = [
    'Sedentary (limited exercice)',
    'Lightly active (light exercise less than 3 times a week)',
    'Moderately active (moderate exercise most days of the week)',
    'Very active (hard exercise every day)',
    'Extra active (strenuous exercise two or more times per day)'
  ];
  final List activityFactors = [1.2, 1.375, 1.55, 1.725, 1.9];