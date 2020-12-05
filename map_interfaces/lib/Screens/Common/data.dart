
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
  "CS Car park"
  
];
final vehicleoutUserLocselect = TextEditingController();
String vehicleoutUserLocselected = "";

List<String> vehicleoutDestiLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Scenes faculty Canteen",
  "Botany Department Car Park",
  "Zoology Department Car Park",
  "Chemistry Department Car Park",
  "Physics Department Car Park",
  "Medical Center Car Park",
  "Library Car Park",
  "Maths Department Car Park",
  "CS Car park",
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
  ];
//final ifsecoundf = TextEditingController();
String ifsecoundselected = "";
