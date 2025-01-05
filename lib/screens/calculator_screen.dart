import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/calculator_provider.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    state.expression,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.result,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              final buttonLabels = [
                '7',
                '8',
                '9',
                '/',
                '4',
                '5',
                '6',
                '*',
                '1',
                '2',
                '3',
                '-',
                'C',
                '0',
                '=',
                '+',
                'DEL',
                '.',
                '(',
                ')'
              ];

              final label = buttonLabels[index];
              return CalculatorButton(
                label: label,
                onPressed: () {
                  if (label == 'C') {
                    ref.read(calculatorProvider.notifier).clear();
                  } else if (label == 'DEL') {
                    ref.read(calculatorProvider.notifier).deleteLastCharacter();
                  } else if (label == '=') {
                    ref.read(calculatorProvider.notifier).calculateResult();
                  } else {
                    ref.read(calculatorProvider.notifier).addCharacter(label);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
