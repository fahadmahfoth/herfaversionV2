import 'package:flutter/material.dart';
import 'package:herfaapp/databasehelper.dart';

import 'fadeAnimation.dart';

class MyCard extends StatefulWidget {
  final index;
  final username ;
  MyCard(this.index,this.username);
  @override
  _HerfaListState createState() => _HerfaListState();
}

class _HerfaListState extends State<MyCard> {
  DataBase database = DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("بطاقات  ${widget.username}"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
           IconButton(icon: Icon(Icons.refresh), onPressed: (){
            setState(() {
              database.usersCard();
              
            });
          }),
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
          child: FutureBuilder(
              future: database.usersCardbyuserid(userid: widget.index),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: FadeAnimation(
                            1,
                            Stack(
                              children: <Widget>[
                                Container(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: IconButton(
                                          icon: Icon(Icons.delete_forever,
                                              size: 40, color: Colors.red),
                                          onPressed: () {
                                            database.deletecard(id: snapshot.data[index]["id"]);
                                            setState(() {
                                              database.usersCardbyuserid(userid: widget.index);
                                            });
                                            
                                            
                                            
                                            }
                                         
                                        ),
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
                                  height: 400,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                       snapshot.data[index]["jobName"],
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
                                           snapshot.data[index]["fullName"],
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
                                          snapshot.data[index]["phoneNumber"],
                                          style: TextStyle(
                                              color: Color(0xffF2F5EA),
                                              fontSize: 17),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          "المنطقة",
                                          style: TextStyle(
                                              color: Color(0xffF2F5EA),
                                              fontSize: 20),
                                        ),
                                        subtitle: SelectableText(
                                          snapshot.data[index]["area"],
                                          style: TextStyle(
                                              color: Color(0xffF2F5EA),
                                              fontSize: 17),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          "تاريخ اضافة البطاقة",
                                          style: TextStyle(
                                              color: Color(0xffF2F5EA),
                                              fontSize: 20),
                                        ),
                                        subtitle: SelectableText(
                                          snapshot.data[index]["date"],
                                          style: TextStyle(
                                              color: Color(0xffF2F5EA),
                                              fontSize: 17),
                                        ),
                                      ),
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
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
