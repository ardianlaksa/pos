// screen_b.dart
import 'dart:convert';

import 'package:POS/card_picture.dart';
import 'package:POS/dio_upload_service.dart';
import 'package:POS/http_upload_service.dart';
import 'package:POS/images_api.dart';
import 'package:POS/take_photo.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'images.dart';

class ScreenB extends StatefulWidget {
  ScreenB({Key key}) : super(key: key);

  @override
  _ScreenBState createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {

  final HttpUploadService _httpUploadService = HttpUploadService();
  final DioUploadService _dioUploadService = DioUploadService();
  CameraDescription _cameraDescription;
  List<String> _images = [];
  List<Images> imagesList = new List<Images>();

  void getCharactersfromApi() async {
    ImagesApi.getImages().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        imagesList = list.map((model) => Images.fromJson(model)).toList();
      });
    });
  }

  Future<void> getCharactersfromApi1() async {
    ImagesApi.getImages().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        imagesList = list.map((model) => Images.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      final camera = cameras
          .where((camera) => camera.lensDirection == CameraLensDirection.back)
          .toList()
          .first;
      setState(() {
        _cameraDescription = camera;
      });
    }).catchError((err) {
      print(err);
    });
    getCharactersfromApi();
  }


  Future<void> presentAlert(BuildContext context,
      {String title = '', String message = '', Function() ok}) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text('$title'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text('$message'),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  // style: greenText,
                ),
                onPressed: ok != null ? ok : Navigator
                    .of(context)
                    .pop,
              ),
            ],
          );
        });
  }

  void presentLoader(BuildContext context,
      {String text = 'Aguarde...',
        bool barrierDismissible = false,
        bool willPop = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async {
              return willPop;
            },
            child: AlertDialog(
              content: Container(
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //In logical pixels
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              children: [
                Text('Send least two pictures',
                    style: TextStyle(fontSize: 17.0)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: height * 0.3,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CardPicture(
                          onTap: () async {
                            final String imagePath =
                            await Navigator.of(context)
                                .push(MaterialPageRoute(
                                builder: (_) =>
                                    TakePhoto(
                                      camera: _cameraDescription,
                                    )));

                            print('imagepath: $imagePath');
                            if (imagePath != null) {
                              setState(() {
                                _images.add(imagePath);
                              });
                            }
                          },
                        ),
                        // CardPicture(),
                        // CardPicture(),
                      ] +
                          _images
                              .map((String path) =>
                              CardPicture(
                                imagePath: path,
                              ))
                              .toList()),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.indigo,
                                  gradient: LinearGradient(colors: [
                                    Colors.indigo,
                                    Colors.indigo.shade800
                                  ]),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(3.0))),
                              child: RawMaterialButton(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                onPressed: () async {
                                  // show loader
                                  // presentLoader(context, text: 'Wait...');

                                  // calling with dio
                                  var responseDataDio =
                                  await _dioUploadService.uploadPhotos(_images);

                                  // calling with http
                                  // var responseDataHttp = await _httpUploadService
                                  //     .uploadPhotos(_images);

                                  // hide loader
                                  // Navigator.of(context).pop();

                                  // showing alert dialogs
                                  // await presentAlert(context,
                                  //     title: 'Success Dio',
                                  //     message: responseDataDio.toString());
                                  // await presentAlert(context,
                                  //     title: 'Success HTTP',
                                  //     message: responseDataHttp);
                                  await getCharactersfromApi1();
                                },
                                child: Center(
                                    child: Text(
                                      'SEND',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )),
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: height * 0.325,
                  child: ListView.builder(
                      itemCount: imagesList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                                onTap: () {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(imagesList[index].type + ' pressed!'),
                                  ));
                                },
                                title: Text(imagesList[index].file),
                                subtitle: Text(imagesList[index].size),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "http://deenha.id/coba_flutter/upload/"+imagesList[index].file)),
                                ));
                      }),
                )
              ],
            ),
          ),
        ));
  }
}