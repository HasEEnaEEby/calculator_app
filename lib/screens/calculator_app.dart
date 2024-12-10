import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  String input = ""; 
  String firstOperand = ""; 
  String secondOperand = "";
  String operator = ""; 
  String calculationProcess = ""; 

  List<String> lstSymbols = [
    "C", "*", "/", "<-", "1", "2", "3", "+", "4", "5", "6", "-", 
    "7", "8", "9", "*", "%", "0", ".", "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haseenas Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              calculationProcess,
              style: const TextStyle(
                fontSize: 18,  
                fontWeight: FontWeight.bold,
                color: Colors.black45, 
              ),
              textAlign: TextAlign.right, 
            ),
          
            const SizedBox(height: 8),
            TextFormField(
              textDirection: TextDirection.rtl,
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black, 
              ),
              readOnly: true,
            ),
            const SizedBox(height: 8),
            // The grid of buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 34, 210, 178),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(lstSymbols[index]),
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        input = "";
        firstOperand = "";
        secondOperand = "";
        operator = "";
        calculationProcess = "";
      } else if (symbol == "<-") {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
      } else if (symbol == "=") {
        if (firstOperand.isNotEmpty && operator.isNotEmpty && input.isNotEmpty) {
          secondOperand = input;  
          double num1 = double.parse(firstOperand);
          double num2 = double.parse(secondOperand);
          double result;

          switch (operator) {
            case "+":
              result = num1 + num2;
              break;
            case "-":
              result = num1 - num2;
              break;
            case "*":
              result = num1 * num2;
              break;
            case "/":
              result = num2 != 0 ? num1 / num2 : 0; 
              break;
            case "%":
              result = num1 % num2;
              break;
            default:
              result = 0;
          }

          input = result == result.toInt() ? result.toInt().toString() : result.toString();
          firstOperand = ""; 
          secondOperand = "";
          operator = "";
          calculationProcess = ""; 
        }
      } else if (symbol == "+" || symbol == "-" || symbol == "*" || symbol == "/" || symbol == "%") {
        if (firstOperand.isEmpty) {
          firstOperand = input;
          input = ""; 
        }
        operator = symbol; 
        calculationProcess = '$firstOperand $operator'; 
      } else {
        input += symbol;
        calculationProcess = '$firstOperand $operator $input';
      }

      _textController.text = input;
    });
  }
}
