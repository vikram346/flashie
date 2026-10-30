import 'package:flutter/material.dart';

class CardDetails extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final argu = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String ques = argu["question"];
    final String ans = argu["answer"];
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 14, left: 8, right: 8, bottom: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ques, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
            SizedBox(height: 18,),
            Text(ans, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white))
          ],
        ),
      ),
    );
  }
}