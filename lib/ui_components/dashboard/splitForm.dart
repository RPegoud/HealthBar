import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../ui_components.dart';
import 'dashboard_components.dart';

Column splitForm(StateSetter setState, BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text('Protein percentage : ${proteinController.round()}'),
      Slider(
        value: proteinController,
        onChanged: (newProteins) {
          setState(() => proteinController = newProteins);
        },
        activeColor: neumorphicBlue,
        inactiveColor: Colors.black,
        min: 0,
        max: 100,
        divisions: 100,
        label: "${proteinController.round()}",
      ),
      Text('Carbs percentage : ${carbsController.round()}'),
      Slider(
        value: carbsController,
        onChanged: (newCarbs) {
          setState(() => carbsController = newCarbs);
        },
        activeColor: neumorphicBlue,
        inactiveColor: Colors.black,
        min: 0,
        max: 100,
        divisions: 100,
        label: "${carbsController.round()}",
      ),
      Text('Fats percentage : ${fatsController.round()}'),
      Slider(
        value: fatsController,
        onChanged: (newFats) {
          setState(() => fatsController = newFats);
        },
        activeColor: neumorphicBlue,
        inactiveColor: Colors.black,
        min: 0,
        max: 100,
        divisions: 50,
        label: "${fatsController.round()}",
      ),
      insertSpace(20),
      buildUpdateButton(context, () {
        Navigator.pop(context);
        // TODO: save to firebase
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {
            'Protein split': proteinController,
            'Carbs split': carbsController,
            'Fats split': fatsController
          },
        );
      }, 'Update', [neumorphicBlue, neumorphicBlue]),
    ],
  );
}
