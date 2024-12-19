import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> createAppointment({String name="bkhbh", String date = "2018-0804", String time="04-05"}) async {
  final url = Uri.parse('https://create-appointment-sot2ypbcla-as.a.run.app'); // Replace with your actual Cloud Function URL
  
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'date': date,
        'time': time,
      }),
    );

    if (response.statusCode == 201) {
      return 'Appointment created successfully';
      // Handle success
    } else {
      var body = jsonDecode(response.body);
      return body['error'];
      // Handle error
    }
  } catch (e) {
    return 'Error creating appointment: ${e.toString()}';
    // Handle exception
  }
}
