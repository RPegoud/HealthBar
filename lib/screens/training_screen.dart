import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth/constants.dart';
import 'package:auth/ui_components/ui_components.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final _exerciceNameController = TextEditingController();
  final _trainingNameController = TextEditingController();
  double _repsController = 0;
  double _timeController = 0;
  final _formKey = GlobalKey<FormState>();

  void _addExercice(String newName, int newReps, int newRest) {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'New exercice added !',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  double windowHeight = 390;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildTopEllipse('assets/images/Training.png'),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const PageScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildTitle('Training\nPlan', TextAlign.center),
                  insertSpace(75),
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 7, 7, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.black, width: 1),
                          gradient: const LinearGradient(
                              colors: [lightBeige, darkBeige]),
                        ),
                        height: windowHeight,
                        width: double.maxFinite,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.black, width: 1),
                          color: Colors.white,
                        ),
                        height: windowHeight,
                        width: double.maxFinite - 10,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(9),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Trainings :',
                                      style: GoogleFonts.pacifico(
                                          color: Colors.black, fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        showGeneralDialog<Void>(
                                          context: context,
                                          transitionBuilder:
                                              (context, a1, a2, widget) {
                                            final curvedValue = Curves
                                                    .easeInOutBack
                                                    .transform(a1.value) -
                                                1.0;
                                            return Transform(
                                              transform:
                                                  Matrix4.translationValues(0.0,
                                                      curvedValue * 200, 0.0),
                                              child: Opacity(
                                                opacity: a1.value,
                                                child: AlertDialog(
                                                  scrollable: true,
                                                  title: const Text(
                                                      "Create a new Training session !"),
                                                  content: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelText:
                                                                        'Name',
                                                                  ),
                                                                  controller:
                                                                      _trainingNameController,
                                                                ),
                                                                insertSpace(20),
                                                              ],
                                                            ),
                                                          ),
                                                          buildUpdateButton(
                                                            context,
                                                            () {
                                                              Navigator.pop(
                                                                  context);
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .collection(
                                                                      'Trainings')
                                                                  .doc(
                                                                      _trainingNameController
                                                                          .text)
                                                                  .set({
                                                                'Name':
                                                                    _trainingNameController
                                                                        .text,
                                                              });
                                                            },
                                                            'Add Training',
                                                            [
                                                              lightBeige,
                                                              darkBeige
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                          barrierDismissible: true,
                                          barrierLabel: '',
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return const Text('');
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: lightBeige,
                                      ),
                                    )
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text(
                                    'Monday Training :',
                                    style: GoogleFonts.pacifico(
                                        color: Colors.black, fontSize: 17),
                                    textAlign: TextAlign.start,
                                  ),
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [lightBeige, darkBeige],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Container(
                                          width: 170,
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Start training',
                                            style: GoogleFonts.pacifico(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                    insertSpace(5),
                                    SingleChildScrollView(
                                      child: Expanded(
                                        child: SizedBox(
                                          height: 140,
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('Users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .collection('Exercices')
                                                .snapshots(),
                                            builder: (ctx,
                                                AsyncSnapshot
                                                    trainingSnapshots) {
                                              if (trainingSnapshots
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                final trainingDocs =
                                                    trainingSnapshots
                                                        .data!.docs;
                                                return GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio:
                                                          1.0 / .5,
                                                      crossAxisCount: 2,
                                                    ),
                                                    itemCount:
                                                        trainingDocs.length,
                                                    itemBuilder: (ctx, index) =>
                                                        // Text(trainingDocs[index]
                                                        //     ['Name']),
                                                        buildExerciceCard([
                                                          trainingDocs[index]
                                                              ['Name'],
                                                          trainingDocs[index]
                                                              ['Repetitions'],
                                                          trainingDocs[index]
                                                              ['Time']
                                                        ], 18.0));
                                              }
                                            },
                                          ),
                                        ),
                                        // children: trainingList.map(
                                        //   (training) {
                                        //     return Card(
                                        //         child: buildExerciceCard([
                                        //       training.title,
                                        //       training.reps,
                                        //       '${training.rest} sec'
                                        //     ], 15.0));
                                        //   },
                                        // ).toList(),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showGeneralDialog<Void>(
                                          context: context,
                                          transitionBuilder:
                                              (context, a1, a2, widget) {
                                            final curvedValue = Curves
                                                    .easeInOutBack
                                                    .transform(a1.value) -
                                                1.0;
                                            return Transform(
                                              transform:
                                                  Matrix4.translationValues(0.0,
                                                      curvedValue * 200, 0.0),
                                              child: Opacity(
                                                opacity: a1.value,
                                                child: AlertDialog(
                                                  scrollable: true,
                                                  title: const Text(
                                                      "Add a new exercice"),
                                                  content: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelText:
                                                                        'Name',
                                                                  ),
                                                                  controller:
                                                                      _exerciceNameController,
                                                                ),
                                                                insertSpace(20),
                                                                Row(children: [
                                                                  Text(
                                                                      'Number of reps :',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600)),
                                                                  const Spacer()
                                                                ]),
                                                                insertSpace(10),
                                                                Slider(
                                                                    value:
                                                                        _repsController,
                                                                    onChanged:
                                                                        (newReps) {
                                                                      setState(() =>
                                                                          _repsController =
                                                                              newReps);
                                                                    },
                                                                    activeColor:
                                                                        darkBeige,
                                                                    inactiveColor:
                                                                        Colors
                                                                            .grey,
                                                                    min: 0,
                                                                    max: 40,
                                                                    divisions:
                                                                        40,
                                                                    label:
                                                                        "${_repsController.toInt()}"),
                                                                insertSpace(20),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'Resting time :',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600),
                                                                    ),
                                                                    const Spacer()
                                                                  ],
                                                                ),
                                                                insertSpace(10),
                                                                Slider(
                                                                    value:
                                                                        _timeController,
                                                                    onChanged:
                                                                        (newTime) {
                                                                      setState(() =>
                                                                          _timeController =
                                                                              newTime);
                                                                    },
                                                                    activeColor:
                                                                        darkBeige,
                                                                    inactiveColor:
                                                                        Colors
                                                                            .grey,
                                                                    min: 0,
                                                                    max: 120,
                                                                    divisions:
                                                                        24,
                                                                    label:
                                                                        "${_timeController.toInt()}")
                                                              ],
                                                            ),
                                                          ),
                                                          buildUpdateButton(
                                                            context,
                                                            () {
                                                              Navigator.pop(
                                                                  context);
                                                              _addExercice(
                                                                  _exerciceNameController
                                                                      .text,
                                                                  _repsController
                                                                      .toInt(),
                                                                  _timeController
                                                                      .toInt());
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .collection(
                                                                      'Exercices')
                                                                  .doc(
                                                                      _exerciceNameController
                                                                          .text)
                                                                  .set({
                                                                'Name':
                                                                    _exerciceNameController
                                                                        .text,
                                                                'Repetitions':
                                                                    _repsController
                                                                        .toInt(),
                                                                'Time':
                                                                    _timeController
                                                                        .toInt()
                                                              });
                                                            },
                                                            'Create exercice',
                                                            [
                                                              lightBeige,
                                                              darkBeige
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                          barrierDismissible: true,
                                          barrierLabel: '',
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return const Text('');
                                          },
                                        );
                                      },
                                      icon:
                                          const Icon(Icons.add_circle_outlined),
                                      color: darkBeige,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
