import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = '0';
  String result = '0';
  late String expression ;
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonpressed(String buttonText)
  {
    setState(() {
      if (buttonText == 'C') {
        result = '0';
        equation = '0';
      } else if (buttonText == '⊗') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      }
      else if (buttonText == '=') {
        equationFontSize = 38;
        resultFontSize = 48;

         expression = equation;
         expression = expression.replaceAll('÷', '/');
         expression = expression.replaceAll('×', '*');

        Parser pr = Parser();
        Expression exp = pr.parse(expression);

        result= '${exp.evaluate(EvaluationType.REAL, ContextModel())}';

      }
      else{
      if (equation == '0') {
        equation = buttonText;
      } else
        equation = equation + buttonText;
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Center(
         child: Text('Simple Calculator'),),
      ),
    body:Column(
      children:
      [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(equation,
            style: TextStyle(
              fontSize: equationFontSize,
            ),),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(result,
              style: TextStyle(
                fontSize: resultFontSize,
              ),
            ),
          ),
        ),

        Expanded(
            child: Divider()),

        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children:
          [
            Container(
              width: MediaQuery.of(context).size.width *.75 ,
                child: Table(
                  children:
                  [
                    TableRow(
                      children:
                      [
                       buildButton('C', 1, Colors.redAccent),
                         buildButton('⊗', 1, Colors.blue),
                        buildButton('÷', 1, Colors.blue)
                      ],
                    ),
                    TableRow(
                      children:
                      [
                        buildButton('7', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children:
                      [
                        buildButton('4', 1, Colors.black54),
                        buildButton('5', 1, Colors.black54),
                        buildButton('6', 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children:
                      [
                        buildButton('1', 1, Colors.black54),
                        buildButton('2', 1, Colors.black54),
                        buildButton('3', 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children:
                      [
                        buildButton('.', 1, Colors.black54,),
                        buildButton('0', 1, Colors.black54),
                        buildButton('00', 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
            ),

            Container(
                width: MediaQuery.of(context).size.width *.25,
                child: Table(
                  children:
                  [
                    TableRow(
                      children:
                      [
                        buildButton('×', 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                        children:
                        [
                          buildButton('-', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children:
                        [
                          buildButton('+', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children:
                        [
                          buildButton('=', 2, Colors.redAccent),
                        ]
                    ),
                  ],
                ),
            ),
          ],
        ),

      ],
    ),
    );
  }

  Widget buildButton(String buttonText , double buttonHeigh , Color buttonColor ,)
  {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeigh,
      color: buttonColor,
      child: FlatButton(
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(0.0),
          side:BorderSide(
            width: 1,
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: (){buttonpressed(buttonText);},
        child: Text(
           buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


}
