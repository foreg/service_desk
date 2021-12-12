import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:service_desk/core/api_manager.dart';
import 'dart:io';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  static const routeName = 'add_request';

  @override
  State<RequestPage> createState() => _MyRequestPageState();
}

class _MyRequestPageState extends State<RequestPage> {
  List<Map<String, String>> addressOptions = [];
  List<Map<String, String>> roomOptions = [];

  List<XFile> imageFiles = [];

  String? addressId;
  String? roomId;

  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  Future<void> getBuildingData() async {
    var res = await APIManager().building();

    setState(() {
      addressOptions = res;
    });
  }

  Future<void> getRoomData() async {
    print(addressId);
    var res = await APIManager().rooms();

    setState(() {
      roomOptions = res;
    });
  }

  Future<void> _showChoiceImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Выбор источника"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text("Галерея"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text("Камера"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getBuildingData();
  }

  _openGallary(BuildContext context) async {
    var images = await ImagePicker().pickMultiImage();

    setState(() {
      if (images != null) {
        for (final image in images) {
          imageFiles.add(image);
        }
      }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        imageFiles.add(image);
      }
    });
    Navigator.of(context).pop();
  }

  Widget _buildGridView() {
    if (imageFiles.isNotEmpty) {
      return Container(
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8, crossAxisSpacing: 8, crossAxisCount: 4),
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {
                setState(() {
                  imageFiles.removeAt(index);
                });
              },
              child: Image.file(
                File(imageFiles[index].path),
                fit: BoxFit.cover,
              ),
            ),
            itemCount: imageFiles.length,
          ));
    }
    return const Center(
      child: Text("Нет фото"),
    );
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
            value: addressId,
            isExpanded: true,
            hint: const Text('Корпус'),
            icon: const Icon(Icons.arrow_drop_down_outlined),
            onChanged: (newValue) {
              setState(() {
                addressId = newValue!;
                getRoomData();
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
          DropdownButton<String>(
            value: roomId,
            isExpanded: true,
            hint: const Text('Аудитория'),
            icon: const Icon(Icons.arrow_drop_down_outlined),
            onChanged: (newValue) {
              setState(() {
                roomId = newValue!;
              });
            },
            items: roomOptions.map((Map<String, String> item) {
              return DropdownMenuItem(
                child: Text(item['room_title'] as String),
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
          ElevatedButton(
              onPressed: () {
                _showChoiceImage(context);
              },
              child: const Text("Добавить фото")),
          // const Padding(padding: EdgeInsets.all(8.0)),
          _buildGridView(),
          ElevatedButton(
              onPressed: () {
                APIManager().createRequest(
                    addressId as String,
                    roomId as String,
                    _titleController.text,
                    _textController.text,
                    imageFiles);
                Navigator.of(context).pop();
              },
              child: const Text("Создать заявку")),
        ]));
  }
}
