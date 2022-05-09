import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';

Widget insertSpace(double height) {
  return SizedBox(height: height);
}

Widget buildText(String text, TextAlign align) {
  return Row(
    children: [
      Text(
        text,
        style: GoogleFonts.oswald(color: Colors.black, fontSize: 20),
        textAlign: align,
      ),
    ],
  );
}

Widget buildTitle(String text, TextAlign align) {
  return Text(
    text,
    style: GoogleFonts.pacifico(color: Colors.white, fontSize: 50),
    textAlign: align,
  );
}

Widget buildTopEllipse(String imagePath) {
  return Container(
    height: 240,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
    ),
  );
}

Widget buildForgotPassword() {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => print('Forgot password pressed'),
      child: Text('Forgot your password ?',
          style: GoogleFonts.oswald(color: Colors.black, fontSize: 15)),
    ),
  );
}

BoxDecoration kBoxDecoration(radius) {
    return BoxDecoration(
      borderRadius: radius,
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
    );
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

Widget buildGradientButton() {
  return ElevatedButton(
    onPressed: () => print('login pressed'),
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Ink(
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [darkBlue, lightBlue]),
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: 70,
        alignment: Alignment.center,
        child: Text(
          'Log In',
          style: GoogleFonts.pacifico(color: Colors.white, fontSize: 25),
        ),
      ),
    ),
  );
}

Widget buildGradientContainer(Alignment alignment, List<Color> gradColors) {
  return Container(
    alignment: alignment,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.black, width: 1),
      gradient: LinearGradient(colors: gradColors),
    ),
    height: 60,
    width: 335,
  );
}



Widget buildUpdateButton(context, onPressed, text, gradientColors) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        height: 60,
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.pacifico(color: Colors.white, fontSize: 20),
        ),
      ),
    ),
  );
}

Widget buildMacroForm(formKey, heightController, weightController,
    ageController, label1, label2, label3) {
  return Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          // inputFormatters: [FilteringTextInputFormatter],
          decoration: InputDecoration(labelText: '$label1'),
          // validator: (value) {
          //   if (value is int &&
          //       10 >= int.parse(value!) &&
          //       int.parse(value) <= 250) {
          //     return null;
          //   } else {
          //     return ('Please enter a valid number');
          //   }
          // },
          controller: heightController,
          // onSaved: (value){
          //   heightController = int.parse(value!);
          // },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: '$label2',
          ),
          // validator: (value) {
          //   if (value is int &&
          //       10 >= int.parse(value!) &&
          //       int.parse(value) <= 250) {
          //     return null;
          //   } else {
          //     return ('Please enter a valid number');
          //   }
          // },
          controller: weightController,
          // onSaved: (value){
          //   weightController = int.tryParse(value!);
          // },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: '$label3',
          ),
          // validator: (value) {
          //   if (value is int &&
          //       10 >= int.parse(value!) &&
          //       int.parse(value) <= 110) {
          //     return null;
          //   } else {
          //     print('validation issue');
          //     return ('Please enter a valid number');
          //   }
          // },
          controller: ageController,
          // onSaved: (value){
          //   ageController = int.tryParse(value!);
          // },
        ),
      ],
    ),
  );
}

Widget buildExerciceCard(List exercices, fontSize) {
  return Card(
    margin: const EdgeInsets.all(2),
    elevation: 2,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    // shadowColor: Colors.black,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          exercices[0],
          style: GoogleFonts.pacifico(color: Colors.black, fontSize: fontSize),
        ),
        Text(
          'Reps : ${exercices[1]}\nRest : ${exercices[2]}',
        ),

        // ListTile(
        //   leading: Text(
        //     exercices[0],
        //     style:
        //         GoogleFonts.pacifico(color: Colors.black, fontSize: fontSize),
        //   ),
        //   subtitle: Text(
        //     'Reps : ${exercices[1]}\nRest : ${exercices[2]} sec',
        //   ),
        //   dense: true,
        //   // trailing: IconButton(
        //   //     icon: const Icon(
        //   //       Icons.close,
        //   //       color: darkBeige,
        //   //     ),
        //   //     onPressed: () {}),
        // ),
      ],
    ),
  );
}
