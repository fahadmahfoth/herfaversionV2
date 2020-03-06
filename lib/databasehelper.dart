import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataBase {

  String _url = "http://fahadmahfoth.pythonanywhere.com";

      bool addcard ;

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


   var status;
  Future<List> loginData(String username, String password) async {
    String myUrl = "http://fahadmahfoth.pythonanywhere.com/auth/token/login";
    try {
      await http.post(myUrl, body: {
        "password": "$password",
        "username": "$username",
      }).then((response) {
        status = response.statusCode == HttpStatus.ok;
        
        if (status) {
          var data = json.decode(response.body);
          print(response.body);
          _save(data["auth_token"]);
        } else {
          status = false;
        }
      });
    } catch (e) {
      print(e);
      status = false;
    }
  }

    Future<List> rigesterData(String username,String email, String password) async {
    String myUrl = "http://fahadmahfoth.pythonanywhere.com/auth/users/";
    try {
      await http.post(myUrl, body: {
        "password": "$password",
        "username": "$username",
        "email":    "$email"
      }).then((response) {
        status = response.statusCode == HttpStatus.created;
        
        if (status) {
          var data = json.decode(response.body);
          print(response.body);
          return data ;
        } else {
          status = false;
        }
      });
    } catch (e) {
      print(e);
      status = false;
    }
  }

  Future usersCard({userid, jobid}) async {
    userid ?? "";
    jobid ?? "";

    try {
      final response = await http.get(
          userid == null && jobid == null
              ? "http://fahadmahfoth.pythonanywhere.com/api/users/"
              : userid == null
                  ? "http://fahadmahfoth.pythonanywhere.com/api/users/?job=$jobid"
                  : jobid == null
                      ? "http://fahadmahfoth.pythonanywhere.com/api/users/?job=$jobid"
                      : "http://fahadmahfoth.pythonanywhere.com/api/users/?user=$userid&job=$jobid",
          headers: {});

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        //  print(result);
        return result;
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }

  Future usersCardbyuserid({userid}) async {
    try {
      final response = await http.get(
          "http://fahadmahfoth.pythonanywhere.com/api/users/?user=$userid",
          headers: {});

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        //  print(result);
        return result;
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }

  Future jobslist({userid, jobid}) async {
    try {
      final response =
          await http.get("http://fahadmahfoth.pythonanywhere.com/api/job/", headers: {});

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        //  print(result);
        return result;
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }

    Future deletecard({id}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      final response =
          await http.delete("http://fahadmahfoth.pythonanywhere.com/api/users/$id/",headers: {"Authorization": " Token $value"},);
          
        print(response.statusCode);
  
        
        var result = jsonDecode(response.body);
        print(result);
        return result;
      
    } catch (e) {
      print("Error delete Data .. SOON");
    }
  }

  

  Future<List> usercardadd(int userid, int jobid, String fullname, String area,
   
      bool whatsapp, String phoneNumber) async {

         final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myUrl = "http://fahadmahfoth.pythonanywhere.com/api/users/";
    try {
      await http.post(myUrl,headers: {"Authorization": " Token $value"}, body: {
    "user": userid.toString(),
    "fullName": "$fullname",
    "phoneNumber": "$phoneNumber",
    "area": "$area",
    "job": jobid.toString(),
    "whatsApp": whatsapp.toString()
      }).then((response) {
        addcard = response.statusCode == HttpStatus.created;
        print(response.body);

        return addcard ;

       
        
      });
    } catch (e) {
      print(e);
      status = false;
    }
  }




    Future<List> jobadd(job) async {

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myUrl = "http://fahadmahfoth.pythonanywhere.com/api/job/";
    try {
      await http.post(myUrl,headers: {"Authorization": " Token $value"}, body: {

    "job": job,

      }).then((response) {
        addcard = response.statusCode == HttpStatus.created;
        print(response.body);

        return addcard ;

       
        
      });
    } catch (e) {
      print(e);
      status = false;
    }
  }

  Future me() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print(value);
    try {
      final response = await http.get(
          "http://fahadmahfoth.pythonanywhere.com/auth/users/me/",
          headers: {"Authorization": " Token $value"});

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        print(result);
        return result;
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }

    Future allusers() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print(value);
    try {
      final response = await http.get(
          "http://fahadmahfoth.pythonanywhere.com/auth/users/",
          headers: {"Authorization": " Token $value"});

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        print(result);
        return result;
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }




}
