
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Science Faculty

//Department of Computer Science


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
const String GOOGL_KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";

List<String> csplaceName=["Lecture's Room","Instructor's Room","Computer Lab 01","Mini-auditorium",
"Head's room","Conference Room","Record Room","Special Lab","Computer lab 02","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Car park","Wash Rooms","Computer Lab 03",
"Lecture Hall 01","Server Room"];

List<LatLng> csplaceLatLng=[LatLng(7.353377, 80.938378),LatLng(7.358059, 80.935695)];

String port=" https://localhost:44342/API";
List<int> groundFloor=[16,15,16];
List<int> firstFloor=[10,13,4,6,5,3,11,12];
List<int> secondFloor=[18,9];
List<int> thirdFloor=[];


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