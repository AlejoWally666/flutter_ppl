import 'package:flutter/material.dart';

Widget buildCardMenu(Widget w){
  return Padding(padding: EdgeInsets.all(8),child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 15,
      child:Padding(padding: EdgeInsets.all(10),child:w)),);
}

Widget buildBotonMenu(String imagen, String titulo, funcion){
  return buildCardMenu(
    InkWell(
      onTap:funcion,
      child: Row(
      children: [
        SizedBox(
            width: 80,
            child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(imagen,fit: BoxFit.contain,))),
        SizedBox(width: 15,),
        Expanded(child:Text(titulo,style:TextStyle(color:Color(0xFF064583),fontSize:18,fontWeight:FontWeight.w700)))
      ],
    ),),
  );
}

InputDecoration buildInputDecoration(IconData icon, String label) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    labelText: label,
    icon: Icon(
      icon,
      color: Color(0xFF064583),
      size: 33,
    ),
    border: OutlineInputBorder(),
  );
}

lanzarDialog(bool dato,BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context1){
      return AlertDialog(
        title: Text("Registrado"),
        content: Text(dato?"Registrado correctamente!!!":"No se ha registrado..."),
        actions:[
          FlatButton(
            onPressed: (){
              Navigator.of(context1).pop();
            },
            child: Text("OK"),
          )
        ],
      );
    },
  );
}