
import 'package:flutter/material.dart';

List<String> placesList=["Your Location","Lecture's Room","Instructor's Room","Computer Lab 01","Mini-auditorium",
"CS Head's room","Conference Room","Record Room","Special Lab","Computer lab 02","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Car park","Wash Rooms (CS)","Computer Lab 03",
"Lecture Hall 01","Server Room" ,"Main Gate","Y Junction","Library Junction","Library","Scenes Auditorium",
"Art Cantin","Auditorium","Student's Well fair branch","Maths Department",
"Computer Science Department" ,"Scenes faculty Cantin","Science Dean office","Botany Department",
"Zoology Department","Faculty of fisharies","Maths Lecture hall 1","Maths Lecture hall 2","Physics Department",
"Chemistry Department","Medical Center","Student Common room","Student reading place"];

List<String> searchPlaces=["Lecture's Room","Instructor's Room","Computer Lab 01","Mini-auditorium",
"CS Head's room","Conference Room","Record Room","Special Lab","Computer lab 02","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Car park","Wash Rooms (CS)","Computer Lab 03",
"Lecture Hall 01","Server Room" ,"Main Gate","Y Junction","Library Junction","Library","Scenes Auditorium",
"Art Cantin","Auditorium","Student's Well fair branch","Maths Department",
"Computer Science Department" ,"Scenes faculty Cantin","Science Dean office","Botany Department",
"Zoology Department","Faculty of fisharies","Maths Lecture hall 1","Maths Lecture hall 2","Physics Department",
"Chemistry Department","Medical Center","Student Common room","Student reading place"];


const String GOOGL_KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
final placeNameSelect = TextEditingController();

Map<String,int> departmentID={"Computer Science":1,"Zoology":2,"Chemistry":3,"Botany":4,"Physics":5,"Mathematics":6};
List<String> department=["Computer Science","Zoology","Chemistry","Botany","Physics","Mathematics"];
List<String> floor=["Ground floor","First floor","Second floor"];
String floorvalue  = "Ground floor"; //default floor value
String departmentvalue ="Computer Science";  //default department value
 

List<String> outSideplaces=["Main Gate","Y Junction","Library Junction","Library","Scenes Auditorium",
"Art Cantin","Auditorium","Student's Well fair branch","Maths Department",
"Computer Science Department" ,"Scenes faculty Cantin","Science Dean office","Botany Department",
"Zoology Department","Faculty of fisharies","Maths Lecture hall 1","Maths Lecture hall 2","Physics Department",
"Chemistry Department","Medical Center","Student Common room","Student reading place"];

List<String> inSidePlces=["Lecture's Room","Instructor's Room","Computer Lab 01","Mini-auditorium",
"CS Head's room","Conference Room","Record Room","Special Lab","Computer lab 02","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Car park","Wash Rooms (CS)","Computer Lab 03","Server Room"];

List<String> ground_floor=["Car park","Wash Rooms (CS)","Computer Lab 01","Main Gate","Library","Scenes Library","Scenes Auditorium",
"Scenes Cantin","Art Cantin","Auditorium"];

List<String> first_floor=["Lecture's Room","Instructor's Room","Computer Lab 02",
"CS Head's room","Conference Room","Record Room","Special Lab","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Lecture Hall 01"];

List<String> second_floor=["Mini-auditorium","Computer Lab 03","Server Room"];



String port=" https://localhost:44342/API";
List<int> groundFloor=[14,16,15,16,19,20,22,23,24,27,28];
List<int> firstFloor=[1,2,9,7,8,10,13,6,5,11,12,17];
List<int> secondFloor=[18,16,4];


//Color
const routeColor=Color.fromARGB(255,40,122,198);
const floorColor=Color.fromARGB(255,100,12,198);
const stairColor=Colors.red;

//width
const int routeWidth=8;
const int floorWidth=5;
const int stairWidth=8;

const MAX_FLOOR=3;
const GROUND_FLOOR=0;
const FIRST_FLOOR=1;
const SECOND_FLOOOR=2;

/*
  01-Lecture's Room               
  02-Instructor's Room            
  03-Computer Lab 01              
  04-Mini-auditorium              
  05-Head's room                  
  06-Conference Room              
  07-Record Room                 
  08-Special Lab                  
  09-Computer lab 02
  10-E-Learning Center
  11-Special Room
  12-Demostrator's Room
  13-Main-auditorium
  14-Car park
  15-Wash Rooms (CS)
  16-Computer Lab 03
  17-Lecture Hall 01
  18-Server Room
  19-Car park 
  20-Wash Rooms (CS)
  21-Computer Lab 01
  22-Main Gate
  23-Library
  24-Scenes Library
  25-Scenes Auditorium
  26-Scenes Cantin
  27-Art Cantin
  28-Auditorium
*/