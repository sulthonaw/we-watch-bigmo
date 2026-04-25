import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAILoding extends StatelessWidget {
  const LottieAILoding({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Lottie.asset(
                'assets/lotties/ai-loading.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 2),
            const Text(
              'Nana sedang mengetik...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
