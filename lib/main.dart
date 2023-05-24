import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // DateFormat('yyyy-MM-dd') 표시를 위한 dependencies
import 'package:date_counter/container_box.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BirthdayApp(),
    );
  }
}

class BirthdayApp extends StatefulWidget {
  @override
  State<BirthdayApp> createState() => _BirthdayAppState();
}

class _BirthdayAppState extends State<BirthdayApp> {
  final _focusNode = FocusNode();
  final TextEditingController _dayController = TextEditingController();
  String _resultText0 = '';
  String _resultText100 = '';
  String _resultText200 = '';
  String _resultText300 = '';
  String _resultText365 = '';

  void calculateResult() {
    setState(() {
      try {
        final enteredDate = DateTime.parse(_dayController.text);
        final calculatedDate0 =
            enteredDate.add(const Duration(days: 0)).toLocal();
        final calculatedDate100 =
            enteredDate.add(const Duration(days: 100)).toLocal();
        final calculatedDate200 =
            enteredDate.add(const Duration(days: 200)).toLocal();
        final calculatedDate300 =
            enteredDate.add(const Duration(days: 300)).toLocal();
        final calculatedDate365 =
            enteredDate.add(const Duration(days: 365)).toLocal();

        final dateFormat = DateFormat('yyyy-MM-dd');
        _resultText0 = 'The day we met: ${dateFormat.format(calculatedDate0)}';
        _resultText100 = '100 days: ${dateFormat.format(calculatedDate100)}';
        _resultText200 = '200 days: ${dateFormat.format(calculatedDate200)}';
        _resultText300 = '300 days: ${dateFormat.format(calculatedDate300)}';
        _resultText365 = '365 days: ${dateFormat.format(calculatedDate365)}';

        _dayController.clear();
      } catch (e) {
        _resultText0 = 'Invalid date format';
        _resultText100 = 'Invalid date format';
        _resultText200 = 'Invalid date format';
        _resultText300 = 'Invalid date format';
        _resultText365 = 'Invalid date format';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print('TextField on foucs');
      } else {
        print('TextField lost focus');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('우리가 만난날'),
        leading: Builder(
          builder: (context) {
            //build method의 build Context가 아니라 Builder 위젯의 BuildContext를 사용하도록 Builder위젯을 쓴다.
            return IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                setState(() {
                  Scaffold.of(context).openDrawer();
                });
              },
            );
          },
        ),
        actions: <Widget>[
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.save_rounded)),
              IconButton(
                icon: Icon(Icons.power_settings_new),
                tooltip: 'power off the app',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Turn off"),
                      content: Text("Would you like to exit?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Mori'),
              accountEmail: Text('test@test.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text('menu1'),
              leading: Icon(Icons.radio_button_on),
              onTap: () {},
            ),
            ListTile(
              title: Text('menu2'),
              leading: Icon(Icons.radio_button_on),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
            Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Today is',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.now().toLocal()), // DateFormat을 변경해줌

                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 72,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter the day',
                  hintText: 'yyyy-mm-dd',
                ),
                focusNode: _focusNode,
                controller: _dayController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  calculateResult();
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            TextBox(text: _resultText0),
            SizedBox(height: 8),
            TextBox(text: _resultText100),
            SizedBox(height: 8),
            TextBox(text: _resultText200),
            SizedBox(height: 8),
            TextBox(text: _resultText300),
            SizedBox(height: 8),
            TextBox(text: _resultText365),
            SizedBox(
              height: 56,
            ),
            ElevatedButton(
              onPressed: calculateResult,
              child: Text('Calculate'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
