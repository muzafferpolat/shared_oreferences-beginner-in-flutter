import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(ReferansUygulamam());

class ReferansUygulamam extends StatefulWidget {
  @override
  _ReferansUygulamamState createState() => _ReferansUygulamamState();
}

class _ReferansUygulamamState extends State<ReferansUygulamam> {
  String isim;
  int id;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SharedPreferences mySharedPreferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
        .then((value) => mySharedPreferences = value);
  }

  @override
  void dispose() {
    (mySharedPreferences as State).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Referans'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (deger) {
                        isim = deger;
                      },
                      decoration: InputDecoration(
                        labelText: "İsim",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (deger) {
                        id = int.parse(deger);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "İd",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text("Kaydet"),
                    onPressed: _ekle,
                  ),
                  RaisedButton(
                    color: Colors.yellow,
                    child: Text("Göster"),
                    onPressed: _goster,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _ekle() async {
    formKey.currentState.save();
    await mySharedPreferences.setString("MyName", isim);
    await mySharedPreferences.setInt("MyId", id);
  }

  void _goster() async {
    await debugPrint(mySharedPreferences.getString("MyName"));
    await debugPrint(mySharedPreferences.getInt("MyId").toString());
  }
}
