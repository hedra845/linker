import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linker/home.dart';

class Notespage extends StatefulWidget {
  const Notespage({super.key});

  @override
  State<Notespage> createState() => _NotespageState();
}

class _NotespageState extends State<Notespage> {
  @override
    List<Map<String, String>> itemList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadList();
  }

  // Load list from SharedPreferences
  Future<void> _loadList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? linkerdList = prefs.getString('itemList_notes');

    if (linkerdList != null) {
      setState(() {
        itemList = List<Map<String, String>>.from(
          jsonDecode(linkerdList).map((item) => Map<String, String>.from(item)),
        );
      });
    } else if (linkerdList == null) {
      setState(() {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No list found')));
      });
    }
  }

  // Save list to SharedPreferences
  Future<void> _saveList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('itemList_notes', jsonEncode(itemList));
  }

  // Add new item to the list
  void _addItem() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        itemList.add({
          'title': titleController.text,
          'description': descriptionController.text,
        });
        titleController.clear();
        descriptionController.clear();
        _saveList(); // Save list after adding item
      });
    }
  }

  // Delete item from the list
  void _deleteItem(int index) {
    setState(() {
      itemList.removeAt(index);
      _saveList(); // Save after deletion
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Color(0xff3461FD).withAlpha(15),
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xff3461FD),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
              "Notes",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xff3461FD)),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Image.asset('assets/images/pngegg (7).png'),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          children: [   
            Expanded(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shadowColor: Color(0xff3461FD).withAlpha(70),
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        itemList[index]['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemList[index]['description']!),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => _deleteItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff3461FD),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.white,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Linker Save List ',
                            style: TextStyle(
                              color: Color(0xff3461FD),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Linker Save List is a service that allows you to easily save, manage, and organize link lists for quick access anytime. ',
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Color.fromARGB(255, 132, 155, 238),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: titleController,
                            cursorColor: Color(0xff3461FD),
                            decoration: InputDecoration(
                              fillColor: Color(0xffF5F9FE),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xffF5F9FE),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xffF5F9FE),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xff3461FD),
                                ),
                              ),
                              labelText: 'title',
                              labelStyle: TextStyle(color: Color(0xff3461FD)),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionController,
                            cursorColor: Color(0xff3461FD),
                            decoration: InputDecoration(
                              fillColor: Color(0xffF5F9FE),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xffF5F9FE),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xffF5F9FE),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xff3461FD),
                                ),
                              ),
                              labelText: 'description',
                              labelStyle: TextStyle(color: Color(0xff3461FD)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _addItem,
                                style: ButtonStyle(
                                  shadowColor: WidgetStateProperty.all<Color>(
                                    Color(0xff3461FD),
                                  ),
                                  shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                    Color(0xff3461FD),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Add item',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () => Navigator.pop(context),
                                style: ButtonStyle(
                                  shadowColor: WidgetStateProperty.all<Color>(
                                    Color(0xffF5F9FE),
                                  ),
                                  shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                    Color(0xffF5F9FE),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xff3461FD),
                                ),
                                label: const Text(
                                  'cancel',
                                  style: TextStyle(color: Color(0xff3461FD)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
