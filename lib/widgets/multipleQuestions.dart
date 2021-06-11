import 'package:flutter/material.dart';
import 'package:questions_apk/models.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final question;
  final Function displayMultiChoice;

  const MultipleChoiceQuestion({this.question, this.displayMultiChoice});

  @override
  _MultipleChoiceQuestionState createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  ChoiceQuestion question;
  List pickedansweres = [];

  checkboxesRow() {
    return Column(
      children: question.options
          .map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e),
                  Checkbox(
                      value:
                          question.optionsChecked[question.options.indexOf(e)],
                      onChanged: (v) {
                        setState(() {
                          question.optionsChecked[question.options.indexOf(e)] =
                              v;

                          if (v == true) {
                            pickedansweres.add(e);
                          }
                          if (v == false) {
                            pickedansweres.remove(e);
                          }

                          // //     question.optionsChecked.map((e) {
                          // //   if (e == true) {
                          // //     int indexOfTrue =
                          // //         question.optionsChecked.indexOf(e);
                          // //     return question.options[indexOfTrue];
                          // //   }
                          // // }).toList();
                          //
                          // question.optionsChecked.forEach((element) {
                          //
                          //   pickedansweres=question.options;
                          //   if (element == false) {
                          //
                          //     int indexOfTrue =
                          //         question.optionsChecked.indexWhere(element);
                          //     print(indexOfTrue);
                          //
                          //     pickedansweres.removeWhere((element) => );
                          //     // pickedansweres.add(question.options[indexOfTrue]);
                          //   }
                          // });
                          //
                          // // pickedansweres
                          // //     .removeWhere((element) => element == null);

                          print('picked answeres');
                          print(pickedansweres);

                          widget.displayMultiChoice(
                              question.name, pickedansweres);
                        });
                      })
                ],
              ))
          .toList(),
    );
  }

  @override
  void initState() {
    int checkBoxesLength = widget.question['options'].length;

    List checkBoxes = List.filled(checkBoxesLength, false);

    question = ChoiceQuestion(
        name: widget.question['name'],
        options: widget.question['options'],
        optionsChecked: checkBoxes);

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question.name),
              SizedBox(height: 20),
              checkboxesRow(),
            ],
          ),
        ),
      ),
    );
  }
}
