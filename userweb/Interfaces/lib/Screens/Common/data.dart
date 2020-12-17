
import 'package:flutter/material.dart';

List<String> walkoutUserLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths lecture hall 1",
  "Maths lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student common room",
  "Student reading place",
];
final walkoutUserLocselect = TextEditingController();
String walkoutUserLocselected = "";

List<String> walkoutDestiLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths lecture hall 1",
  "Maths lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student common room",
  "Student reading place",
  "CS Lecturer's room",
  "CS Instructors's room",
  "CS Computer lab 1",
  "CS Mini auditorium",
  "CS Head's room",
  "CS Conference room",
  "CS Record room",
  "CS Special Lab",
  "CS Computer lab 2",
  "CS E-Learning center",
  "CS Special room",
  "CS Demonstrator's room",
  "CS Main auditorium",
  "CS Wash rooms",
  "CS Computer Lab 3",
  "Lecture hall 1"
];
final walkoutDestiLocselect = TextEditingController();
String walkoutDestiLocselected = "";

List<String> vehicleoutUserLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library Car park",
  "Maths Department Car park",
  "Computer Science Department Car park",
  "Science faculty canteen",
  "Botany Department Car park",
  "Zoology Department Car park",
  "Chemistry Department Car park",
  "Physics Department Car park",
  "Medical Center Car park",
];
final vehicleoutUserLocselect = TextEditingController();
String vehicleoutUserLocselected = "";

List<String> vehicleoutDestiLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library Car park",
  "Maths Department Car park",
  "Computer Science Department Car park",
  "Science faculty canteen",
  "Botany Department Car park",
  "Zoology Department Car park",
  "Chemistry Department Car park",
  "Physics Department Car park",
  "Medical Center Car park",
];
final vehicleoutDestiLocselect = TextEditingController();
String vehicleoutDestiLocselected = "";

List<String> placeName=["Lecture's Room","Instructor's Room","Computer Lab 01","Mini-auditorium",
<<<<<<< HEAD
"CS Head's room","Conference Room","Record Room","Special Lab","Computer lab 02","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Car park","Wash Rooms (CS)","Computer Lab 03",
"Lecture Hall 01","Server Room" ,"Main Gate","Library","Scenes Library","Scenes Auditorium",
"Scenes Cantin","Art Cantin","Auditorium" ];
=======
"Head's room","Conference Room","Record Room","Special Lab","Computer lab 02","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Car park","Wash Rooms","Computer Lab 03",
"Lecture Hall 01","Server Room"];

>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
final placeNameSelect = TextEditingController();
String placeNameselected = "";

List<String> floor=[
  "Ground floor",
  "First floor",
  "Second floor"
  ];
String floorvalue  = "Ground floor";
<<<<<<< HEAD

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
  "CS Wash rooms",
  "CS Computer Lab 3",
  ];
final groundf = TextEditingController();
String groundselected = "";

List<String> first = [
  "CS Special room",
  "CS Demonstrator's room",
  "CS Main auditorium",
  "CS E-Learning center",
  "CS Conference room",
  "CS Head's room",
  "CS Computer lab 1"
  ];
final firstf = TextEditingController();
String firstselected = "";

List<String> secound = [
  "CS Mini auditorium",
  "CS Computer lab 2"
  ];
final secoundf = TextEditingController();
String secoundselected = "";

List<String> ifground = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths lecture hall 1",
  "Maths lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student common room",
  "Student reading place",
  "CS Lecturer's room",
  "CS Instructors's room",
  "CS Computer lab 1",
  "CS Mini auditorium",
  "CS Head's room",
  "CS Conference room",
  "CS Record room",
  "CS Special Lab",
  "CS Computer lab 2",
  "CS E-Learning center",
  "CS Special room",
  "CS Demonstrator's room",
  "CS Main auditorium",
  "Lecture hall 1"
  ];
final ifgroundf = TextEditingController();
String ifgroundselected = "";

List<String> iffirst = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths lecture hall 1",
  "Maths lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student common room",
  "Student reading place",
  "CS Lecturer's room",
  "CS Instructors's room",
  "CS Mini auditorium",
  "CS Special Lab",
  "CS Computer lab 2",
  "CS Special room",
  "CS Wash rooms",
  "CS Computer Lab 3",
  "Lecture hall 1"
  ];
final iffirstf = TextEditingController();
String iffirstselected = "";

List<String> ifsecound = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths lecture hall 1",
  "Maths lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student common room",
  "Student reading place",
  "CS Lecturer's room",
  "CS Instructors's room",
  "CS Computer lab 1",
  "CS Head's room",
  "CS Conference room",
  "CS Record room",
  "CS Special Lab",
  "CS E-Learning center",
  "CS Special room",
  "CS Demonstrator's room",
  "CS Main auditorium",
  "CS Wash rooms",
  "CS Computer Lab 3",
  "Lecture hall 1"
  ];
final ifsecoundf = TextEditingController();
String ifsecoundselected = "";

List<String> third = [];
final thirdf = TextEditingController();
String thirdselected = "";


=======
List<String> department=["Computer Science","Zoology","Chemistry","Botany","Physics","Mathematics"];
String departmentvalue ="Computer Science";

/*
  01-Lecture's Room               11-Special Room
  02-Instructor's Room            12-Demostrator's Room
  03-Computer Lab 01              13-Main-auditorium
  04-Mini-auditorium              14-Car park
  05-Head's room                  15-Wash Rooms
  06-Conference Room              16-Computer Lab 03
  07-Record Room                  17-Lecture Hall 01
  08-Special Lab                  18-Server Room
  09-Computer lab 02
  10-E-Learning Center
*/

/*String port=" https://localhost:44342/API";
List<int> groundFloor=[16,15,16];
List<int> firstFloor=[10,13,4,6,5,3,11,12];
List<int> secondFloor=[18,9];
List<int> thirdFloor=[];

const MAX_FLOOR=3;
const GROUND_FLOOR=0;
const FIRST_FLOOR=1;
const SECOND_FLOOOR=2*/
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
