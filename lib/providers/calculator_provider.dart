import 'package:expressions/expressions.dart';
import 'package:flutter_calculator_riverpod/models/calculator_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(CalculatorState());

  // Add a character (digit or operator) to the expression
  void addCharacter(String character) {
    state = CalculatorState(
      expression: state.expression + character,
      result: state.result, // Keep the result unchanged until "=" is pressed
    );
  }

  // Clear the expression and result
  void clear() {
    state = CalculatorState();
  }

  // Delete the last character in the expression
  void deleteLastCharacter() {
    if (state.expression.isNotEmpty) {
      state = CalculatorState(
        expression: state.expression.substring(0, state.expression.length - 1),
        result: state.result,
      );
    }
  }

  // Evaluate the expression and update the result
  void calculateResult() {
    final result = _calculateResult(state.expression);
    state = CalculatorState(
      expression: state.expression,
      result: result,
    );
  }

  // Helper function to evaluate the expression
  String _calculateResult(String expression) {
    try {
      final exp = Expression.parse(expression); // Parse the expression
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(exp, {}); // Evaluate the parsed expression

      if (result is double || result is int) {
        return result.toString(); // Convert the result to a string
      } else {
        return 'Error'; // Return "Error" for invalid results
      }
    } catch (e) {
      return 'Error'; // If the evaluation fails, return "Error"
    }
  }
}

// Provider to manage the state of the calculator
final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});
