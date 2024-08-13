import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_application_ganaderia/database/localDb.dart';
import 'package:flutter_application_ganaderia/pages/codigoqrgenerar.dart';
// ignore: unused_import
import 'package:mobile_scanner/mobile_scanner.dart';

const bgColor = Color(0xfffafafa);

class Qrscaner extends StatelessWidget {
  Qrscaner({super.key});
  final _pesoTController = TextEditingController();
  final _estaturaTController = TextEditingController();
  final _razaTController = TextEditingController();
  final _generoTController = TextEditingController();
  final _enfermedadesController = TextEditingController();
  final _medicamentoController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _criasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Registro Bobino'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: _pesoTController,
            keyboardType: TextInputType.text,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Peso Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          TextField(
            autocorrect: false,
            controller: _estaturaTController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Estatura Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          TextField(
            autocorrect: false,
            controller: _razaTController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Raza Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          TextField(
            autocorrect: false,
            controller: _generoTController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Genero Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          TextField(
            autocorrect: false,
            controller: _enfermedadesController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Enfermedades Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          TextField(
            autocorrect: false,
            controller: _medicamentoController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Medicamentos Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          TextField(
            autocorrect: false,
            controller: _categoriaController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Categoria Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          TextField(
            autocorrect: false,
            controller: _criasController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Crias Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Codigoqrgenerar(
                  pesoT: _pesoTController.text,
                  estaturaT: _estaturaTController.text,
                  razaT: _razaTController.text,
                  generoT: _generoTController.text,
                  enfermedades: _enfermedadesController.text,
                  medicamento: _medicamentoController.text,
                  categoria: _categoriaController.text,
                  crias: _criasController.text,
                ),
              ));
            },
            child: const Text('Generar Qr'),
          )
        ],
      ),
    );
  }
}
