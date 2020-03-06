import 'package:flutter/material.dart';
import 'acconutui.dart';
import 'databasehelper.dart';
import 'fadeAnimation.dart';
import 'main.dart';

class CreateCard extends StatefulWidget {
  final serveceSelected;
  final userid;
  CreateCard({this.serveceSelected, this.userid});

  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  TextEditingController _fullNamecontroller = TextEditingController();
  TextEditingController _areacontroller = TextEditingController();
  TextEditingController _phoneNumberdcontroller = TextEditingController();
  bool whatsapp = false;
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
        title: Text("انشاء بطاقة"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          
            child: ListView(
              physics: BouncingScrollPhysics(),

              
           
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Serveces(userid: widget.userid);
                            }));
                          },
                          child: Container(
                            child: Center(
                                child: Text(
                              "اختيار حرفة",
                              style: TextStyle(fontSize: 20),
                            )),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 30 / 100,
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
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      widget.serveceSelected == null
                          ? Text(
                              "....",
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff2C363F)),
                            )
                          : Text(widget.serveceSelected["job"],
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff2C363F)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BeautyTextfield(
                    textAlign: TextAlign.right,
                    controller: _fullNamecontroller,
                    width: double.maxFinite,
                    height: 60,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.text,

                    prefixIcon: Icon(Icons.person),
                    // suffixIcon: Icon(Icons.remove_red_eye),
                    placeholder: "الاسم الكامل",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BeautyTextfield(
                    textAlign: TextAlign.right,
                    controller: _areacontroller,
                    width: double.maxFinite,
                    height: 60,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.text,

                    prefixIcon: Icon(Icons.person),
                    // suffixIcon: Icon(Icons.remove_red_eye),
                    placeholder: "المكان او المنطقة",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BeautyTextfield(
                    textAlign: TextAlign.right,
                    controller: _phoneNumberdcontroller,
                    width: double.maxFinite,
                    height: 60,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.phone,
                    placeholder: "رقم الهاتف",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                      activeColor: Color(0xffE75A7C),
                      title: Text("تفعيل واتساب في البطاقة"),
                      value: whatsapp,
                      onChanged: (changestate) {
                        setState(() {
                          whatsapp = changestate;
                        });
                      }),
                ),
               
                _fullNamecontroller.text.isNotEmpty &&
                        _phoneNumberdcontroller.text.isNotEmpty &&
                        _areacontroller.text.isNotEmpty &&
                        widget.serveceSelected != null
                    ? Padding(
                      padding: const EdgeInsets.only(right:50,left:50),
                      child: FadeAnimation(
                                            1, GestureDetector(
                            onTap: () {
                              if (_fullNamecontroller != null &&
                                  _phoneNumberdcontroller != null &&
                                  _areacontroller != null &&
                                  widget.serveceSelected["id"] != null) {
                                database
                                    .usercardadd(
                                        widget.userid,
                                        widget.serveceSelected["id"],
                                        _fullNamecontroller.text,
                                        _areacontroller.text,
                                        whatsapp,
                                        _phoneNumberdcontroller.text)
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
                                "انشاء بطاقة جديدة",
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
                            )),
                      ),
                    )
                    :  FadeAnimation(
                                          1, Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.red,
                          child:
                          
                           Text(
                            "يرجى ملئ كافة الحقول لأضهار زر الأنشاء",
                            style: TextStyle(
                                 fontSize: 20),
                          ))),
                    ),
              ],
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

class Serveces extends StatefulWidget {
  final userid;
  Serveces({this.userid});
  DataBase database = DataBase();

  @override
  _ServecesState createState() => _ServecesState();
}

class _ServecesState extends State<Serveces> {
  String uri = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اختيار حرفة"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return CreateCard(
                    userid: widget.userid,
                  );
                }));
              })
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _search_in_body(),
            Expanded(
                child: FutureBuilder(
                    future: widget.database.jobslist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                           
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, int index) {
                              return snapshot.data[index].toString().contains(uri)? Padding(
                                padding: const EdgeInsets.all(12),
                                child: FadeAnimation(
                                  1,
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CreateCard(
                                            userid: widget.userid,
                                            serveceSelected:
                                                snapshot.data[index]);
                                      }));
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(25),
                                              )),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(-2, -1),
                                                  blurRadius: 5)
                                            ],
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50)),
                                            color: Colors.white,
                                          ),
                                          height: 90,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data[index]["job"],
                                                style: TextStyle(fontSize: 30),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(1000)),
                                            color: Color(0xff2C363F),
                                          ),
                                          height: 90,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ):SizedBox();
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }

  Widget _search_in_body() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: TextField(
          autofocus: false,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            // border: InputBorder.none,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffE75A7C),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "اضغط للبحث",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          maxLines: 1,
          onChanged: (String value) {
            setState(() {
              uri = value;
            });
          },
        ),
      ),
    );
  }
}
