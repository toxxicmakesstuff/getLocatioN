import 'package:flutter/material.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({Key? key}) : super(key: key);

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  List<Map<String, dynamic>> users = [
    {"name": "Prashant", "number": "9844773750"},
    {"name": "Mummy", "number": "9847118906"},
    {"name": "Baba", "number": "9847043419"},
  ];
  TextEditingController fullnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // ignore: sized_box_for_whitespace
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 400,
                color: Colors.pink,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, index) => ListTile(
                    title: Text(users[index]["name"]),
                    subtitle: Text(users[index]["number"]),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.phone),
                    onTap: () {},
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: fullnameController,
                      keyboardType: TextInputType.text,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          labelText: "Name", hintText: "John Hanks"),
                    ),
                    TextFormField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          labelText: "Number", hintText: "9876543210"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> newMap = {
                            "name": fullnameController.text,
                            "number": numberController.text
                          };
                          setState(() {
                            users.add(newMap);
                          });
                          fullnameController.clear();
                          numberController.clear();
                        },
                        child: const Text("Save Contact"))
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
