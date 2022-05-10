import 'package:auth/ui_components/meals/barChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aliment {
  String name;
  String type; // meat, fruit, veggie
  bool unit;
  double proteins;
  double carbs;
  double fats;

  Aliment({
    required this.name,
    required this.type,
    required this.unit,
    required this.proteins,
    required this.carbs,
    required this.fats,
  });
}

// ignore: camel_case_types
class alimentTile extends StatelessWidget {
  final Aliment aliment;

  const alimentTile({Key? key, required this.aliment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ExpansionTile(
          title: Text(
            aliment.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.pacifico(color: Colors.black, fontSize: 20),
          ),
          children: <Widget>[
            Column(
              children: [
                ListTile(
                  title: aliment.unit == true
                      ? Text(
                          'Details for one unit:',
                          style: GoogleFonts.pacifico(
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Details for 100g:',
                          style: GoogleFonts.pacifico(
                            color: Colors.black,
                          ),
                        ),
                  subtitle: Text(
                    'Protein : ${aliment.proteins}g\nCarbs : ${aliment.carbs}g\nFat : ${aliment.fats}g',
                    style: GoogleFonts.pacifico(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 200,
              width: 200,
              child: buildBarChart(),
            )
          ],
        ),
      ),
    );
  }
}
