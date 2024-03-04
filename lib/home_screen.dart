import 'dart:math';

import 'package:bmi_calculator/age_weigth_widget/age_weigth_widget.dart';
import 'package:bmi_calculator/gender_widget/gender_widget.dart';
import 'package:bmi_calculator/height_widget/heigth_widget.dart';
import 'package:bmi_calculator/score_screen/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _gender = 0;
  int _heigth = 170;
  int _age = 21;
  int _weigth = 70;
  bool _isFinished = false;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calculadora de IMC"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 12,
            shape: const RoundedRectangleBorder(),
            child: Column(
              children: [
                GenderWidget(onChange: (genderVal){
                  _gender = genderVal;
                }),
                HeightWidget(
                  onChange: (heigthVal) {
                    _heigth = heigthVal;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AgeWeigthWidget(
                      onChange: (ageVal) {
                        _age = ageVal;
                      },
                      title: "Idade",
                      initValue: 21,
                      min: 0,
                      max: 100,
                    ),
                    AgeWeigthWidget(
                      onChange: (weigthVal) {
                        _weigth = weigthVal;
                      },
                      title: "Peso",
                      initValue: 70,
                      min: 0,
                      max: 200,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 60
                  ),
                  child: SwipeableButtonView(
                    isFinished: _isFinished,
                    onFinish: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          child: ScoreScreen(
                            bmiScore: _bmiScore,
                            age: _age,
                          ),
                          type: PageTransitionType.fade
                        )
                      );

                      setState(() {
                        _isFinished = false;
                      });
                    }, 
                    onWaitingProcess: () {
                      calculateBmi();
                      Future.delayed(Duration(seconds: 1), (){
                        setState(() {
                          _isFinished = true;
                        });
                      });

                    }, 
                    activeColor: Colors.blue, 
                    buttonWidget: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ), 
                    buttonText: "Calcular"
                  ),
                )
              ],
            ),
          )
        )
      )
    );
  }

  void calculateBmi() {
    _bmiScore = _weigth/pow(_heigth/100, 2);
  }
}