import 'package:flutter/material.dart';

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
            style: const TextStyle(fontSize: 20)
          ),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                child: const Text('Load', style: TextStyle(fontSize: 20)),
                onPressed: () {},
              ),
              MaterialButton(
                child: const Text('Save', style: TextStyle(fontSize: 20)),
                onPressed: () {},
              ),
            ],
          ),
          const Divider(height: 20.0),
          Text('Local file path:', style: Theme.of(context).textTheme.headline6),
          Text('demo_localfile.txt', style: Theme.of(context).textTheme.subtitle1),
          const Divider(height: 20.0),
          Text('Local file content:', style: Theme.of(context).textTheme.headline6),
          Text('Content', style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }
}
