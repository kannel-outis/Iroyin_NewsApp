import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSpec {
  static dateTime(BuildContext context, setDateTimePicker) async {
    if (Platform.isAndroid == true) {
      await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2017),
              lastDate: DateTime.now())
          .then((dateTime) => setDateTimePicker(dateTime));
    } else if (Platform.isIOS) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 4,
            child: CupertinoDatePicker(
              onDateTimeChanged: setDateTimePicker,
              maximumDate: new DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day),
              initialDateTime: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day),
              minimumYear: 2017,
              maximumYear: DateTime.now().year,
              minuteInterval: 1,
              mode: CupertinoDatePickerMode.date,
            ),
          );
        },
      );
    }
  }

  static Widget optionDropOrPick(IconData icon,
      {required BuildContext context,
      required String? modelString,
      required List<String> options,
      required Function selectSide,
      required String selectOption}) {
    if (Platform.isAndroid) {
      return DropdownButton<String>(
          icon: Icon(icon),
          hint: Text(modelString ?? selectOption),
          items: options.map((value) {
            return DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (String? value) {
            selectSide(value);
          });
    } else if (Platform.isIOS) {
      return Container(
        width: 150,
        height: 50,
        child: CupertinoPicker(
          magnification: 1,
          itemExtent: 30.0,
          onSelectedItemChanged: (index) {
            selectSide(options[index]);
          },
          children: options.map((e) {
            return Center(child: Text(e));
          }).toList(),
        ),
      );
    }
    return Container();
  }

  static Widget platFormButton({Function()? onPressed, String? text}) {
    if (Platform.isAndroid) {
      return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.indigo,
          primary: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(text!),
      );
    } else if (Platform.isIOS) {
      return CupertinoButton(child: Text(text!), onPressed: onPressed);
    }
    return Container();
  }

  static Widget platFormTextfield({required TextEditingController controller}) {
    if (Platform.isAndroid) {
      return TextField(
        controller: controller,
      );
    } else if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
      );
    }
    return Container();
  }
}
