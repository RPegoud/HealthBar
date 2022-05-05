import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../ui_components.dart';
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
        if (fatsController + carbsController + proteinController == 100) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Split updated !',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
            ),
          );
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
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Split values must summ up to 100',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
        }
      }, 'Update', [neumorphicBlue, neumorphicBlue]),
    ],
  );
}
