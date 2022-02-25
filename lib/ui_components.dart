import 'package:auth/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './constants.dart';
import 'package:google_fonts/google_fonts.dart';

Widget insertSpace(double height) {
  return SizedBox(height: height);
}

Widget buildText(String text, TextAlign align) {
  return Row(
    children: [
      Text(
        text,
        style: GoogleFonts.pacifico(color: Colors.black, fontSize: 20),
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
          style: GoogleFonts.pacifico(color: Colors.black, fontSize: 15)),
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

Widget buildAuthButton(Function onPressed, bool isLogin) {
  return ElevatedButton(
    onPressed: () {
      onPressed();
    },
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Ink(
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [lightBlue, darkBlue]),
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: 70,
        alignment: Alignment.center,
        child: Text(
          isLogin ? 'Log In' : 'Sign Up',
          style: GoogleFonts.pacifico(color: Colors.white, fontSize: 25),
        ),
      ),
    ),
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

Widget buildMacroForm(
    formKey, heightController, weightController, ageController) {
  return Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Height (cm)',
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
          controller: heightController,
          // onSaved: (value){
          //   heightController = int.parse(value!);
          // },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Weight (kg)',
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
          decoration: const InputDecoration(
            labelText: 'Age',
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

class CategoryRow extends StatelessWidget {
  const CategoryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          insertSpace(80),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(82, 98, 255, 1),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Proteins',
                style: GoogleFonts.pacifico(color: Colors.grey.shade800, fontSize: 16),
                
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 171, 67, 1),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Carbs',
                style: GoogleFonts.pacifico(color: Colors.grey.shade800, fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(252, 91, 57, 1),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Fats',
                style: GoogleFonts.pacifico(color: Colors.grey.shade800, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
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
              Center(
                child: SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: PieChart(
                        width: constraints.maxWidth * 0.5,
                        categories: kCategories),
                  ),
                ),
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
                            style: GoogleFonts.pacifico(
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
