import 'package:flashie/services/auth.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final searchController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool newset = false;
  List<dynamic> topics = [];
  List<dynamic> filteredTopics = [];

  @override
  void initState() {
    super.initState();
    loadSets();
  }

  Future<void> loadSets() async {
    try {
      final result = await AuthService.fetchSets();
  
      if (!mounted) return;
      setState(() {
        topics = result;
        filteredTopics = result;
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void searchSet(String query) {
    final result = topics.where((set) {
      final title = set['title'].toString().toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredTopics = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          TextField(
            controller: searchController,
            onChanged: searchSet,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 74, 88, 96),
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.white70,
              suffixIconColor: Colors.white70,
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                },
                icon: Icon(Icons.clear),
              ),
              hintText: "Search your sets...",
              hintMaxLines: 1,
              hintStyle: TextStyle(color: Colors.white60),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          // SizedBox(height: 14),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              child: ListView.builder(
                itemCount: filteredTopics.length,
                itemBuilder: (context, index) {
                  final topic = filteredTopics[index];
                  return SizedBox(
                    width: 70,
                    child: ListTile(
                      title: Text(
                        topic['title']!,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Text(
                        topic['description']!,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                try {
                                  await AuthService.deleteSet(id: topic["id"]);
                                  filteredTopics.removeAt(index);
                                  loadSets();
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Set deleted successfully",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.redAccent,
                            ),
                            // SizedBox(width: 20),
                            // Icon(Icons.edit_note),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          newset = false;
                        });
                        Navigator.pushNamed(
                          context,
                          "/cards",
                          arguments: {
                            "id": topic["id"],
                            "title": topic["title"],
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          if (newset)
            Container(
              width: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      focusColor: Colors.white30,
                      labelText: "Set Titile",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      focusColor: Colors.white30,
                      labelText: "Set Description",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (!newset) {
            setState(() {
              newset = true;
            });
            return;
          }
          final title = titleController.text.trim();
          final description = descriptionController.text.trim();
          if (title.isEmpty || description.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Fill the requied field",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
            return;
          }
          try {
            await AuthService.addSet(
              title: title,
              description: description,
              // userId: user_id!,
            );
            if (!mounted) return;
            titleController.clear();
            descriptionController.clear();
            setState(() {
              newset = false;
            });
            await loadSets();
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Set added successfully')),
            );
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
        backgroundColor: Colors.blueAccent,
        label: Text(
          newset ? "Submit" : "Add New Set",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
