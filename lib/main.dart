import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  // Lista para almacenar los colores de fondo de los botones numéricos
  List<Color> calcButtonColors = [
    Colors.amber,
    Colors.grey,
    const Color.fromARGB(255, 204, 197, 197),
  ];

  // Lista para almacenar los colores de texto de los botones numéricos
  List<Color> calcButtonTextColors = [
    Colors.white,
    Colors.black,
    Colors.white,
  ];
  //Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor, int index) {
    // Asegúrate de que el índice esté dentro del rango válido
    if (index >= 0 && index < calcButtonColors.length) {
      return Container(
        child: ElevatedButton(
          onPressed: () {
            calculation(btntxt);
          },
          child: Text(
            '$btntxt',
            style: TextStyle(
              fontSize: 35,
              color: calcButtonTextColors[index],
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: calcButtonColors[index],
            padding: EdgeInsets.all(20),
          ),
        ),
      );
    } else {
      // Manejar un índice fuera de rango
      return Container();
    }
  }

  ElevatedButton changeColorsButton() {
    return ElevatedButton(
      onPressed: changeColors,
      child: Text('Cambiar Colores'),
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 64, 135, 194),
        onPrimary: Colors.white,
      ),
    );
  }

  void changeColors() {
    // Cambiar los colores de los botones numéricos
    setState(() {
      for (int i = 0; i <= 2; i++) {
        calcButtonColors[i] = Color.fromARGB(255, 82, 158, 220);
        calcButtonTextColors[i] = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculadora Científica'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Botón para cambiar colores
            changeColorsButton(),
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton(
                    'sin', Color.fromARGB(255, 197, 186, 186), Colors.black, 1),
                calcbutton(
                    'cos', Color.fromARGB(255, 197, 186, 186), Colors.black, 1),
                calcbutton(
                    'tan', Color.fromARGB(255, 197, 186, 186), Colors.black, 1),
                calcbutton(
                    '√', Color.fromARGB(255, 197, 186, 186), Colors.black, 0),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton(
                    'AC', Color.fromARGB(255, 197, 186, 186), Colors.black, 1),
                calcbutton(
                    '+/-', Color.fromARGB(255, 197, 186, 186), Colors.black, 1),
                calcbutton(
                    ' % ', Color.fromARGB(255, 197, 186, 186), Colors.black, 1),
                calcbutton('/', Colors.amber, Colors.white, 0),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Colors.grey, Colors.white, 2),
                calcbutton('8', Colors.grey, Colors.white, 2),
                calcbutton('9', Colors.grey, Colors.white, 2),
                calcbutton('x', Colors.amber, Colors.white, 0),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Colors.grey, Colors.white, 2),
                calcbutton('5', Colors.grey, Colors.white, 2),
                calcbutton('6', Colors.grey, Colors.white, 2),
                calcbutton('-', Colors.amber, Colors.white, 0),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Colors.grey, Colors.white, 2),
                calcbutton('2', Colors.grey, Colors.white, 2),
                calcbutton('3', Colors.grey, Colors.white, 2),
                calcbutton('+', Colors.amber, Colors.white, 0),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Button for '0'
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.grey,
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                calcbutton('.', Colors.grey, Colors.white, 0),
                calcbutton('=', Colors.amber, Colors.white, 0),
              ],
            ),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result =
          0.0; // Inicializa result como un número en lugar de una cadena vacía
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult =
            add().toString(); // Asegura que finalResult sea una cadena
      } else if (preOpr == '-') {
        finalResult =
            sub().toString(); // Asegura que finalResult sea una cadena
      } else if (preOpr == 'x') {
        finalResult =
            mul().toString(); // Asegura que finalResult sea una cadena
      } else if (preOpr == '/') {
        finalResult =
            div().toString(); // Asegura que finalResult sea una cadena
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result); // Convierte result en un número
      } else {
        numTwo = double.parse(result); // Convierte result en un número
      }

      if (opr == '+') {
        finalResult =
            add().toString(); // Asegura que finalResult sea una cadena
      } else if (opr == '-') {
        finalResult =
            sub().toString(); // Asegura que finalResult sea una cadena
      } else if (opr == 'x') {
        finalResult =
            mul().toString(); // Asegura que finalResult sea una cadena
      } else if (opr == '/') {
        finalResult =
            div().toString(); // Asegura que finalResult sea una cadena
      }
      preOpr = opr;
      opr = btnText;
      result =
          '0'; // Inicializa result como un número en lugar de una cadena vacía
    } else if (btnText == '%') {
      result = (numOne / 100).toString(); // Asegura que result sea una cadena
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == 'sin') {
      if (result.isNotEmpty) {
        double value = double.parse(result);
        result = (sin(value)).toString();
        finalResult = result;
      }
    } else if (btnText == 'cos') {
      if (result.isNotEmpty) {
        double value = double.parse(result);
        result = (cos(value)).toString();
        finalResult = result;
      }
    } else if (btnText == 'tan') {
      if (result.isNotEmpty) {
        double value = double.parse(result);
        result = (tan(value)).toString();
        finalResult = result;
      }
    } else if (btnText == '√') {
      if (result.isNotEmpty) {
        double value = double.parse(result);
        result = (sqrt(value)).toString();
        finalResult = result;
      }
    } else if (btnText == '+/-') {
      if (result.isNotEmpty) {
        result = (-1 * double.parse(result)).toString();
        finalResult = result;
      }
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

  void main() {
    runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora'),
        ),
        body: Calculator(),
      ),
    ));
  }
}
