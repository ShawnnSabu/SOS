import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator SOS',
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "";
  String _expression = "";
  bool _sosTriggered = false;

  buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        _output = "";
        _expression = "";
        _sosTriggered = false;
      } else if (text == "=") {
        if (_expression == "911") {
          _sosTriggered = true;
          _output = "🚨 SOS Triggered ";
        } else {
          try {
            // Simple calculation
            final result = _calculate(_expression);
            _output = result.toString();
          } catch (e) {
            _output = "Error";
          }
        }
      } else {
        _expression += text;
        _output = _expression;
      }
    });
  }

  double _calculate(String expr) {
    // Very basic calculation handler
    try {
      if (expr.contains("+")) {
        var parts = expr.split("+");
        return double.parse(parts[0]) + double.parse(parts[1]);
      } else if (expr.contains("-")) {
        var parts = expr.split("-");
        return double.parse(parts[0]) - double.parse(parts[1]);
      } else if (expr.contains("×")) {
        var parts = expr.split("×");
        return double.parse(parts[0]) * double.parse(parts[1]);
      } else if (expr.contains("÷")) {
        var parts = expr.split("÷");
        return double.parse(parts[0]) / double.parse(parts[1]);
      }
    } catch (e) {
      return double.nan;
    }
    return double.tryParse(expr) ?? 0.0;
  }

  Widget buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(22),
            backgroundColor: color ?? (_sosTriggered ? Colors.red : Colors.green),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          onPressed: () => buttonPressed(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _sosTriggered ? Colors.white : Colors.black,
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: _sosTriggered ? Colors.red : Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 36,
                  color: _sosTriggered ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("×", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0"),
                  buildButton("."),
                  buildButton("C", color: Colors.red),
                  buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("=", color: Colors.blue),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
