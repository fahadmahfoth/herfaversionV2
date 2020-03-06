import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'databasehelper.dart';
import 'fadeAnimation.dart';

class HerfaList extends StatefulWidget {
  final index;
  HerfaList(this.index);
  @override
  _HerfaListState createState() => _HerfaListState();
}

class _HerfaListState extends State<HerfaList> {
   message_func(String phoneNumber) async {
    print("messaging now ........");
    String url = "sms:$phoneNumber";
//
    try {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        print("i cant message the $url");
      }
    } catch (e) {
      print(e.toString());
    }
  }

   whats_func(String phoneNumber) async {
    print("whats app now ........");
    String url = "whatsapp://send?phone=$phoneNumber";
//
    try {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        print("i cant whats the $url");
      }
    } catch (e) {
      print(e.toString());
    }
  }


  call_func(String phoneNumber) async {
    print("calling now ........");
    String url = "tel:$phoneNumber";
//
    try {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        print("i cant call the $url");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String uri = "";
  DataBase database = DataBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index["job"].toString()),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Hero(
        tag: widget.index,
        child: Container(
          child: Column(
            children: <Widget>[
              _search_in_body(),
              Expanded(
                  child: FutureBuilder(
                      future: database.usersCard(jobid: widget.index["id"]),
                      builder: (context, snapshot) {
                        print(widget.index);
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, int index) {
                                var data = snapshot.data[index];

                              return   snapshot.data.toString().contains(uri)?
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: FadeAnimation(
                                    1,
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(25),
                                                child: Icon(
                                                  Icons.details,
                                                      size: 40,
                                                      color:
                                                          Colors.greenAccent),
                                                
                                                
                                              )
                                              ),
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
                                          height: 260,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: GestureDetector(
                                             onTap: (){
                                             return _showDialog(snapshot.data[index]);
                                           },
                                                                                      child: ListView(
                                              physics: BouncingScrollPhysics(),
                                              children: <Widget>[
                                                Text(
                                                  data["jobName"],
                                                  style: TextStyle(fontSize: 35),
                                                ),
                                                Divider(
                                                  color: Color(0xffD6DBD2),
                                                  indent: 5,
                                                  endIndent: 120,
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    "الاسم",
                                                    style: TextStyle(
                                                        color: Color(0xffF2F5EA),
                                                        fontSize: 20),
                                                  ),
                                                  subtitle: Text(
                                                    data["fullName"],
                                                    style: TextStyle(
                                                        color: Color(0xffF2F5EA),
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    "رقم الهاتف",
                                                    style: TextStyle(
                                                        color: Color(0xffF2F5EA),
                                                        fontSize: 20),
                                                  ),
                                                  subtitle: SelectableText(
                                                    data["phoneNumber"],
                                                    style: TextStyle(
                                                        color: Color(0xffF2F5EA),
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                
                                              ],
                                              
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(1000)),
                                            color: Color(0xff2C363F),
                                          ),
                                          height: 260,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ],

                                    ),
                                  ),
                                ):SizedBox(height: 0.0,);
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
      ),
    );
  }

  
 void _showDialog(data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
           
            

            backgroundColor: Colors.transparent,
            
            content: FadeAnimation(
                          1, Stack(
                          children: <Widget>[
                            Container(
                             
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(-2, -1),
                                      blurRadius: 5)
                                ],
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(50)),
                                color: Colors.white,
                              ),
                              height: 400,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data["jobName"],
                                    style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 35),
                                  ),
                                  Divider(
                                    color: Color(0xffD6DBD2),
                                    indent: 5,
                                    endIndent: 120,
                                  ),
                                  ListTile(
                                    title: Text(
                                      "الاسم",
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 17),
                                    ),
                                    subtitle: Text(
                                      data["fullName"],
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 22),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "رقم الهاتف",
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 17),
                                    ),
                                    subtitle: SelectableText(
                                     data["phoneNumber"],
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 22),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "المنطقة",
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 17),
                                    ),
                                    subtitle: SelectableText(
                                     data["area"],
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 22),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "تاريخ اضافة البطاقة",
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 17),
                                    ),
                                    subtitle: SelectableText(
                                     data["date"],
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 22),
                                    ),
                                  )

                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(1000)),
                                    
                                color: Color(0xff2C363F),
                              ),
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ],
                        ),
            ),
            title: new IconButton(
                
                icon: Icon(Icons.close,color: Colors.red,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            actions: <Widget>[

             data["whatsApp"]? new OutlineButton(
                highlightedBorderColor: Colors.green,
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3

                ),
                child: new Text(
                  'واتساب',
                  style: TextStyle(
                                        color: Colors.green, fontSize: 20),
                ),
                onPressed: () => whats_func(data["phoneNumber"])
                  
                
              ):null,

               new OutlineButton(
                highlightedBorderColor: Colors.greenAccent,
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3

                ),
                child: new Text(
                  'اتصال',
                  style: TextStyle(
                                        color: Colors.greenAccent, fontSize: 20),
                ),
                onPressed: () => call_func(data["phoneNumber"])
                  
                
              ),
               new OutlineButton(
                highlightedBorderColor: Colors.yellowAccent,
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3

                ),
                child: new Text(
                  'رسالة',
                  style: TextStyle(
                                        color: Colors.yellow, fontSize: 20),
                ),
                onPressed: () => message_func(data["phoneNumber"])
                  
                
              ),
              

             
            ],
          );
        });
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
