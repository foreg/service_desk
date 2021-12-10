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

  final _titleController = TextEditingController();
  final _textController = TextEditingController();

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
        body: ListView(padding: const EdgeInsets.all(16), children: <Widget>[
          const SizedBox(height: 30),
          DropdownButton<String>(
            value: address,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down_outlined),
            onChanged: (newValue) {
              setState(() {
                address = newValue!;
              });
            },
            items: addressOptions.map((Map<String, String> item) {
              return DropdownMenuItem(
                child: Text(item['adres'] as String),
                value: item['id'].toString(),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _titleController,
            // onChanged: _onChanged,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Тема заявки'),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _textController,
            // onChanged: _onChanged,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Описание проблемы'),
          ),
          const SizedBox(height: 30),
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
