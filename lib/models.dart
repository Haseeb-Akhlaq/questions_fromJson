class ChoiceQuestion {
  String name;
  List options;
  List optionsChecked;
  ChoiceQuestion({this.name, this.options, this.optionsChecked});
}

class DropDownQuestion {
  String name;
  List options;
  DropDownQuestion({
    this.name,
    this.options,
  });
}

class DisplayDropdown {
  String name;
  String option;

  DisplayDropdown({this.name, this.option});
}

class DisplayMultiChoice {
  String name;
  List option;

  DisplayMultiChoice({this.name, this.option});
}
