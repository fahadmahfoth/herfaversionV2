import 'package:flutter/material.dart';


class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حول التطبيق"),
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
      body: Container(
      
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Align(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/codeforiraq.png")
                                
                                )
                              ),
                            ),
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
                          height: MediaQuery.of(context).size.height,
                        ),
                       
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "حرفة",
                                style: TextStyle(fontSize: 35),
                              ),
                              Divider(
                               color: Color(0xffE75A7C),
                               thickness: 15,

                                indent: 5,
                                endIndent: 290,
                              ),
                              SizedBox(height: 80,),
                              ListTile(
                                title: Text(
                                  "حول",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffF2F5EA), fontSize: 20),
                                ),
                                subtitle: Text(
                                  """تطبيق مجاني يتيح لك البحث عن الحرفي الذي تريده والاتصال به ومعرفة مكانه ويمكنك ايضا التسجل للحصول على بطاقتك الخاصة في التطبيق مجاناً
                                  """,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Color(0xffF2F5EA), fontSize: 17),
                                ),
                              ),
                               Divider(
                                    color: Color(0xffE75A7C),
                                    thickness: 10,

                                indent: 90,
                                endIndent: 90,
                              ),
                              SizedBox(height: 40,),
                              ListTile(
                                title: Text(
                                  "المبرمجين",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffF2F5EA), fontSize: 20),
                                ),
                                subtitle: Text(
                                  "فهد محفوظ محمد",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Color(0xffF2F5EA), fontSize: 17),
                                ),
                              ),
                              SizedBox(height: 40,),
                               Divider(
                                    color: Color(0xffE75A7C),
                                    thickness: 5,

                                indent: 90,
                                endIndent: 90,
                              ),
                              SizedBox(height: 9),
                              Center(child: SelectableText("info@codeforiraq.org")),
                              Center(child: SelectableText("fahad187mahfoth@yahoo.com"))
                              
                              
                             
                            ],
                          ),
                          decoration: BoxDecoration(
                            
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(290)),
                            color: Color(0xff2C363F),
                          ),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                         Container(
                           height: 90,
                           child: Align(
                             alignment: Alignment.bottomCenter,
                             child: Text(""),
                           ),
                          
                              decoration: BoxDecoration(
                                image: DecorationImage(

                                  image: AssetImage("assets/codeforiraq.png")
                                
                                )
                              ),
                        
                          
                        ),
                      ],
                    ),)

          ],
        ),
      ),
    );
  }
}