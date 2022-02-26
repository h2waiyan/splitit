import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Splitit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dropdownvalue = 0;
  var items = [0, 5, 7];

  double get perPerson {
    if (_peopleController.text == "") {
      return 0.0;
    }
    return acutalAmount / int.parse(_peopleController.text);
  }

  double get acutalAmount {
    if (_totalController.text == "") {
      return 0.0;
    }
    var total = int.parse(_totalController.text);
    return total + (total * dropdownvalue) / 100;
  }

  TextEditingController _peopleController = TextEditingController();
  TextEditingController _totalController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _peopleController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  icon: Icon(Icons.people), label: Text("No of People")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _totalController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  icon: Icon(Icons.attach_money), label: Text("Total Amount")),
            ),
          ),
          Row(
            children: [
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 46.0),
                child: Text("Tax percentage"),
              )),
              Expanded(
                  child: DropdownButton<int>(
                isExpanded: true,
                value: dropdownvalue,
                items: items.map((int items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Center(
                        child: Text(
                      items.toString(),
                      textAlign: TextAlign.center,
                    )),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  debugPrint(_totalController.text);
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text("$perPerson MMK per person"),
        ],
      ),
    );
  }
}
