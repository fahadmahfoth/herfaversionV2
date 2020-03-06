import 'package:flutter/material.dart';
import 'package:herfaapp/main.dart';

import 'acconutui.dart';
import 'databasehelper.dart';
import 'fadeAnimation.dart';



class CreateJob extends StatefulWidget {



  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateJob> {
  TextEditingController _jobcontroller = TextEditingController();


  DataBase database = DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("اضافة حرفة"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 125),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BeautyTextfield(
                    textAlign: TextAlign.right,
                    controller: _jobcontroller,
                    width: double.maxFinite,
                    height: 60,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.text,

                    prefixIcon: Icon(Icons.person),
                    // suffixIcon: Icon(Icons.remove_red_eye),
                    placeholder: "اسم الحرفة",
                  ),
                ),
               
               
               
                    GestureDetector(
                          onTap: () {
                            if (_jobcontroller.text.isNotEmpty) {
                              database
                                  .jobadd(_jobcontroller.text)
                                   
                                  .then((r) {});
                              print(database.addcard);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Home();
                              }));
                            } else {
                              return _showDialog(
                                  "خطاء", "تأكد من اكمال البيانات");
                            }
                          },
                          child: Container(
                            child: Center(
                                child: Text(
                              "انشاء حرفة جديدة",
                              style: TextStyle(fontSize: 23),
                            )),
                            height: 90,
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(-2, -1),
                                    blurRadius: 5)
                              ],
                              borderRadius: BorderRadius.circular(1000),
                              color: Color(0xffE75A7C),
                            ),
                          ))
                    
                   
                    
              ],
            ),
          ),
        ),
      ),
    );
  }

void _showDialog(
    String title,
    String body,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: new Text(
              body,
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              new OutlineButton(
                child: new Text(
                  'اغلاق',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  


}
