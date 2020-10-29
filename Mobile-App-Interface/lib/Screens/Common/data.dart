

//Science Faculty

//Department of Computer Science

List<String> placeName=["Lecture's Room","Instructor's Room","Computer Lab 01","Mini-auditorium",
"Head's room","Conference Room","Record Room","Special Lab","Computer lab 02","E-Learning Center",
"Special Room","Demostrator's Room","Main-auditorium","Car park","Wash Rooms","Computer Lab 03",
"Lecture Hall 01","Server Room"];

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

List<int> groundFloor=[16,15,16];
List<int> firstFloor=[10,13,4,6,5,3,11,12];
List<int> secondFloor=[18,9];
List<int> thirdFloor=[];

const MAX_FLOOR=3;
const GROUND_FLOOR=0;
const FIRST_FLOOR=1;
const SECOND_FLOOOR=2;