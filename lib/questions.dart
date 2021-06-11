import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:questions_apk/models.dart';
import 'package:questions_apk/widgets/dropDown.dart';
import 'package:questions_apk/widgets/multipleQuestions.dart';
import 'package:toast/toast.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<DisplayDropdown> displayDropDownList = [];
  List<DisplayMultiChoice> displayMultichoice = [];

  displayDropDown(String name, String option) {
    final exist =
        displayDropDownList.where((element) => element.name == name).toList();

    print('element exists or not');
    print(exist);

    if (exist.length == 0) {
      displayDropDownList.add(DisplayDropdown(name: name, option: option));
    } else {
      displayDropDownList.removeWhere((element) => element.name == name);
      displayDropDownList.add(DisplayDropdown(name: name, option: option));
    }

    displayDropDownList.forEach((element) {
      print(element.option);
    });
  }

  displayMultichose(String name, List options) {
    final exist =
        displayMultichoice.where((element) => element.name == name).toList();

    if (exist.length == 0) {
      displayMultichoice.add(DisplayMultiChoice(name: name, option: options));
    } else {
      displayMultichoice.removeWhere((element) => element.name == name);
      displayMultichoice.add(DisplayMultiChoice(name: name, option: options));
    }

    displayMultichoice.forEach((element) {
      print(element.option);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/demo.json'),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var showData = json.decode(snapShot.data.toString());
          final questions = showData['data']['fields'];

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        if (questions[index]['type'] == 'dropdown') {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(questions[index]['name']),
                                  DropDownButtons(
                                    question: questions[index],
                                    displayDropdown: displayDropDown,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return MultipleChoiceQuestion(
                            question: questions[index],
                            displayMultiChoice: displayMultichose,
                          );
                        }
                      }),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Toast.show(
                        'DropDown Answers \n\n ${displayDropDownList.map((element) {
                          return ' ${element.name} =>  ${element.option}';
                        }).toString()}\n\n'
                        'Multiple Choice Answeres\n\n'
                        '${displayMultichoice.map((e) {
                          return '${e.name} => ${e.option}';
                        })}',
                        context,
                        duration: 2,
                        gravity: Toast.BOTTOM);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Check Answers',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
