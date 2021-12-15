import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'buildCards.dart';

class BuildFormPabellon extends StatefulWidget {
  @override
  _BuildFormPabellonState createState() => _BuildFormPabellonState();
}

class _BuildFormPabellonState extends State<BuildFormPabellon> {
  TextEditingController _pabellonText = TextEditingController();
  TextEditingController _numCeldasText = TextEditingController();
  TextEditingController _pplCeldaText = TextEditingController();
  int itemTipo=0;
  Map<int, Widget> mapTipo = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapTipo.putIfAbsent(
        0,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Máxima",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
    mapTipo.putIfAbsent(
        1,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Mediana",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
    mapTipo.putIfAbsent(
        2,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Mínima",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          Text("Registrar nuevo Pabellón",
              style: TextStyle(
                  color: Color(0xFF064583),
                  fontSize: 35,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center),
          SizedBox(height: 40),
          Row(children: [
            Text("Letra:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: TextField(
              controller: _pabellonText,
              keyboardType: TextInputType.text,
              decoration: buildInputDecoration(
                  Icons.title, "Pabellón"),
            ),
          ),
          SizedBox(height: 12),
          Row(children: [
            Text("Número de Celdas:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: TextField(
              controller: _numCeldasText,
              keyboardType: TextInputType.phone,
              decoration: buildInputDecoration(
                  Icons.message, "Número de Celdas"),
            ),
          ),
          SizedBox(height: 12),
          Row(children: [
            Text("Número de PPL por celda:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: TextField(
              controller: _pplCeldaText,
              keyboardType: TextInputType.streetAddress,
              decoration: buildInputDecoration(
                  Icons.image, "PPL por celda"),
            ),
          ),
          SizedBox(height: 20),
          Row(children: [
            Text("Nivel de Seguridad:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),

          SizedBox(height: 12),
          FittedBox(fit: BoxFit.contain,child: CupertinoSlidingSegmentedControl(
            children: mapTipo,
            onValueChanged: (value) {
              setState(() {
                itemTipo = value;
              });
            },
            groupValue: itemTipo,
          ),
          ),
          SizedBox(height: 40),
          AspectRatio(
            aspectRatio: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: MaterialButton(
                clipBehavior: Clip.antiAlias,
                onPressed: () {

                  int numCeldas=int.tryParse(_numCeldasText.text)??-1;
                  int numPplCelda=int.tryParse(_pplCeldaText.text)??-1;
                  if(_pabellonText.text.length!=0&&numCeldas!=-1&&numPplCelda!=-1){
                    _guardarPabellon();
                  }else{
                    Toast.show(
                        "Pabellón y número de celdas son requeridos son necesarios para enviar la notificacion",
                        context,
                        duration: Toast
                            .LENGTH_LONG,
                        gravity: Toast
                            .TOP);
                  }
                },
                shape: StadiumBorder(),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4ABDAC), Color(0xff064583)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Registrar Pabellón",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

_guardarPabellon() async {
  DocumentReference ref=await Firestore.instance.collection("pabellones").add({
    "pabellon":_pabellonText.text,
    "numCeldas":_numCeldasText.text,
    "numPplCelda":_pplCeldaText.text,
    //ItemTipo es nivel de seguridad
    "itemTipo":itemTipo,
    "fechaRegistro":DateTime.now().toString(),
    "estado":true
  });
  if(ref!=null){
    _pabellonText.text="";
    _numCeldasText.text="";
    _pplCeldaText.text="";
    itemTipo=0;
  }
  lanzarDialog(true,context);
}
}

class BuildFormPpl extends StatefulWidget {
  @override
  _BuildFormPplState createState() => _BuildFormPplState();
}

class _BuildFormPplState extends State<BuildFormPpl> {
  TextEditingController _nombreText = TextEditingController();
  TextEditingController _peligrosidadText = TextEditingController();
  TextEditingController _criminalidadText = TextEditingController();
  TextEditingController _delitoText = TextEditingController();
  int itemPeligrosidad=0;
  int itemCriminalidad=0;
  int itemTipo=0;
  Map<int, Widget> mapTipo = new Map();
  Map<int, Widget> mapCri = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapTipo.putIfAbsent(
        0,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Alta",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
    mapTipo.putIfAbsent(
        1,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Baja",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
    mapTipo.putIfAbsent(
        2,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Media",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
    mapCri.putIfAbsent(
        0,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Alta",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
    mapCri.putIfAbsent(
        1,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Baja",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
    mapCri.putIfAbsent(
        2,
            () => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Media",
            style: TextStyle(color: Color(0xFF003F7F),fontSize: 20),
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          Text("Registrar nuevo Ppl",
              style: TextStyle(
                  color: Color(0xFF064583),
                  fontSize: 35,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center),
          SizedBox(height: 40),
          Row(children: [
            Text("Nombre:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: TextField(
              controller: _nombreText,
              keyboardType: TextInputType.text,
              decoration: buildInputDecoration(
                  Icons.title, "Nombre del PPL"),
            ),
          ),
          SizedBox(height: 12),
          Row(children: [
            Text("Criminalidad:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),
          FittedBox(fit: BoxFit.contain,child: CupertinoSlidingSegmentedControl(
            children: mapCri,
            onValueChanged: (value) {
              setState(() {
                itemCriminalidad = value;
              });
            },
            groupValue: itemCriminalidad,
          ),
          ),
          SizedBox(height: 12),
          Row(children: [
            Text("Peligrosidad:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),
          FittedBox(fit: BoxFit.contain,child: CupertinoSlidingSegmentedControl(
            children: mapTipo,
            onValueChanged: (value) {
              setState(() {
                itemPeligrosidad = value;
              });
            },
            groupValue: itemPeligrosidad,
          ),
          ),
          SizedBox(height: 40),
          Row(children: [
            Text("Delito:",
                style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
            Expanded(
              child: Container(),
            )
          ]),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: TextField(
              controller: _delitoText,
              keyboardType: TextInputType.text,
              decoration: buildInputDecoration(
                  Icons.sports_kabaddi, "Delito del PPL"),
            ),
          ),
          SizedBox(height: 40),
          AspectRatio(
            aspectRatio: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: MaterialButton(
                clipBehavior: Clip.antiAlias,
                onPressed: () {

                  if(_nombreText.text.length!=0&&_delitoText.text.length!=0){
                    _guardarPpl();
                  }else{
                    Toast.show(
                        "Nombre y Delito son requeridos son necesarios para enviar la notificacion",
                        context,
                        duration: Toast
                            .LENGTH_LONG,
                        gravity: Toast
                            .TOP);
                  }
                },
                shape: StadiumBorder(),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4ABDAC), Color(0xff064583)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Registrar PPL",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  _guardarPpl() async {
    DocumentReference ref=await Firestore.instance.collection("ppls").add({
      "nombre":_nombreText.text,
      "criminalidad":itemCriminalidad,
      "peligrosidad":itemPeligrosidad,
      //ItemTipo es nivel de seguridad
      "delito":_delitoText.text,
      "fechaRegistro":DateTime.now().toString(),
      "estado":true
    });
    if(ref!=null){
      _nombreText.text="";
      _delitoText.text="";
      itemCriminalidad=0;
      itemPeligrosidad=0;
    }
    lanzarDialog(true,context);
  }
}
