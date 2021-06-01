import 'package:flutter/material.dart';
import 'package:speech_recog_with_quiz_project/ans.dart';
import 'package:speech_recog_with_quiz_project/que.dart';



class Quiz extends StatelessWidget {
final List<Map<String, Object>> questions;
final int questionIndex;
final Function answerQuestion;

Quiz({
	@required this.questions,
	@required this.answerQuestion,
	@required this.questionIndex,
});

@override
Widget build(BuildContext context) {
	return Column(
	children: [
		Question(
		questions[questionIndex]['questionText'],
		), //Question
		...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
			.map((answer) {
		return Answer(() => answerQuestion(answer['score']), answer['text']);
		}).toList()
	],
	); //Column
}
}
