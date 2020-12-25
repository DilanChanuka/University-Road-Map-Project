

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:map_interfaces/Screens/Common/data.dart';

 String dataArray;
 Future<String> getjsonData(String url) async
  {
     // String a="https://my.api.mockaroo.com/my_saved_schema.json?key=8699f700";
     try
     {
        var data=await http.get(url);

        if(data.statusCode==200)
         {
           dataArray=data.body; 
           isjsonResponseOk=true;
         }
     
     }catch(error)
     {
        print(error);
     }
      
    
      return dataArray;
  }
