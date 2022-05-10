import 'package:flutter/material.dart';
import 'package:auth/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui_components/meals/meals_components.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neumorphicBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 4, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meals',
                  style: GoogleFonts.pacifico(
                    color: Colors.black,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
                alimentTile(
                  aliment: Aliment(
                      name: 'Banana',
                      type: 'Vegetable',
                      unit: true,
                      proteins: 40,
                      carbs: 20,
                      fats: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// body: Stack(
//   children: <Widget>[
//     buildTopEllipse('assets/images/Berries.png'),
//     SizedBox(
//       height: double.infinity,
//       width: double.infinity,
//       child: SingleChildScrollView(
//         physics: const PageScrollPhysics(),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 15,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             buildTitle('My\nMeals', TextAlign.center),
//             insertSpace(85),
//             Stack(
//               children: <Widget>[
//                 Container(
//                   margin: const EdgeInsets.fromLTRB(0, 7, 7, 0),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30.0),
//                     border: Border.all(color: Colors.black, width: 1),
//                     gradient: const LinearGradient(
//                         colors: [lightPurple, darkPurple]),
//                   ),
//                   height: 220,
//                   width: double.maxFinite,
//                 ),
//                 Container(
//                   margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30.0),
//                     border: Border.all(color: Colors.black, width: 1),
//                     color: Colors.white,
//                   ),
//                   height: 220,
//                   width: double.maxFinite - 10,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Saved meals :',
//                             style: GoogleFonts.oswald(
//                                 color: Colors.black, fontSize: 18),
//                             textAlign: TextAlign.center,
//                           ),
//                           const Spacer(),
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.add_circle,
//                               color: lightPurple,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   ],
// ),
