import 'package:flutter/material.dart';


////////////////////user location / walk / out side
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
  /////////// new places 
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final walkoutUserLocselect = TextEditingController();
String walkoutUserLocselected = "";

////////////////////////// destination / walk / out side
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
  "Lecture Hall 01",
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final walkoutDestiLocselect = TextEditingController();
String walkoutDestiLocselected = "";

/////////////////////// user laction / vehicle / out side
List<String> vehicleoutUserLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "Science Faculty canteen",
  "General Car Park",
  "Science Complex Car park",
  "Botany Department",
  "Zoology Department Car Park",
  "Faculty of Fisheries",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final vehicleoutUserLocselect = TextEditingController();
String vehicleoutUserLocselected = "";

////////////////////////  destination / vehicle / out side
List<String> vehicleoutDestiLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "Science Faculty canteen",
  "General Car Park",
  "Science Complex Car park",
  "Botany Department",
  "Zoology Department Car Park",
  "Faculty of Fisheries",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final vehicleoutDestiLocselect = TextEditingController();
String vehicleoutDestiLocselected = "";

///////////////////// user location / vehicle / in side 
List<String> vehicleinUserLoc = [];
final vehicleinUserLocselect = TextEditingController();
String vehicleinUserLocselected = "";

/////////////////// destination / vehicle / in side
List<String> vehicleinDestiLoc = [];
final vehicleinDestiLocselect = TextEditingController();
String vehicleinDestiLocselected = "";

/////////////// Search file 
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
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
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

//////////////user location / walk / in side / ground floor
List<String> ground = [
  "CS Wash Rooms",
  "CS Computer Lab 01",
  "CS Car park"
  ];
final floorcontroller = TextEditingController();
String groundselected = "";

///////////////////// user location / walk / in side / first floor
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

//////////////////user location / walk / in side / second floor
List<String> secound = [
  "CS Mini-auditorium",
  "CS Computer Lab 03"
  ];
//final secoundf = TextEditingController();
String secoundselected = "";

////////////////// destination / walk / in side / ground floor
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
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
  ];
final iffloorcontroller = TextEditingController();
String ifgroundselected = "";

/////////////////////// destination / walk / in side / first floor 
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
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
  ];
//final iffirstf = TextEditingController();
String iffirstselected = "";

////////////////////// destination / walk / in side / second floor
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
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
  ];
//final ifsecoundf = TextEditingController();
String ifsecoundselected = "";

final List<String> faculty = [
  "Faculty of Science",
  "Faculty of Art",
  "Faculty of Fisharies",
  "Faculty of Management"
];

String fty;