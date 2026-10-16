

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/communicator.dart';




class BuildTodo extends StatefulWidget {
  const BuildTodo(
    this.task,
    this.width1,
    this.id, {
    this.isCompleted = false,
    super.key,
  });

  final String task;
  final double width1;
  final String id;
  final bool isCompleted;

  @override
  State<BuildTodo> createState() => _BuildTodoState();
}

class _BuildTodoState extends State<BuildTodo> {
  late bool isDone = widget.isCompleted;

  @override
  void didUpdateWidget(covariant BuildTodo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCompleted != widget.isCompleted) {
      isDone = widget.isCompleted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 50),
          width: widget.width1,
          color: const Color.fromARGB(255, 40, 137, 255),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  widget.task,
                  style: GoogleFonts.amaticSc(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final delUrl =
                      'http://127.0.0.1:5000/delete?query=${widget.id}';
                  final delData = await fetchdata(delUrl);
                  print(delData);

                  final decoded = jsonDecode(delData) as Map<String, dynamic>;
                  if (decoded['tasks'] is! List) {
                    throw const FormatException(
                      'not a list',
                    );
                  }
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 60,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              if (!isDone)
                IconButton(
                  onPressed: () async {
                    final compUrl =
                        'http://127.0.0.1:5000/addcomp?query=${widget.task}';
                    await fetchdata(compUrl);

                    final delUrl =
                        'http://127.0.0.1:5000/delete?query=${widget.id}';
                    final delData = await fetchdata(delUrl);
                    final decoded = jsonDecode(delData) as Map<String, dynamic>;
                    if (decoded['tasks'] is! List) {
                      throw const FormatException(
                        'Expected the response "tasks" field to be a list.',
                      );
                    }

                    if (mounted) {
                      setState(() {
                        isDone = true;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.done,
                    size: 60,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> tasks = [];
  List<String> ids = [];
  List<String> completedTasks = [];
  List<String> completedIds = [];
  String url = '';
  var data;
  //var audio;
  String output = '';
  String audiooutput = '';
  var deco;
  var url1; 
  
  
  
  var dataL;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: const Color(0xFF6750A4),
    useMaterial3: true,
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF6750A4),
    useMaterial3: true,
  ),
  themeMode: ThemeMode.system,

      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 3, 42, 90),
                      Color.fromARGB(255, 8, 82, 173),
                      Color.fromARGB(255, 40, 137, 255),
                    ],
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final phrase = FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Be',
                            style: GoogleFonts.amaticSc(
                              fontSize: 150,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          const SizedBox(width: 30),
                          DefaultTextStyle(
                            style: GoogleFonts.amaticSc(
                              fontSize: 150,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 250, 6, 6),
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText('AWESOME'),
                                TyperAnimatedText('OPTIMISTIC'),
                                TyperAnimatedText('DIFFERENT'),
                              ],
                              pause: const Duration(milliseconds: 5000),
                            ),
                          ),
                        ],
                      ),
                    );
                    final image = Image.asset(
                      'assets/img.png',
                      fit: BoxFit.contain,
                    );

                    return SizedBox(
                      height: 750,
                      child: constraints.maxWidth >= 700
                          ? Row(
                              children: [
                                Expanded(flex: 3, child: phrase),
                                Expanded(flex: 2, child: image),
                              ],
                            )
                          : Column(
                              children: [
                                Expanded(child: phrase),
                                Expanded(child: image),
                              ],
                            ),
                    );
                  },
                ),
              ),

              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 50),
                        Text(
                          "Create your Todo List Right Away",
                          style: GoogleFonts.amaticSc(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 40, 137, 255),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: TextField(
                  cursorColor: const Color.fromARGB(255, 118, 118, 118),
                  //key: searchBarKey,
                  //controller: SearchController(),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 40, 137, 255),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 152, 152, 152),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintStyle: GoogleFonts.amaticSc(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 118, 118, 118),
                    ),
                    hintText: "What's on your mind today?",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onSubmitted: (value) async {
                    try {
                      //print("Before request");
                      url = 'http://127.0.0.1:5000/add?query=$value';
                      //url = 'http://127.0.0.1:5000/api?query=$value';
                      //url = 'http://127.0.0.1:5000/selection?query=$value';

                      data = await fetchdata(url);

                      print("After request");

                      print(data);

                      //ar decoded = jsonDecode(data);

                      //print("Decoded:");

                      //print(decoded);

                      setState(() {
                        //currentSong = decoded;
                        //searchResults = List<Map<String, dynamic>>.from(decoded);
                        //print(searchResults);
                      });
                      //print("RESULT COUNT = ${searchResults.length}");

                      //_showOverlay();
                    } catch (e, s) {
                      //print("ERROR:");
                      //print(e);

                      //print("STACK:");
                      //print(s);
                    }
                  },
                ),
              ),

              SizedBox(height: 50),

              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                        
                          style: ElevatedButton.styleFrom(
                          
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Makes the button rectangular
                            ),
                            backgroundColor:
                                Colors.blue, // Button background color
                            foregroundColor: Colors.white, // Text color
                          ),
                          onPressed: () async {
                            print('Button Pressed');
                            url1 = 'http://127.0.0.1:5000/todos';
                            dataL = await fetchdata(url1);
                            print(dataL);


                            final decoded =
                                jsonDecode(dataL) as Map<String, dynamic>;
                            final rawTasks = decoded['tasks'];
                            final rawIds = decoded['ids'];
                            if (rawTasks is! List || rawIds is! List) {
                              throw const FormatException(
                                'not liist',
                              );
                            }
                            if (rawTasks.length != rawIds.length) {
                              throw const FormatException(
                                'same length.',
                              );
                            }

                            

                            //var searchResults = List<Map<String, dynamic>>.from(deco);
                            

                            print('-------------------------------------');
                            //print(searchResults);
                            //print(dataL);
                            //for (int i = 0; i < deco['tasks'].length; i++) print(deco['tasks'][i]);
                            print('-------------------------------------');


                            const compUrl =
                                'http://127.0.0.1:5000/comptodos';
                            final compData = await fetchdata(compUrl);
                            final compDecoded =
                                jsonDecode(compData) as Map<String, dynamic>;
                            final compRawTasks = compDecoded['comptasks'];
                            final compRawIds = compDecoded['ids'];
                            if (compRawTasks is! List || compRawIds is! List) {
                              throw const FormatException(
                                'not liist',
                              );
                            }
                            if (compRawTasks.length != compRawIds.length) {
                              throw const FormatException(
                                'same length',
                              );
                            }


                            setState(() {
                              tasks = rawTasks
                                  .map((task) => task.toString())
                                  .toList();
                              ids = rawIds.map((id) => id.toString()).toList();
                              completedTasks = compRawTasks
                                  .map((task) => task.toString())
                                  .toList();
                              completedIds =
                                  compRawIds.map((id) => id.toString()).toList();
                            });
                            



                            

                          },
                          child: Text('Load Tasks', style: GoogleFonts.amaticSc(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),),
                        ),
                        




                      ],
                    ),
                  ),
                  SizedBox(height:20),

                  
                  for (var i = 0; i < tasks.length; i++)
                    BuildTodo(
                      tasks[i],
                      MediaQuery.of(context).size.width * 0.85,
                      ids[i],
                      key: ValueKey(ids[i]),
                    ),
                  for (var i = 0; i < completedTasks.length; i++)
                    BuildTodo(
                      completedTasks[i],
                      MediaQuery.of(context).size.width * 0.85,
                      completedIds[i],
                      isCompleted: true,
                      key: ValueKey(completedIds[i]),
                    ),
               
                  
                  









                ],





              ),
            ],
          ),
        ),
      ),
    );
  }
}
