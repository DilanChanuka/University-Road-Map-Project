
import 'package:flutter/material.dart';

List<String> walkoutUserLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
];
final walkoutUserLocselect = TextEditingController();
String walkoutUserLocselected = "";

List<String> walkoutDestiLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 01",
  "CS Mini-auditorium",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS Computer lab 02",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS Wash Rooms",
  "CS Computer Lab 03",
  "CS Car park",
  "Lecture Hall 01"
];
final walkoutDestiLocselect = TextEditingController();
String walkoutDestiLocselected = "";

List<String> vehicleoutUserLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Scienes faculty Canteen",
  "Botany Department Car Park",
  "Zoology Department Car Park",
  "Chemistry Department Car Park",
  "Physics Department Car Park",
  "Medical Center Car Park",
  "Library Car Park",
  "Maths Department Car Park",
  "CS Car park",
  "Faculty of fisharies",
  "Medical Center",
];
final vehicleoutUserLocselect = TextEditingController();
String vehicleoutUserLocselected = "";

List<String> vehicleoutDestiLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Scienes faculty Canteen",
  "Botany Department Car Park",
  "Zoology Department Car Park",
  "Chemistry Department Car Park",
  "Physics Department Car Park",
  "Medical Center Car Park",
  "Library Car Park",
  "Maths Department Car Park",
  "CS Car park",
  "Faculty of fisharies",
  "Medical Center",
];
final vehicleoutDestiLocselect = TextEditingController();
String vehicleoutDestiLocselected = "";

List<String> vehicleinUserLoc = [];
final vehicleinUserLocselect = TextEditingController();
String vehicleinUserLocselected = "";

List<String> vehicleinDestiLoc = [];
final vehicleinDestiLocselect = TextEditingController();
String vehicleinDestiLocselected = "";


List<String> placeName=[
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 01",
  "CS Mini-auditorium",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS Computer lab 02",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS Wash Rooms",
  "CS Computer Lab 03",
  "Lecture Hall 01"
];
final placeNameSelect = TextEditingController();
String placeNameselected = "";

List<String> floor=[
  "Ground floor",
  "First floor",
  "Second floor"
  ];
String floorvalue  = "Ground floor";

List<String> department=[
  "Computer Science Department",
  "Botany Department",
  "Zoology Department",
  "Chemistry Department",
  "Physics Department",
  "Mathematics Department"
];
String departmentvalue ="Computer Science Department";

List<String> ground = [
  "CS Wash Rooms",
  "CS Computer Lab 01",
  "CS Car park"
  ];
final floorcontroller = TextEditingController();
String groundselected = "";

List<String> first = [
  "CS Record Room",
  "CS Special Lab",
  "CS Lecture's Room",
  "CS Instructor's Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS E-Learning Center",
  "CS Conference Room",
  "CS Head's Room",
  "CS Computer lab 02",
  "CS Record Room"
  ];
//final firstf = TextEditingController();
String firstselected = "";

List<String> secound = [
  "CS Mini-auditorium",
  "CS Computer Lab 03"
  ];
//final secoundf = TextEditingController();
String secoundselected = "";

List<String> ifground = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 03",
  "CS Mini-auditorium",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS Computer lab 02",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  ];
final iffloorcontroller = TextEditingController();
String ifgroundselected = "";

List<String> iffirst = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Mini-auditorium",
  "CS Computer Lab 01",
  "CS Special Room",
  "CS Wash Rooms",
  "CS Computer Lab 03",
  "CS Car park",
  ];
//final iffirstf = TextEditingController();
String iffirstselected = "";

List<String> ifsecound = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 01",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS Wash Rooms",
  "CS Computer lab 02",
  "CS Car park",
  ];
//final ifsecoundf = TextEditingController();
String ifsecoundselected = "";




List<String> outSideplaces=["Main Gate","Y Junction", "Library Junction","Library",
  "Student's Well fair branch","Maths Department", "Computer Science Department","Science faculty Canteen",
  "Science Auditorium","Science Dean office", "Botany Department","Zoology Department",
  "Faculty of fisharies", "Maths Lecture hall 1", "Maths Lecture hall 2","Chemistry Department",
  "Physics Department", "Medical Center","Student Common Room",
  "Student reading place","Maths Department"];

List<String> inSidePlces=["CS Lecturer's Room", "CS Instructors's Room","CS Computer Lab 01",
  "CS Mini-auditorium","CS Head's Room", "CS Conference Room", "CS Record Room",
  "CS Special Lab","CS Computer lab 02", "CS E-Learning Center",
  "CS Special Room","CS Demonstrator's Room", "CS Main-auditorium","CS Wash Rooms",
  "CS Computer Lab 03","Lecture Hall 01"];

List<String> ground_floor=["CS Wash Rooms","CS Computer Lab 03","CS Car park"];

List<String> first_floor=[ "CS Record Room", "CS Special Lab","CS Lecture's Room",
  "CS Instructor's Room", "CS Demonstrator's Room", "CS Main-auditorium",
  "CS E-Learning Center","CS Conference Room","CS Head's Room","CS Computer lab 02",
  "CS Record Room","CS Special Room"];

List<String> second_floor=[  "CS Mini-auditorium","CS Computer Lab 01"];
Map<String,int> departmentID={"Computer Science":1,"Zoology":2,"Chemistry":3,"Botany":4,"Physics":5,"Mathematics":6};

const String GOOGL_KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
String port="http://104.197.251.167";
List<int> groundFloor=[14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37];
List<int> firstFloor=[5,6,7,8,9,10,11,12,13];
List<int> secondFloor=[1,2,3,4];


//Color
const routeColor=Color.fromARGB(255,40,122,198);
const floorColor=Color.fromARGB(150,25,162,150);
const stairColor=Colors.red;

//dotted line Colors
const routesDColor=Color.fromARGB(150, 40,122,198);
const floorDColor=Color.fromARGB(150,25,162,150);
const stairDColor=Colors.red;
//width
const int routeWidth=8;
const int floorWidth=3;
const int stairWidth=8;

const MAX_FLOOR=3;
const GROUND_FLOOR=0;
const FIRST_FLOOR=1;
const SECOND_FLOOOR=2;
const double ZOOM=20.0;

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