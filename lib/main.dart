import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Working with files. Read & Write.',
      home: MyHomePage(title: 'Working with files'),
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
  final TextEditingController _textController = TextEditingController();

  static const String kLocalFileName = 'demo_localfile.txt';
  String _localFileContent = '';
  String _localFilePath = kLocalFileName;

  // при запуске приложения сначала пробуем получить файл и прочитать его
  @override
  void initState() {
    super.initState();
    // считываем инфу из файла
    this._readTextFromLocalFile();
    // получаем полный путь к файлу, для отображения на экране
    this
        ._getLocalFile
        .then((file) => setState(() => this._localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local file read/write Demo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          const Text('Write to local file:', style: TextStyle(fontSize: 20)),
          TextField(
              focusNode: textFieldFocusNode,
              controller: _textController,
              maxLines: null,
              style: const TextStyle(fontSize: 20)),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                child: const Text('Load', style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  // считываем инфу из файла
                  this._readTextFromLocalFile();
                  // и выводим инфу в TextField
                  this._textController.text = this._localFileContent;
                  // установим фокус на TextField
                  FocusScope.of(context).requestFocus(textFieldFocusNode);
                  // выведем в консоль лог об успешной загрузке
                  log('String successfuly loaded local file. Всё загрузилось.');
                },
              ),
              MaterialButton(
                child: const Text('Save', style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  await this._writeTextToLocalFile(this._textController.text);
                  this._textController.clear();
                  await this._readTextFromLocalFile();
                  log('String successfuly written to local file. Всё записалось.');
                },
              ),
            ],
          ),
          const Divider(height: 20.0),
          Text('Local file path:',
              style: Theme.of(context).textTheme.headline6),
          Text(this._localFilePath,
              style: Theme.of(context).textTheme.subtitle1),
          const Divider(height: 20.0),
          Text('Local file content:',
              style: Theme.of(context).textTheme.headline6),
          Text(this._localFileContent,
              style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }

  // с помощью метода 'getApplicationDocumentsDirectory()' получим путь до каталога документов
  Future<String> get _getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // получим ссылку на "местоположение нашего файла"
  Future<File> get _getLocalFile async {
    final path = await _getLocalPath;
    return File('$path/$kLocalFileName');
  }

  // метод записывает в файл "некоторую" информацию
  Future<File> _writeTextToLocalFile(String text) async {
    final file = await _getLocalFile;
    return file.writeAsString(text);
  }

  // метод для чтения данных из файла
  Future _readTextFromLocalFile() async {
    String content;
    try {
      final file = await _getLocalFile;
      content = await file.readAsString();
    } catch (e) {
      content = 'Error loading local file: $e';
    }

    setState(() {
      this._localFileContent = content;
    });
  }
}
