import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_ganaderia/pages/qrscaner.dart';

class Perfile extends StatelessWidget {
  var heigt, width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil usuario'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Registrar'),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Qrscaner()));
          },
        ),
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    heigt = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              height: heigt * 0.25,
              width: width,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Seleccione una opcion",
                            style: TextStyle(fontSize: 35)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _boton("Registrar"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _boton("Actualizar"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _boton("Insumos"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _boton("Movimientos"),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: heigt * 0.75,
              width: width,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _boton(String nombre) {
  return InkWell(
    child: Container(
      width: 97,
      height: 35,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(nombre)],
        ),
      ),
    ),
  );
}
*/
}
