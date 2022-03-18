import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class Calci extends StatefulWidget {
  const Calci({Key? key}) : super(key: key);

  @override
  _CalciState createState() => _CalciState();
}

class _CalciState extends State<Calci> {
  var userInput = '';
  var answerUser = '';

  List<String> buttons = [
    'AC',
    'C',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];

  // bool operator
  bool isOperators(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  // equalOperators
  void isEqualOperators() {
    String finalUserInput = userInput;
    finalUserInput = finalUserInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answerUser = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 88, 12, 187),
          title: const Center(
            child: Text(
              "Calculator",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      userInput,
                      style: GoogleFonts.rubik(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                    alignment: const Alignment(1, 1),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Text(
                      answerUser,
                      style: GoogleFonts.rubik(
                        fontSize: 42,
                        color: Colors.black,
                      ),
                    ),
                    alignment: const Alignment(1, 1),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (_, int index) {
                    // buttons AC
                    if (index == 0) {
                      return MyButtons(
                        buttonTap: () {
                          setState(() {
                            userInput = '';
                            answerUser = '';
                          });
                        },
                        color: Colors.orange,
                        buttonText: buttons[index],
                        textColor: Colors.green[800],
                      );
                    }
                    // buttons C
                    else if (index == 1) {
                      return MyButtons(
                        buttonTap: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        color: Colors.grey,
                        buttonText: buttons[index],
                        textColor: const Color.fromARGB(255, 64, 240, 11),
                      );
                    }

                    // equalOperator
                    else if (index == buttons.length - 1) {
                      return MyButtons(
                        buttonTap: () {
                          setState(() {
                            isEqualOperators();
                          });
                        },
                        color: Colors.black,
                        buttonText: buttons[index],
                        textColor: (isOperators(buttons[index])
                            ? const Color.fromARGB(255, 250, 147, 30)
                            : Colors.black),
                      );
                    }

                    // buttons number
                    else {
                      return MyButtons(
                        buttonTap: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        color: Colors.black,
                        buttonText: buttons[index],
                        textColor: (isOperators(buttons[index])
                            ? const Color.fromARGB(255, 230, 8, 38)
                            : Colors.blue),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// button

class MyButtons extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final textColor;
  final String buttonText;
  final Function()? buttonTap;

  // ignore: use_key_in_widget_constructors
  const MyButtons(
      {this.color, this.textColor, required this.buttonText, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          shadowColor: const Color.fromARGB(255, 54, 143, 244),
          elevation: 25,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: GoogleFonts.rubik(
                    fontSize: 30,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
