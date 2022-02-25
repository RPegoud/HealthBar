import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth/constants.dart';
import 'package:auth/ui_components.dart';
import 'package:google_fonts/google_fonts.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(193, 214, 233, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 4, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dashboard',
                  style: GoogleFonts.pacifico(
                    color: Colors.black,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        'Macros',
                        style: GoogleFonts.pacifico(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            // elevation: 4,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Ink(
                          decoration: BoxDecoration(
                            // backgroundBlendMode: BlendMode.color,
                            color: const Color.fromRGBO(193, 214, 233, 1),
                            borderRadius: BorderRadius.circular(12),
                            // boxShadow: const [
                            //   BoxShadow(
                            //       spreadRadius: -5,
                            //       blurRadius: 4,
                            //       offset: Offset(7, 7),
                            //       color: Color.fromRGBO(0, 0, 0, 0.25)),
                            //   BoxShadow(
                            //       spreadRadius: -4,
                            //       blurRadius: 4,
                            //       offset: Offset(-5, -5),
                            //       color: Color.fromRGBO(204, 221, 237, 1)),
                            // ],
                          ),
                          child: Container(
                            width: 126,
                            height: 36,
                            alignment: Alignment.center,
                            child: Text(
                              'Update',
                              style: GoogleFonts.pacifico(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 350,
                  width: double.maxFinite,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(41.0),
                    // boxShadow: kElevationToShadow[4],
                    // color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Row(
                              children: [
                                Text(
                                  'Daily Calories:\n${data['DailyCal']} cal',
                                  style: GoogleFonts.pacifico(
                                      color: Colors.black, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Text(
                                  'Daily Proteins :\n${data['DailyCal'] * 0.27 ~/ 4} g', // 27% of calories as proteins
                                  style: GoogleFonts.pacifico(
                                      color: Colors.black, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Text(
                                  'Daily Carbs:\n${data['DailyCal'] * 0.47 ~/ 4} g', // 47% of calories as carbs
                                  style: GoogleFonts.pacifico(
                                      color: Colors.black, fontSize: 16),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          }
                        },
                      ),
                      insertSpace(10),
                      Expanded(
                        child: Row(
                          children: const [
                            CategoryRow(),
                            PieChartView(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





//  body: Stack(
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
      //                             style: GoogleFonts.pacifico(
      //                                 color: Colors.black, fontSize: 18),
      //                             textAlign: TextAlign.center,
      //                           ),
      //                           Spacer(),
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