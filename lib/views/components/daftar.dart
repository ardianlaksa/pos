import 'dart:convert';
import 'package:POS/landing_page.dart';
import 'package:POS/sign_up.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(Daftar());
}

class Daftar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyDaftar(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyDaftar extends StatefulWidget {
  MyDaftar({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyDaftarState createState() => _MyDaftarState();
}

class _MyDaftarState extends State<MyDaftar> {

  final String serverPos = "http://sipanji.id:8080/pdrd/Android/AndroidJsonPOS/";

  String kodeAktivasi = '9134';
  String sUuid = 'uuid';
  String versiApp = '1.0';

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  SharedPreferences _preferences;
  static const String sPrefKeyUsername = 'username';
  static const String sPrefKeyPassword = 'password';
  static const String sPrefKeyIdPengguna = 'idPengguna';
  static const String sPrefKeyUuid = 'uuid';
  static const String sPrefKeyIdTempatUsaha = 'idTempatUsaha';
  String username = '';
  String password = '';
  TextEditingController userController;
  TextEditingController passController;

  @override
  void initState(){
    super.initState();
    userController = new TextEditingController();
    passController = new TextEditingController();
    SharedPreferences.getInstance().then((pref) {
      setState(() => this._preferences = pref);
    });
    var uuid = Uuid();
    sUuid = uuid.v1();
  }

  Future<void> _setPreferences(String val) async {
    try {
      // print('$val');
      var a = jsonDecode(val)['ID_PENGGUNA'];
      var b = jsonDecode(val)['ID_TEMPAT_USAHA'];
      // print(a);
      // var idPengguna = jsonResult1['ID_PENGGUNA'];
      // var idTempatUsaha = jsonResult1['ID_TEMPAT_USAHA'];

      // print('$idPengguna $idTempatUsaha');
      await this._preferences.setString(sPrefKeyUsername, username);
      await this._preferences.setString(sPrefKeyPassword, password);
      await this._preferences.setString(sPrefKeyIdPengguna, a);
      await this._preferences.setString(sPrefKeyUuid, sUuid);
      await this._preferences.setString(sPrefKeyIdTempatUsaha, b);

      _completeLogin();
    } catch (e) {
      print('_setPreferences : $e');
    }
  }

  void _completeLogin() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LandingPage(),
      ),
    );
  }

  void _toSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => SignUpWidget(),
      ),
    );
  }

  void _loadPreferences(){
    setState(() {
      this.username = this._preferences?.getString(sPrefKeyIdPengguna);
      this.password = this._preferences?.getString(sPrefKeyIdTempatUsaha);
      this.userController.text = this.username;
      this.passController.text = this.password;
    });
  }

  void _postNetwork(){
    this.username = this.userController.text;
    this.password = this.passController.text;
    _httpGet(this.username,this.password,this.kodeAktivasi,this.sUuid,this.versiApp);
  }

  Future<void> _httpPost(String username, String password
      , String kodeAktivasi, String uuid, String versiApp) async {
    try{

      var formData = FormData.fromMap({
        'username': username,
        'password': password,
        'kode_aktivasi': kodeAktivasi,
        'UUID': uuid,
        'versiApp': versiApp,
        // 'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
        // 'files': [
        //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
        //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
        // ]
      });
      var response = await Dio().post('${serverPos}Auth', data: formData);

      if(response.statusCode == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(response.data.toString()),
        // ));
        print(response.data.toString());
        var jsonResult = jsonDecode(response.data)['result'];
        List<dynamic> list = List<dynamic>.from(jsonResult);
        var a = jsonEncode(list[1]);
        // print(a);
        _setPreferences(a);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('else : $response'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('_httpPost : $e'),
      ));
    }
  }

  Future<void> _httpGet(String username, String password
      , String kodeAktivasi, String uuid, String versiApp) async {
    try{
      var body = {
          'username': username,
          'password': password,
          'kode_aktivasi': kodeAktivasi,
          'UUID': uuid,
          'versiApp': versiApp
        };
      var response = await Dio().post('${serverPos}Auth', data: FormData.fromMap(body));

      if(response.statusCode == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(response.data.toString()),
        // ));
        print(response.data.toString());
        var jsonResult = jsonDecode(response.data)['result'];
        List<dynamic> list = List<dynamic>.from(jsonResult);
        var a = jsonEncode(list[1]);
        // print(a);
        _setPreferences(a);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('else : $response'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('_httpGet : $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: const Center(
                child: Text(
                  "dribblee",
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children:  <Widget>[
                      TextField(
                        controller: userController,
                        onChanged: (text) {
                          print('First text field: $text');
                        },
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade100 )),
                            labelText: "User",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),

                      ),
                      TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                            labelText: "Re-type Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),

                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () => _postNetwork(),
                              child: const Center(
                                child: Text(
                                  "DAFTAR",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFB226B2),
                                    Color(0xFFFF4891)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
