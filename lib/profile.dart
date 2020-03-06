import 'package:flutter/material.dart';
import 'package:herfaapp/acconutui.dart';
import 'package:herfaapp/addjob.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'createcard.dart';
import 'databasehelper.dart';
import 'fadeAnimation.dart';
import 'mycard.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? "0";
    if (value == "0") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Account();
      }));
    }
  }

  DataBase database = DataBase();
  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("ملفك الشخصي"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: database.me(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.details,
                              size: 80,
                            )),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(
                              "اسم الحساب",
                              style: TextStyle(
                                  color: Color(0xff2C363F), fontSize: 20),
                            ),
                            subtitle: Text(
                              snapshot.data["username"].toString(),
                              style: TextStyle(
                                  color: Color(0xff2C363F), fontSize: 17),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(
                              "البريد الالكتروني",
                              style: TextStyle(
                                  color: Color(0xff2C363F), fontSize: 20),
                            ),
                            subtitle: Text(
                              snapshot.data["email"].toString(),
                              style: TextStyle(
                                  color: Color(0xff2C363F), fontSize: 17),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(
                              "الصلاحية",
                              style: TextStyle(
                                  color: Color(0xff2C363F), fontSize: 20),
                            ),
                            subtitle: Text(
                              snapshot.data["is_staff"] ? "مسؤول" : "عضو",
                              style: TextStyle(
                                  color: Color(0xff2C363F), fontSize: 17),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0xff2C363F),
                          indent: 5,
                          endIndent: 60,
                        ),
                        snapshot.data["is_superuser"]
                            ? DrawerItem2(
                                title: "جميع المستخدمين",
                                route: AllUsers(),
                              )
                            : SizedBox(
                                height: 0.0,
                              ),
                        snapshot.data["is_staff"]
                            ? DrawerItem2(
                                title: "اضافة حرفة",
                                route: CreateJob(),
                              )
                            : SizedBox(
                                height: 0.0,
                              ),
                        DrawerItem2(
                          title: "بطاقاتي",
                          route: MyCard(snapshot.data["id"],snapshot.data["username"]),
                        ),
                        DrawerItem2(
                          title: "انشاء بطاقة جديدة",
                          route: CreateCard(
                            userid: snapshot.data["id"],
                          ),
                        ),
                        LogOutItem(
                          title: "تسجيل خروج ",
                          route: "home",
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final title;
  final route;
  const DrawerItem({
    this.title,
    this.route,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, color: Color(0xff2C363F)),
          ),
        ),
      ),
    );
  }
}

class LogOutItem extends StatefulWidget {
  final title;
  final route;
  const LogOutItem({
    this.title,
    this.route,
    Key key,
  }) : super(key: key);

  @override
  _LogOutItemState createState() => _LogOutItemState();
}

class _LogOutItemState extends State<LogOutItem> {
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        child: RaisedButton(
          color: Colors.red,
          onPressed: () {
            _save("0");
            Navigator.pushReplacementNamed(context, widget.route);
          },
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem2 extends StatelessWidget {
  final title;
  final route;
  const DrawerItem2({
    this.title,
    this.route,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: OutlineButton(
          highlightedBorderColor: Colors.white,
          highlightColor: Color(0xffE75A7C),
          borderSide: BorderSide(color: Color(0xffE75A7C), width: 3),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return route;
            }));
          },
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Color(0xff2C363F)),
            ),
          ),
        ),
      ),
    );
  }
}

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  DataBase database = DataBase();
  String uri = "";
  int userlen = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("جميع المستخدمين"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
           
            Expanded(
                child: FutureBuilder(
                    future: database.allusers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        
                        
                        return Column(
                          children: <Widget>[
                            Text(snapshot.data.length.toString(),style:TextStyle(color: Colors.black) ,),
                             _search_in_body(),
                            Expanded(
                                                          child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, int index) {
                                    return snapshot.data[index]
                                            .toString()
                                            .contains(uri)
                                        ? Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: FadeAnimation(
                                              1,
                                              GestureDetector(

                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    25),
                                                          )),
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.black26,
                                                              offset: Offset(-2, -1),
                                                              blurRadius: 5)
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                        50)),
                                                        color: Colors.white,
                                                      ),
                                                      height: 300,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            snapshot.data[index]
                                                                ["username"],
                                                            style: TextStyle(
                                                                fontSize: 30),
                                                          ),
                                                          Text(
                                                            snapshot.data[index]
                                                                ["email"],
                                                            style: TextStyle(
                                                                fontSize: 17),
                                                          ),
                                                          Divider(
                                                            color: Colors.white,
                                                          ),
                                                          ListTile(
                                                            title: Text("is staff",style: TextStyle(color: Colors.white),),
                                                            subtitle: Text(snapshot.data[index]["is_staff"].toString(),style: TextStyle(color: Colors.white),),
                                                          ),
                                                          ListTile(
                                                            title: Text("is superuser",style: TextStyle(color: Colors.white),),
                                                            subtitle: Text(snapshot.data[index]["is_superuser"].toString(),style: TextStyle(color: Colors.white),),
                                                          ),

                                                          RaisedButton(
                                                            onPressed: (){

                                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                                return MyCard(snapshot.data[index]["id"],snapshot.data[index]["username"]);
                                                              }));

                                                            },
                                                            child: Text("البطاقات"),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                        200)),
                                                        color: Color(0xff2C363F),
                                                      ),
                                                      height: 300,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox();
                                  }),
                            ),
                          ],
                        );
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
