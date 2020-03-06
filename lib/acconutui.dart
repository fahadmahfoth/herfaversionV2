import 'package:flutter/material.dart';
import 'package:herfaapp/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:beauty_textfield/beauty_textfield.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 100,
              right: 30,
              child: Text(
                "حرفة",
                style: TextStyle(color: Color(0xff2C363F), fontSize: 70),
              ),
            ),
            Positioned(
                top: 50,
                left: 5,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            Positioned(
              top: 210,
              right: 30,
              child: Text(
                "سجل الان وأحصل على بطاقتك مجاناً",
                style: TextStyle(color: Color(0xff2C363F), fontSize: 20),
              ),
            ),
            Center(
                child: Icon(
              Icons.details,
              size: 60,
            )),
            Padding(
              padding: EdgeInsets.only(bottom: 125),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Hero(
                      flightShuttleBuilder: (_,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext) {
                        return AnimatedBuilder(
                          animation: animation,
                          child: Container(
                            child: Center(
                                child: Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                  color: Color(0xffE75A7C), fontSize: 23),
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
                                color: Color(0xffF2F5EA),
                                border: Border.all(
                                    color: Color(0xffE75A7C), width: 2)),
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
                      tag: "login",
                      transitionOnUserGestures: true,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LogIn();
                          }));
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "تسجيل دخول",
                            style: TextStyle(
                                color: Color(0xffE75A7C), fontSize: 23),
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
                              color: Color(0xffF2F5EA),
                              border: Border.all(
                                  color: Color(0xffE75A7C), width: 2)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Hero(
                      flightShuttleBuilder: (_,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext) {
                        return AnimatedBuilder(
                          animation: animation,
                          child: Container(
                            child: Center(
                                child: Text(
                              "انشاء حساب",
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
                      tag: "register",
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Register();
                          }));
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "انشاء حساب",
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
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogIn extends StatelessWidget {
  TextEditingController _usernamecontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();

  DataBase database = DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("تسجيل"),
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
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Center(
                  child: Icon(
                Icons.details,
                size: 80,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BeautyTextfield(
                  textAlign: TextAlign.left,
                  controller: _usernamecontroller,
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  prefixIcon: Icon(Icons.person),
                  placeholder: "username",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BeautyTextfield(
                  textAlign: TextAlign.left,
                  controller: _passwordcontroller,
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  placeholder: "password",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50),
                child: Hero(
                  tag: "login",
                  transitionOnUserGestures: true,
                  child: GestureDetector(
                    onTap: () {
                      print(_usernamecontroller.text);
                      print(_passwordcontroller.text);
                      database
                          .loginData(_usernamecontroller.text,
                              _passwordcontroller.text)
                          .whenComplete(() {
                        print(database.status);
                        if (database.status) {
                          Navigator.pushReplacementNamed(context, "home");
                        }
                        if (!database.status) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: <Widget>[
                                    OutlineButton(
                                      highlightedBorderColor: Colors.red,
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "اغلاق",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                  title: Text(
                                    "خطأ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content:
                                      Text("تاكد من ادخال بيانات بشكل صحيح"),
                                );
                              });
                        }
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "تسجيل دخول",
                          style:
                              TextStyle(color: Color(0xffE75A7C), fontSize: 23),
                        ),
                      ),
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
                          color: Color(0xffF2F5EA),
                          border:
                              Border.all(color: Color(0xffE75A7C), width: 2)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Register extends StatelessWidget {
  TextEditingController _usernamecontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();
  TextEditingController _emailcontroller    = new TextEditingController();

DataBase database = DataBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("تسجيل"),
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
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Center(
                  child: Icon(
                Icons.details,
                size: 60,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BeautyTextfield(
                  textAlign: TextAlign.left,
                  controller: _usernamecontroller,
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  prefixIcon: Icon(Icons.person),
                  placeholder: "username",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BeautyTextfield(
                  textAlign: TextAlign.left,
                  controller: _emailcontroller,
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  prefixIcon: Icon(Icons.person),
                  placeholder: "email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BeautyTextfield(
                  textAlign: TextAlign.left,
                  controller: _passwordcontroller,
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  placeholder: "password",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50),
                child: Hero(
                  tag: "register",
                  transitionOnUserGestures: true,
                  child: GestureDetector(
                       onTap: () {
                      print(_usernamecontroller.text);
                      print(_passwordcontroller.text);
                      database
                          .rigesterData(_usernamecontroller.text,
                          _emailcontroller.text,
                          
                              _passwordcontroller.text)
                          .whenComplete(() {
                        print(database.status);
                        if (database.status) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: <Widget>[
                                    OutlineButton(
                                      highlightedBorderColor: Colors.green,
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 2),
                                      color: Colors.red,
                                      onPressed: () {
                                        database.loginData(_usernamecontroller.text, _passwordcontroller.text);
                                        Navigator.pushReplacementNamed(context,"home");
                                      },
                                      child: Text(
                                        "الرئيسية",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                   
                                  ],
                                  title: Text(
                                    "!رائع",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content:
                                      Text("تم انشاء الحساب"),
                                );
                              });
                        }
                        if (!database.status) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: <Widget>[
                                    OutlineButton(
                                      highlightedBorderColor: Colors.red,
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "اغلاق",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                  title: Text(
                                    "خطأ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content:
                                      Text("تاكد من اتصالك بالانترنت ,وكتابة المعلومات بشكل صحيح , يجب كتابة كلمة سر قوية"),
                                );
                              });
                        }
                      });
                    },
                      child: Container(
                        child: Center(
                            child: Text(
                          "انشاء حساب",
                          style: TextStyle(fontSize: 23),
                        )),
                        height: 90,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BeautyTextfield extends StatefulWidget {
  final BorderRadius cornerRadius;
  final double width, height, wordSpacing;
  final Color backgroundColor, accentColor, textColor;
  final String placeholder, fontFamily;
  final Icon prefixIcon, suffixIcon;
  final TextInputType inputType;
  final EdgeInsets margin;
  final Duration duration;
  final VoidCallback onClickSuffix;
  final TextBaseline textBaseline;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow;
  final FocusNode focusNode;
  final int maxLength, minLines, maxLines;
  final ValueChanged<String> onChanged, onSubmitted;
  final GestureTapCallback onTap;
  final TextEditingController controller;
  final TextAlign textAlign;

  const BeautyTextfield(
      {@required this.width,
      @required this.textAlign,
      @required this.controller,
      @required this.height,
      this.prefixIcon,
      @required this.inputType,
      this.suffixIcon,
      this.duration = const Duration(milliseconds: 500),
      this.margin = const EdgeInsets.all(10),
      this.obscureText = false,
      this.backgroundColor = const Color(0xff2C363F),
      this.cornerRadius = const BorderRadius.all(Radius.circular(10)),
      this.textColor = const Color(0xffE75A7C),
      this.accentColor = Colors.white,
      this.placeholder = "Placeholder",
      this.isShadow = true,
      this.onClickSuffix,
      this.wordSpacing,
      this.textBaseline,
      this.fontFamily,
      this.fontStyle,
      this.fontWeight,
      this.autofocus = false,
      this.autocorrect = false,
      this.focusNode,
      this.enabled = true,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.onChanged,
      this.onTap,
      this.onSubmitted})
      : assert(width != null),
        assert(height != null),
        assert(inputType != null);

  @override
  _BeautyTextfieldState createState() => _BeautyTextfieldState();
}

class _BeautyTextfieldState extends State<BeautyTextfield> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          boxShadow: widget.isShadow
              ? [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]
              : BoxShadow(spreadRadius: 0, blurRadius: 0),
          borderRadius: widget.cornerRadius,
          color: widget.suffixIcon == null
              ? isFocus ? widget.accentColor : widget.backgroundColor
              : widget.backgroundColor),
      child: Stack(
        children: <Widget>[
          widget.suffixIcon == null
              ? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    width: isFocus ? 500 : 40,
                    height: isFocus ? widget.height : 40,
                    margin: EdgeInsets.only(right: isFocus ? 0 : 7),
                    duration: widget.duration,
                    decoration: BoxDecoration(
                      borderRadius: isFocus
                          ? widget.cornerRadius
                          : BorderRadius.all(Radius.circular(60)),
                      color: widget.accentColor,
                    ),
                  ),
                ),
          widget.suffixIcon == null
              ? Container()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isFocus ? isFocus = false : isFocus = true;
                      if (widget.onClickSuffix != null) {
                        widget.onClickSuffix();
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      widget.suffixIcon.icon,
                      color: widget.textColor,
                    ),
                  ),
                ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Expanded(
                //   flex: 1,
                //   // child: Icon(
                //   //   widget.prefixIcon.icon,
                //   //   color:
                //   //       isFocus ? widget.backgroundColor : widget.accentColor,
                //   // ),
                // ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(right: 50, top: 3),
                    child: TextField(
                      controller: widget.controller,
                      cursorWidth: 2,
                      obscureText: widget.obscureText,
                      keyboardType: widget.inputType,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        fontStyle: widget.fontStyle,
                        fontWeight: widget.fontWeight,
                        wordSpacing: widget.wordSpacing,
                        textBaseline: widget.textBaseline,
                        fontSize: 18,
                        letterSpacing: 2,
                        color: widget.textColor,
                      ),
                      autofocus: widget.autofocus,
                      autocorrect: widget.autocorrect,
                      focusNode: widget.focusNode,
                      enabled: widget.enabled,
                      maxLength: widget.maxLength,
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      onChanged: widget.onChanged,
                      textAlign: widget.textAlign,
                      onTap: () {
                        setState(() {
                          isFocus = true;
                        });
                        if (widget.onTap != null) {
                          widget.onTap();
                        }
                      },
                      onSubmitted: (t) {
                        setState(() {
                          isFocus = false;
                        });
                        widget.onSubmitted(t);
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: widget.textColor),
                          hintText: widget.placeholder,
                          border: InputBorder.none),
                      cursorColor:
                          isFocus ? widget.accentColor : widget.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      duration: widget.duration,
    );
  }
}
