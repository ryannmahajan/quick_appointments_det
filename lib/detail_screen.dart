import 'package:flutter/material.dart';
import 'package:quick_appointments_detail_screen/appointment_repository.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            createAppointmentAndShowSnackBar(context);
          },
          label: const Text("Save")
        ),
        appBar: AppBar(
          title: const Text("New Appointment"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {},
          )
        ),
        body: const Body(),
      );
  }
  
  void createAppointmentAndShowSnackBar(BuildContext context) async {
    String message = await createAppointment();
    print(message);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var items = [
      const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Name',
      )),
      const AppointmentTime()
      ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) => items[index],
        separatorBuilder: (context, index) => const SizedBox(height: 8,)
      ),
    );
  }
}

class AppointmentTime extends StatelessWidget{
  const AppointmentTime({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Appointment Time",
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.start,),
        const SizedBox(height: 4,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DatePickerButton(),
            SizedBox(width: 8,),
            TimeDropdownButton()
          ],
        )

      ],
    );
  }
}

class DatePickerButton extends StatefulWidget {
  const DatePickerButton({
    super.key,
  });

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: ()=> showPicker(setDate),
      child: Text(date.toString())
    );
  }

  void showPicker(
    void Function(DateTime) onSelect    
  ) async {
    final selected = await showDatePicker(
      context: context,
      firstDate: date, 
      lastDate: date.add(const Duration(days: 10),
    ));
    if (selected!=null) onSelect(selected);
  }
  

  void setDate(DateTime date) => setState(() {
    this.date = date;
  });
}

class TimeDropdownButton extends StatefulWidget {
  const TimeDropdownButton({super.key});
  // where do i store state in a stateful widget?
  // is it supposed to be immutable?

  @override
  State<TimeDropdownButton> createState() => _TimeDropdownButtonState();
}

class _TimeDropdownButtonState extends State<TimeDropdownButton> {
  int selectedIndex = 0;
  static const values = ["9:00", "9:15", "9:30"];

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      dropdownMenuEntries: convertToDropDownItems(values),
      initialSelection: values[selectedIndex],
      );
  }
  
  List<DropdownMenuEntry<String>> convertToDropDownItems(List<String> values) {
    return values.map((a) {
      return DropdownMenuEntry<String>(
        value: a,
        label: a
      );
    }).toList();
  }
}