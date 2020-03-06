
import 'package:flutter/material.dart';
import 'package:herfaapp/addjob.dart';
import 'package:herfaapp/createcard.dart';
import 'package:herfaapp/databasehelper.dart';
import 'package:herfaapp/fadeAnimation.dart';
import 'package:herfaapp/herfalist.dart';
import 'package:herfaapp/info.dart';
import 'package:herfaapp/mycard.dart';
import 'package:herfaapp/profile.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'acconutui.dart';
import 'package:url_launcher/url_launcher.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          );
        },
        theme: ThemeData(
          primaryColor: Color(0xff2C363F),
            iconTheme: IconThemeData(color: Color(0xff2C363F)),
            textTheme: TextTheme(
                title: TextStyle(color: Color(0xffF2F5EA) ,fontFamily: "BoutrosNewsH1-Bold"),
                subtitle: TextStyle(color: Color(0xffF2F5EA),fontFamily: "BoutrosNewsH1-Bold"),
                body1: TextStyle(color: Color(0xffF2F5EA),fontFamily: "BoutrosNewsH1-Bold")),
            canvasColor: Color(0xffF2F5EA),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Color(0xff2C363F)),
                textTheme: TextTheme(
                    title: TextStyle(fontFamily: "BoutrosNewsH1-Bold",color: Color(0xff2C363F), fontSize: 23)))),
        home: Home(),
        routes: {
          "infopage": (context) => Info(),
          "account": (context)=>Account(),
          "home": (context)=>Home(),
          "createcard": (context)=>CreateCard(),
          "addjob":(context)=>CreateJob(),
           "addjob":(context)=>CreateJob(),
           "profile":(context)=>Profile()
          
         

        },
        );
        
  }
}

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String uri = "";
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


  DataBase database = DataBase() ;

dynamic cond   ;

   read() async {
    
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? "0";
   if(value != "0"){
    
     return value ;

   }
  }
  
@override
void initState() { 
  super.initState();
  read();


 

 
  
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Stack(
        children: <Widget>[
          Container(
          
        padding: EdgeInsets.only(top: 50, right: 10),
        
        width: MediaQuery.of(context).size.width / 3.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(700), bottomLeft: Radius.circular(700)),
          color: Colors.white,
        ),
      ),
          Container(
        padding: EdgeInsets.only(top: 50, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            



            DrawerItem(title: Icons.person,route: "profile",),
            DrawerItem(title: Icons.info,route: "infopage",),
            
          ],
        ),
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(800), bottomLeft: Radius.circular(800)),
          color: Color(0xff2C363F),
        ),
      ),

      
        ],
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: (){
            setState(() {
              database.usersCard();
              database.jobslist();
            });
          })
        ],
        
        title: Text("حرفة"),
        centerTitle: true,
       
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            child: FutureBuilder(
              future: database.jobslist(),
              builder: (context,snapshot){
              if(snapshot.hasData){

               
                return ListView.builder(
              physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Hero(
                      flightShuttleBuilder: (_,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext) {
                        return AnimatedBuilder(
                          animation: animation,
                          child: Stack(
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
                                    BorderRadius.only(topLeft: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              width: 120,
                            ),
                            Container(
                              child: Center(child: Text(snapshot.data[index]["job"])),
                              decoration: BoxDecoration(
                               
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(35)),
                                color: Color(0xffE75A7C),
                              ),
                              width: 120,
                            ),
                            
                          ],
                        ),
                          builder: (_, _child) {
                            return DefaultTextStyle.merge(
                              child: _child,
                              style: TextStyle.lerp(
                                  DefaultTextStyle.of(fromHeroContext).style,
                                  DefaultTextStyle.of(toHeroContext).style,
                                  flightDirection == HeroFlightDirection.pop
                                      ? 1 - animation.value
                                      : animation.value),
                            );
                          },
                        );
                      },
                      tag: "list$index",
                                          child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return HerfaList(snapshot.data[index]);

                          }));
                        },
                                            child: Stack(
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
                                    BorderRadius.only(topLeft: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              width: 120,
                            ),
                            Container(
                              child: Center(child: Text(snapshot.data[index]["job"])),
                              decoration: BoxDecoration(
                               
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(35)),
                                color: Color(0xffE75A7C),
                              ),
                              width: 120,
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  );
                });
              }else{
                return Center(child: Text("جار تحميل الحرف",style: TextStyle(color: Color(0xff2C363F)),),);
              }
            })
          ),

          _search_in_body(),
          Expanded(
            child: FutureBuilder(
              future: database.usersCard(),
              builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  var data = snapshot.data[index];
                  return snapshot.data.toString().contains(uri)? Padding(
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
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(50)),
                              color: Colors.white,
                            ),
                            height: 260,
                          ),
                          GestureDetector(
                             onTap: (){
                                             return _showDialog(snapshot.data[index]);
                                           },
                                                      child: Container(
                              padding: EdgeInsets.all(10),
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                // crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Color(0xffF2F5EA), fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      data["fullName"],
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 17),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "رقم الهاتف",
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 20),
                                    ),
                                    subtitle: SelectableText(
                                     data["phoneNumber"],
                                      style: TextStyle(
                                          color: Color(0xffF2F5EA), fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(1000)),
                                color: Color(0xff2C363F),
                              ),
                              height: 260,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ],
                      ),
                                         
                    ),
                  ):SizedBox(height: 0.0,);
                });

              }else{
                return Center(child: Container(
                  width: 80,
                  height: 50,
                  child: LiquidLinearProgressIndicator(
  value: 0.25, // Defaults to 0.5.
  valueColor: AlwaysStoppedAnimation(Colors.black), // Defaults to the current Theme's accentColor.
  backgroundColor: Colors.transparent, // Defaults to the current Theme's backgroundColor.
  borderColor: Color(0xffE75A7C),
  borderWidth: 2,
  borderRadius: 12.0,
  direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
  center: Text("جار التحميل ",style: TextStyle(color: Colors.black),),
),
                ));
              }
            })
          ),
        ],
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
}

class DrawerItem extends StatelessWidget {
  final title ; 
  final route ; 
  const DrawerItem({
    this.title,this.route,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: (){
          Navigator.pushNamed(context, route);
        },
              child: Center(
          child: Icon(title,color: Color(0xffF2F5EA),)
        ),
      ),
    );
  }
}




