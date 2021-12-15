import 'package:flutter/material.dart';
import 'package:flutter_ppl/widget/buildCards.dart';
import 'package:flutter_ppl/widget/buildForm.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int itemColumn1=0;
  int itemColumn2=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        SizedBox(
          width: 300,
          child: Column(
            children: [
              buildBotonMenu("assets/img/pabellon.png", "Registrar un Pabellón",(){setState(() {
                itemColumn1=0;
              });}),
              buildBotonMenu("assets/img/ppl.png", "Registrar un PPL",(){setState(() {
        itemColumn1=1;
        });})
            ],
          ),
        ),
        VerticalDivider(),
        VerticalDivider(),
        Expanded(
          child: Container(color: Colors.red),
        ),
        VerticalDivider(),
        VerticalDivider(),
        Expanded(
          child: itemColumn1==0?BuildFormPabellon():itemColumn1==1?BuildFormPpl():Container(),
        )
      ],
    ));
  }

}
