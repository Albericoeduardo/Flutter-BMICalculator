import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class ScoreScreen extends StatelessWidget {

  final double bmiScore;

  final int age;

  String? bmiStatus;

  String? bmiInterpretation;
  
  Color? bmiStatusColor;

  ScoreScreen({Key? key, required this.bmiScore, required this.age}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("RESULTADO IMC")
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: Card (
            elevation: 12,
            shape: const RoundedRectangleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Seu resultado", 
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                  )
                ),
                const SizedBox(
                  height: 10,
                ),
                PrettyGauge(
                  gaugeSize: 300,
                  minValue: 0,
                  maxValue: 40,
                  segments: [
                    GaugeSegment("UnderWeight", 18.5, Colors.red),
                    GaugeSegment("Normal", 6.4, Colors.green),
                    GaugeSegment("OverWeight", 5, Colors.orange),
                    GaugeSegment("Obese", 10.1, Colors.pink)
                  ],
                  valueWidget: Text(
                    bmiScore.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 40),
                  ),
                  currentValue: bmiScore.toDouble(),
                  needleColor: Colors.blue,
                ),
                const SizedBox(height: 10,),
                Text(
                  bmiStatus!,
                  style: TextStyle(
                    fontSize: 20,
                    color: bmiStatusColor
                  ),  
                ),
                const SizedBox(height: 10,),
                Text(
                  bmiInterpretation!,
                  style: const TextStyle(
                    fontSize: 20,
                  ),  
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      child: const Text("Calcular novamente")),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () {
                        Share.share("Seu IMC é ${bmiScore.toStringAsFixed(1)} at age $age");
                      }, 
                      child: const Text("Compartilhar"))
                  ],
                )
            ]
          )
        )
      ),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obeso";
      bmiInterpretation = "Trabalhe para reduzir seu peso.";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25) {
      bmiStatus = "Sobrepeso";
      bmiInterpretation = "Faça exercícios regulares e reduza o peso.";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Parabéns, você está no peso ideal.";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Abaixo do peso";
      bmiInterpretation = "Abaixo do peso, tente consultar profissionais";
      bmiStatusColor = Colors.red;
    }
  }

}
