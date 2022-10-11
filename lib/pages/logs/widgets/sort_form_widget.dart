import 'package:flutter/material.dart';

const List<String> months = <String>[
  'January',
  'February',
  'March',
  'May',
  'April',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

const List<int> years = <int>[
  2022,
  2021,
  2020,
  2019,
];

class SortForm extends StatefulWidget {
  final Function setMonthAndYear;

  const SortForm({Key? key, required this.setMonthAndYear}) : super(key: key);

  @override
  State<SortForm> createState() => _SortFormState();
}

class _SortFormState extends State<SortForm> {
  String dropdownValue = months.elementAt(DateTime.now().month - 1);
  int dropdownValueTwo =
      years.firstWhere((element) => element == DateTime.now().year);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: DropdownButtonFormField(
                  items: months.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    dropdownValue = value!;
                    setState(() {});
                  },
                  value: dropdownValue,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: DropdownButtonFormField(
                  items: years.map<DropdownMenuItem<int>>((int? value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    dropdownValueTwo = value!;
                    setState(() {});
                  },
                  value: dropdownValueTwo,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              _submitData();
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  void _submitData() {
    final monthValue = dropdownValue;
    final yearValue = dropdownValueTwo;

    widget.setMonthAndYear(
      monthValue,
      yearValue,
    );

    Navigator.pop(context);
  }
}
