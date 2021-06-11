import 'package:flutter/material.dart';
import 'package:questions_apk/models.dart';

class DropDownButtons extends StatefulWidget {
  final Function displayDropdown;
  final question;

  const DropDownButtons({this.displayDropdown, this.question});
  @override
  _DropDownButtonsState createState() => _DropDownButtonsState();
}

class _DropDownButtonsState extends State<DropDownButtons> {
  String selectedValue;
  DropDownQuestion dropDownQuestion;

  List<DropdownMenuItem<String>> getitems() {
    List<DropdownMenuItem> dropDownitems =
        dropDownQuestion.options.map((element) {
      return DropdownMenuItem<String>(
        value: element,
        child: Text(element),
      );
    }).toList();

    return dropDownitems;
  }

  @override
  void initState() {
    dropDownQuestion = DropDownQuestion(
      name: widget.question['name'],
      options: widget.question['options'],
    );

    print(dropDownQuestion.options);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text('Please select option'),
        value: selectedValue,
        onChanged: (v) {
          setState(() {
            selectedValue = v.toString();
            widget.displayDropdown(
                dropDownQuestion.name.toString(), selectedValue);
          });
        },
        items: getitems(),
      ),
    );
  }
}
