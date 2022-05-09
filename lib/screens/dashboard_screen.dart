import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth/constants.dart';
import 'package:auth/ui_components/ui_components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../ui_components/dashboard/Macro/dashboard_components.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({Key? key}) : super(key: key);

  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  int selectedRadio = -1;
  int _radioValue = 0;
  int dailyCal = 0;
  String dropDownValue = 'Man';
  int genderConstant = 0;

  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _trySubmitCal(int cal) {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // close the keyboard on submit
    if (_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Daily calories intake updated !',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
      _formKey.currentState
          ?.save(); // goes to all formfields and triggers onSaved
      setState(
        () {
          if (dropDownValue == 'Man') {
            genderConstant = 5;
          } else {
            genderConstant = -165;
          }
          dailyCal =
              ((cal + genderConstant) * activityFactors[_radioValue]).round();
        },
      );
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'DailyCal': dailyCal});
    }
  }

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
                  'Dashboard',
                  style: GoogleFonts.pacifico(
                    color: Colors.black,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
                infoContainer(),
                macroContainer(context),
                calendarContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------

  Container infoContainer() {
    return buildContainer(
      300.0,
      [
        Row(
          children: [
            Text(
              'My infos',
              style: GoogleFonts.oswald(
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
                  color: neumorphicBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 126,
                  height: 36,
                  alignment: Alignment.center,
                  child: Text(
                    'Update',
                    style:
                        GoogleFonts.oswald(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container calendarContainer() {
    return buildContainer(
      400.0,
      [
        Row(
          children: [
            Text(
              'Calendar',
              style: GoogleFonts.oswald(
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
                  color: neumorphicBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 126,
                  height: 36,
                  alignment: Alignment.center,
                  child: Text(
                    'Add event',
                    style:
                        GoogleFonts.oswald(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
        SfCalendar(
          view: CalendarView.week,
        )
      ],
    );
  }

  Container macroContainer(BuildContext context) {
    return Container(
      height: 370,
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Text(
                  'Macros',
                  style: GoogleFonts.oswald(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    macroCalculatorForm(context);
                  },
                  style: ElevatedButton.styleFrom(
                      // elevation: 4,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
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
                        'Update',
                        style: GoogleFonts.oswald(
                            color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          macroRow(),
          insertSpace(10),
          Expanded(
            child: Row(
              children: const [
                CategoryRow(),
                PieChartView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------ Macro Popping Menu ------------------

  Future<Void?> macroCalculatorForm(BuildContext context) {
    return showGeneralDialog<Void>(
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        int selectedRadio = _radioValue;
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              scrollable: true,
              title: const Text("Update your informations"),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: dropDownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: neumorphicBlue,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                        items: <String>['Man', 'Woman']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      buildMacroForm(
                          _formKey,
                          _heightController,
                          _weightController,
                          _ageController,
                          'Heigth (cm)',
                          'Weight (kg)',
                          'Age'),
                      insertSpace(20),
                      Column(
                        children: List<Widget>.generate(
                          5,
                          (int index) {
                            return ListTile(
                              title: Text(radioTitles[index]),
                              leading: Radio<int>(
                                activeColor: Colors.black,
                                value: index,
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  setState(() => selectedRadio = value as int);
                                  _radioValue = value!;
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      insertSpace(20),
                      buildUpdateButton(context, () {
                        Navigator.pop(context);
                        _trySubmitCal((10 * int.parse(_weightController.text) +
                                6.25 * int.parse(_heightController.text) -
                                5 * int.parse(_ageController.text))
                            .round());
                      }, 'Update', [neumorphicBlue, neumorphicBlue]),
                    ],
                  );
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
  }
}
