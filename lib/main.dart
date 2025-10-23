import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List taskList = [];
  TextEditingController taskInputController = TextEditingController();

  late Map<String, dynamic> removedItem;
  late int removedItemIndex;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        taskList = (json.decode(data!));
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newTask = {};
      newTask["title"] = taskInputController.text;
      newTask["ok"] = false;
      taskList.add(newTask);
      taskInputController.clear();
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: taskInputController,
                      decoration: InputDecoration(
                        labelText: 'Task',
                        hintText: 'To study Flutter...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: _addToDo,
                      child: Text('ADD', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: sortItems,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: taskList.length,
                  itemBuilder: buildItem,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> sortItems()async{
    Future.delayed(Duration(seconds: 1));
    setState(() {
      taskList.sort((itemA,itemB){
        if(itemA['ok'] && !itemB['ok']) return -1;
        else if(!itemA['ok'] && itemB['ok']) return 1;
        else return 0;
      });
        _saveData();
    });
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime
          .now()
          .microsecondsSinceEpoch
          .toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          removedItemIndex = index;
          removedItem = taskList[index];
          taskList.removeAt(index);
        });
        _saveData();

        final snack = SnackBar(
          content: Text('Você removeu a tarefa \"${removedItem["title"]}\"!'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
              label: 'Desfazer', onPressed: (){
                setState(() {
                  taskList.insert(removedItemIndex, removedItem);
                  _saveData();
                });
          }),);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
      child: CheckboxListTile(
        activeColor: Colors.blueAccent,
        title: Text(taskList[index]["title"]),
        value: taskList[index]["ok"],
        secondary: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(
            taskList[index]["ok"] ? Icons.check : Icons.error,
            color: Colors.white,
          ),
        ),
        onChanged: (value) {
          setState(() {
            taskList[index]["ok"] = value;
            _saveData();
          });
        },
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(taskList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
