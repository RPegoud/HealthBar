import 'package:auth/constants.dart';
import 'package:auth/ui_components/dashboard/splitForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pie_chart.dart';
import '../ui_components.dart';

FutureBuilder<DocumentSnapshot<Map<String, dynamic>>> macroRow() {
  return FutureBuilder(
    future: FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get(),
    builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
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
              style: GoogleFonts.oswald(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              'Daily Proteins :\n${data['DailyCal'] * 0.27 ~/ 4} g', // 27% of calories as proteins
              style: GoogleFonts.oswald(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              'Daily Carbs:\n${data['DailyCal'] * 0.47 ~/ 4} g', // 47% of calories as carbs
              style: GoogleFonts.oswald(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        );
      }
    },
  );
}

class PieChartView extends StatefulWidget {
  const PieChartView({Key? key}) : super(key: key);

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(193, 214, 233, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 17,
                  offset: Offset(-5, -5),
                  color: Colors.white),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1),
              ),
            ],
          ),
          child: Stack(
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Center(
                      child: SizedBox(
                        width: constraints.maxWidth * 0.6,
                        child: CustomPaint(
                          child: Center(),
                          foregroundPainter: PieChart(
                            width: constraints.maxWidth * 0.5,
                            categories: [
                              Category(
                                '$data[Protein split]',
                                amount: data['Protein split'],
                              ),
                              Category(
                                'Carbs',
                                amount: data['Carbs split'],
                              ),
                              Category(
                                'Fats',
                                amount: data['Fats split'],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              Center(
                child: Container(
                  height: constraints.maxWidth * 0.4,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(193, 214, 233, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      const BoxShadow(
                          blurRadius: 1,
                          offset: Offset(-1, -1),
                          color: Colors.white),
                      BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: const Offset(5, 5),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Center(
                          child: Text(
                            '${data['DailyCal']} cal',
                            style: GoogleFonts.oswald(
                                color: Colors.black, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SplitLegend extends StatelessWidget {
  const SplitLegend({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);

  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kColors.elementAt(index % kColors.length),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          name,
          style: GoogleFonts.oswald(color: Colors.grey.shade800, fontSize: 16),
        ),
      ],
    );
  }
}

class CategoryRow extends StatefulWidget {
  const CategoryRow({Key? key}) : super(key: key);

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

double proteinController = 0;
double carbsController = 0;
double fatsController = 0;

class _CategoryRowState extends State<CategoryRow> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              key: UniqueKey(),
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SplitLegend(
                    name: '${data['Protein split'].round()} % Protein',
                    index: 0),
                SplitLegend(
                    name: '${data['Carbs split'].round()} % Carbs', index: 1),
                SplitLegend(
                    name: '${data['Fats split'].round()} % Fats', index: 2),
                insertSpace(50),
                ElevatedButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      transitionBuilder: (context, a1, a2, widget) {
                        final curvedValue =
                            Curves.easeInOutBack.transform(a1.value) - 1.0;
                        return Transform(
                          transform: Matrix4.translationValues(
                              0.0, curvedValue * 200, 0.0),
                          child: Opacity(
                            opacity: a1.value,
                            child: AlertDialog(
                              scrollable: true,
                              title: const Text("Update your informations"),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return splitForm(setState, context);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                      barrierDismissible: true,
                      barrierLabel: '',
                      pageBuilder: (context, animation1, animation2) {
                        return const Text('');
                      },
                    );
                    // TODO : add form with controllers for the split
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: neumorphicBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 126,
                      height: 36,
                      alignment: Alignment.center,
                      child: Text(
                        'Change split',
                        style: GoogleFonts.oswald(
                            color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Container buildContainer(height, childList) {
  return Container(
    height: height,
    width: double.maxFinite,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(20),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(41.0),
      boxShadow: [
        const BoxShadow(
            blurRadius: 0.5, offset: Offset(-1, -1), color: Colors.white),
        BoxShadow(
          spreadRadius: -2,
          blurRadius: 10,
          offset: const Offset(5, 5),
          color: Colors.black.withOpacity(0.5),
        )
      ],
      color: const Color.fromARGB(255, 186, 208, 228),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: childList,
      ),
    ),
  );
}
