import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ResultsScreen extends StatefulWidget {
  final List<dynamic> questions;

  const ResultsScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isAnimationDone = false;

  @override
  Widget build(BuildContext context) {
    int correctAnswers = widget.questions.where((q) {
      final correctOption =
          q['options'].firstWhere((option) => option['is_correct'] == true);
      return correctOption['id'] == q['selectedOption'];
    }).length;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'You scored $correctAnswers/${widget.questions.length}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          // Main content of the screen
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display Score

                const SizedBox(height: 20),
                // List of Questions and Answers
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.questions.length,
                    itemBuilder: (context, index) {
                      final question = widget.questions[index];
                      final correctOption = question['options']
                          .firstWhere((option) => option['is_correct'] == true);
                      final selectedOption = question['options'].firstWhere(
                        (option) => option['id'] == question['selectedOption'],
                        orElse: () => null,
                      );

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            question['isExpanded'] =
                                !(question['isExpanded'] ?? false);
                          });
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  question['description'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your answer: ${selectedOption != null ? selectedOption['description'] : "No answer selected"}',
                                      style: TextStyle(
                                        color: selectedOption == correctOption
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    Text(
                                      'Correct answer: ${correctOption['description']}',
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              if (question['isExpanded'] ?? false)
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[700],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Detailed Solution:',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          SizedBox(height: 10),
                                          Text(
                                            question['detailed_solution'] ??
                                                'No detailed solution provided.',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.go('/quiz');
                  },
                  child: const Text('Retake Quiz'),
                ),
              ],
            ),
          ),

          // Lottie animation overlay
          if (!isAnimationDone)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/Animation - 1737180137319.json', // Replace with your Lottie file path
                    onLoaded: (composition) {
                      Future.delayed(composition.duration, () {
                        setState(() {
                          isAnimationDone = true;
                        });
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
