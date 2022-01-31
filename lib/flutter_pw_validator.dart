library flutter_password_validator;

import 'package:flutter/material.dart';
import 'package:flutter_password_validator/Utilities/ConditionsHelper.dart';
import 'package:flutter_password_validator/Utilities/Validator.dart';

import 'Components/ValidationBarWidget.dart';
import 'Resource/MyColors.dart';
import 'Resource/Strings.dart';
import 'Utilities/SizeConfig.dart';

class FlutterPasswordValidator extends StatefulWidget {
  final int minLength, uppercaseCharCount, numericCharCount, specialCharCount;
  final Color defaultColor, barOneColor, barTwoColor, barThreeColor, barFourColor;
  final double width, height;
  final Function onSuccess;
  final Function? onFail;
  final TextEditingController controller;
  final FlutterPasswordValidatorStrings? strings;

  FlutterPasswordValidator({required this.width,
    required this.height,
    required this.minLength,
    required this.onSuccess,
    required this.controller,
    this.uppercaseCharCount = 0,
    this.numericCharCount = 0,
    this.specialCharCount = 0,
    this.defaultColor = MyColors.gray,
    this.barFourColor = MyColors.green,
    this.barOneColor = MyColors.red,
    this.barThreeColor = MyColors.lightGreen,
    this.barTwoColor = MyColors.yellow,
    this.strings,
    this.onFail}) {
    //Initial entered size for global use
    SizeConfig.width = width;
    SizeConfig.height = height;
  }

  @override
  State<StatefulWidget> createState() => new _FlutterPasswordValidatorState();

  FlutterPasswordValidatorStrings get translatedStrings =>
      this.strings ?? FlutterPasswordValidatorStrings();
}

class _FlutterPasswordValidatorState extends State<FlutterPasswordValidator> {
  /// Estimate that this the first run or not
  late bool isFirstRun;
  late Color setBarColor;

  /// Variables that hold current condition states
  dynamic hasMinLength,
      hasMinUppercaseChar,
      hasMinNumericChar,
      hasMinSpecialChar;

  //Initial instances of ConditionHelper and Validator class
  late final ConditionsHelper conditionsHelper;
  Validator validator = new Validator();

  /// Get called each time that user entered a character in EditText
  void validate() {
    /// For each condition we called validators and get their new state
    hasMinLength = conditionsHelper.checkCondition(
        widget.minLength,
        validator.hasMinLength,
        widget.controller,
        widget.translatedStrings.atLeast,
        hasMinLength);

    hasMinUppercaseChar = conditionsHelper.checkCondition(
        widget.uppercaseCharCount,
        validator.hasMinUppercase,
        widget.controller,
        widget.translatedStrings.uppercaseLetters,
        hasMinUppercaseChar);

    hasMinNumericChar = conditionsHelper.checkCondition(
        widget.numericCharCount,
        validator.hasMinNumericChar,
        widget.controller,
        widget.translatedStrings.numericCharacters,
        hasMinNumericChar);

    hasMinSpecialChar = conditionsHelper.checkCondition(
        widget.specialCharCount,
        validator.hasMinSpecialChar,
        widget.controller,
        widget.translatedStrings.specialCharacters,
        hasMinSpecialChar);

    /// Checks if all condition are true then call the onSuccess and if not, calls onFail method
    int conditionsCount = conditionsHelper.getter()!.length;
    print("conditionsCount : $conditionsCount");
    int barCount = 0;
    for (bool value in conditionsHelper.getter()!.values) {
      if (value == true) barCount += 1;
      print("barCount : $barCount");
      if(barCount==2){
        setBarColor=widget.barTwoColor;
      }else if(barCount==3){
        setBarColor=widget.barThreeColor;
      }else if(barCount==4){
        setBarColor=widget.barFourColor;
      }else{
        setBarColor=widget.barOneColor;
      }
    }
    if (conditionsCount == barCount)
      widget.onSuccess();
    else if (widget.onFail != null) widget.onFail!();
    if (!mounted) return;

    //Rebuild the UI
    setState(() => null);
    barCount = 0;
  }

  @override
  void initState() {
    super.initState();
    setBarColor = widget.defaultColor;
    isFirstRun = true;

    conditionsHelper = ConditionsHelper(widget.translatedStrings);

    /// Sets user entered value for each condition
    conditionsHelper.setSelectedCondition(
        widget.minLength,
        widget.uppercaseCharCount,
        widget.numericCharCount,
        widget.specialCharCount);

    /// Adds a listener callback on TextField to run after input get changed
    widget.controller.addListener(() {
      isFirstRun = false;
      validate();
    });
  }

  @override void dispose() {
    //widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: SizeConfig.width,
      height: widget.height,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Flexible(
            flex: 3,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Iterate through the conditions map values to check if there is any true values then create green ValidationBarComponent.
                for (bool value in conditionsHelper.getter()!.values)
                  if (value == true)

                    new ValidationBarComponent(color: setBarColor),

                // Iterate through the conditions map values to check if there is any false values then create red ValidationBarComponent.
                for (bool value in conditionsHelper.getter()!.values)
                  if (value == false)
                    new ValidationBarComponent(color: widget.defaultColor)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
