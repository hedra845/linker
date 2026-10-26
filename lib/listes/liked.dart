import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linker/home.dart';
import 'package:linker/listes/favorite.dart';
import 'package:linker/listes/following.dart';
import 'package:linker/listes/interested.dart';
import 'package:linker/listes/loved.dart';
import 'package:linker/notes.dart';

class Likedpage extends StatefulWidget {
  const Likedpage({super.key});

  @override
  State<Likedpage> createState() => _LikedpageState();
}

class _LikedpageState extends State<Likedpage> {
  @override
  final List<Map<String, dynamic>> items = [
    {"title": "All", "icon": Icons.all_inbox, "id": 0},
    {"title": "liked", "icon": Icons.lightbulb_rounded, "id": 1},
    {"title": "following", "icon": Icons.follow_the_signs, "id": 2},
    {"title": "loved", "icon": Icons.favorite, "id": 3},
    {"title": "favorite", "icon": Icons.face, "id": 4},
    {"title": "interested", "icon": Icons.label_rounded, "id": 5},
  ];

  String? name;
  List<Map<String, String>> itemList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadName();
    _loadList();
  }

  // Load list from SharedPreferences
  Future<void> _loadList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? linkerdList = prefs.getString('itemList_liked');
    final String? name = prefs.getString('name');

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
    await prefs.setString('itemList_liked', jsonEncode(itemList));
  }

  // Add new item to the list
  void _addItem() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        linkController.text.isNotEmpty) {
      setState(() {
        itemList.add({
          'title': titleController.text,
          'description': descriptionController.text,
          'link': linkController.text,
        });
        titleController.clear();
        descriptionController.clear();
        linkController.clear();
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

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "No name found";
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
              Icons.description_outlined,
              color: Color(0xff3461FD),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Notespage()),
              );
            },
          ),
        ],
        title: Text(
                "liked",
                style: const TextStyle(color: Colors.black),
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
            SizedBox(
              height: 60,
              child: Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                       onTap: () {
                        if (items[index]['id'] == 0) {
                          setState(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          });
                        } else if (items[index]['id'] == 1) {
                          setState(() {
                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Likedpage(),
                              ),
                            );
                          });
                        } else if (items[index]['id'] == 2) {
                          setState(() {
                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Followingpage(),
                              ),
                            );
                          });
                        } else if (items[index]['id'] == 3) {
                          setState(() {
                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Lovedpage(),
                              ),
                            );
                          });
                        } else if (items[index]['id'] == 4) {
                          setState(() {
                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Favoritepage(),
                              ),
                            );
                          });
                        } else if (items[index]['id'] == 5) {
                          setState(() {
                             Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Interestedpage(),
                              ),
                            );
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Color(0xff3461FD).withAlpha(70)),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Color(0xffF5F9FE)),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                items[index]['icon']!,
                                color: Color(0xff3461FD),
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                items[index]['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
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
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: itemList[index]['link']!),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Color(0xff3461FD),
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0xffffffff),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'link copied',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Flexible(
                              child: Row(
                                children: [
                                  Icon(Icons.link, color: Color(0xff3461FD)),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      itemList[index]['link']!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xff3461FD),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                          SizedBox(height: 10),
                          TextFormField(
                            controller: linkController,
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
                              labelText: 'link',
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
