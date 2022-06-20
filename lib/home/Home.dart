import 'dart:io';
import 'package:flutter/material.dart';
import 'package:capstone_design_2022_spring/resources.dart';
import 'package:image_picker/image_picker.dart';
import 'Search.dart';
import 'recipeSearch.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late File _image;
  late List _results;
  bool imageSelect=false;

  @override
  void initState()
  {
    super.initState();
    loadModel();
  }

  Future loadModel()
  async {
    Tflite.close();
    String res;
    res=(await Tflite.loadModel(model: "assets/model0620-1.tflite",labels: "assets/labels0620-1.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image)
  async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 49,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results=recognitions!;
      _image=image;
      imageSelect=true;
      print(_results);
      for (int i = 0; i < _results.length; i++){
        ingredients.add(_results[i]['label']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8,5,8,5),
                child: search()
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
          flexibleSpace: Container(
              decoration: myGradient
          ),
        ),
      body: ListView(
        children: [
          (imageSelect)?Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image),
          ):Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: const Opacity(
                  opacity: 0.8,
                  child: Center(
                    child: Text("식재료 사진을 업로드해주세요.", style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              light, dark
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: ElevatedButton(
                        onPressed: captureImage,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              light, dark
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: ElevatedButton(
                        onPressed: (){
                          pickImage();
                          },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Icon(
                          Icons.photo_camera_back,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect)?_results.map((result) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${result['label']}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
              }).toList():[],
            ),
          ),
          (imageSelect)?Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          light, dark
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return recipeSearch();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('레시피 검색하기', style: TextStyle(fontSize: 20),),
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ):SizedBox()
        ],
      ),
    );
  }
  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);
    imageClassification(image);
  }

  Future captureImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image=File(pickedFile!.path);
    imageClassification(image);
  }
}

