import 'package:flutter/material.dart';
import 'package:service_desk/core/api_manager.dart';
import "dart:io";

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  static const routeName = 'add_request';

  @override
  State<RequestPage> createState() => _MyRequestPageState();
}

class _MyRequestPageState extends State<RequestPage> {
  List<Map<String, String>> addressOptions = [];
  String address = "1";

  Future<String> getBuildingData() async {
    var res = await APIManager().building();

    setState(() {
      addressOptions = res;
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getBuildingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Создание заявки'),
        ),
        body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          Center(
            child: DropdownButton<String>(
              value: address,
              icon: const Icon(Icons.arrow_downward),
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (newValue) {
                setState(() {
                  address = newValue!;
                });
              },
              items: addressOptions.map((Map<String, String> item) {
                return DropdownMenuItem(
                  child: Text(item['building_title'] as String),
                  value: item['id'].toString(),
                );
              }).toList(),
            ),
          )
        ]));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
