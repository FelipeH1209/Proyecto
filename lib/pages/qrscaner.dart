import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

const bgColor = Color(0xfffafafa);

class Qrscaner extends StatelessWidget {
  Qrscaner({super.key});
  final TextEditingController pesoT = TextEditingController();
  final TextEditingController estaturaT = TextEditingController();
  final TextEditingController razaT = TextEditingController();
  final TextEditingController generoT = TextEditingController();

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
            controller: pesoT,
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
            controller: estaturaT,
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
            controller: razaT,
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
            controller: generoT,
            keyboardType: TextInputType.name,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Genero Novillo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 12, top: 12),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 6,
                          color: Colors.black12,
                          spreadRadius: 1),
                    ]),
                child: Text(
                  'Guardar',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
        ],
      ),
      /*   backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ESCANEO QR',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Coloque el Codigo QR en el area',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'El codigo se escaneara automaticamente',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                onDetect: (barcode, args) {},
              ),
            ),
            Expanded(
              child: Container(
                  child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                ],
              )),
            ),
          ],
        ),
      ), */
    );
  }
}
