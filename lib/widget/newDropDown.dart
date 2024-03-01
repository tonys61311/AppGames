library dropdown_formfield;

import 'package:flutter/material.dart';

class NewDropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;
  final EdgeInsets contentPadding;
  final bool reversed;

  NewDropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
        FormFieldValidator<dynamic> validator,
        bool autovalidate = false,
        this.titleText = 'Title',
        this.hintText = 'Select one option',
        this.required = false,
        this.errorText = 'Please select one option',
        this.value,
        this.dataSource,
        this.textField,
        this.valueField,
        this.onChanged,
        this.filled = true,
        this.reversed = false,
        this.contentPadding = const EdgeInsets.fromLTRB(12, 12, 8, 0)})
      : super(
    onSaved: onSaved,
    validator: validator,
    autovalidateMode: AutovalidateMode.always,
    initialValue: value == '' ? null : value,
    builder: (FormFieldState<dynamic> state) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputDecorator(
              decoration: InputDecoration(
                contentPadding: contentPadding,
                labelText: titleText,
                filled: filled,
              ),
              child: DropdownButtonHideUnderline(
                child: reversed ? RotatedBox(
                  quarterTurns: 2,
                  child: DropdownButton<dynamic>(
                    icon: Icon(Icons.arrow_drop_up),
                  isExpanded: true,
                  hint: reversed ? RotatedBox(
                    quarterTurns: 2,
                    child: Text(
                    hintText,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),) : Text(
                    hintText,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  value: value == '' ? null : value,
                  onChanged: (dynamic newValue) {
                    state.didChange(newValue);
                    onChanged(newValue);
                  },
                  items: reversed ? dataSource.reversed.map((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item[valueField],
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Text(item[textField],
                            overflow: TextOverflow.ellipsis),
                      ),
                    );
                  }).toList() : dataSource.map((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item[valueField],
                      child: Text(item[textField],
                          overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                ),) : DropdownButton<dynamic>(
                  isExpanded: true,
                  hint: Text(
                    hintText,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  value: value == '' ? null : value,
                  onChanged: (dynamic newValue) {
                    state.didChange(newValue);
                    onChanged(newValue);
                  },
                  items: reversed ? dataSource.reversed.map((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item[valueField],
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Text(item[textField],
                            overflow: TextOverflow.ellipsis),
                      ),
                    );
                  }).toList() : dataSource.map((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item[valueField],
                      child: Text(item[textField],
                          overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: state.hasError ? 5.0 : 0.0),
            Text(
              state.hasError ? state.errorText : '',
              style: TextStyle(
                  color: Colors.redAccent.shade700,
                  fontSize: state.hasError ? 12.0 : 0.0),
            ),
          ],
        ),
      );
    },
  );
}
