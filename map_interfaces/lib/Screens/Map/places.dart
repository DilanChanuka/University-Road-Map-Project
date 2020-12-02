import 'package:google_maps_flutter/google_maps_flutter.dart';

class OutSidePlaces {
  String name;
  LatLng locationCoords;

  OutSidePlaces({
    this.name,
    this.locationCoords
  });
}

final List<OutSidePlaces> uorplaces = [
  OutSidePlaces(
    name: 'Main Gate',
    locationCoords: LatLng(5.93802, 80.574649),
  ),
  OutSidePlaces(
    name: 'Y Junction',
    locationCoords: LatLng(5.938596, 80.575161),
  ),
  OutSidePlaces(
    name: 'Library Junction',
    locationCoords: LatLng(5.938779, 80.575966),
  ),
  OutSidePlaces(
    name: 'Library',
    locationCoords: LatLng(5.938399, 80.576378),
  ),
  OutSidePlaces(
    name: 'Students Well Fair Branch',
    locationCoords: LatLng(5.937734, 80.576161),
  ),
  OutSidePlaces(
    name: 'Maths Department',
    locationCoords: LatLng(5.93945, 80.576022),
  ),
  OutSidePlaces(
    name: 'Computer Science Department',
    locationCoords: LatLng(5.939505, 80.576344),
  ),
  OutSidePlaces(
    name: 'Science Faculty Canteen',
    locationCoords: LatLng(5.939885, 80.576923),
  ),
  OutSidePlaces(
    name: 'Science Auditorium',
    locationCoords: LatLng(5.93947, 80.577466),
  ),
  OutSidePlaces(
    name: 'Science Dean Office',
    locationCoords: LatLng(5.93948, 80.577104),
  ),
  OutSidePlaces(
    name: 'Botany Department',
    locationCoords: LatLng(5.940006, 80.577992),
  ),
  OutSidePlaces(
    name: 'Zoology Department',
    locationCoords: LatLng(5.940578, 80.578011),
  ),
  OutSidePlaces(
    name: 'Faculty of Fisharies',
    locationCoords: LatLng(5.941287, 80.577381),
  ),
  OutSidePlaces(
    name: 'Maths Lecture Hall 01',
    locationCoords: LatLng(5.939213, 80.575706),
  ),
  OutSidePlaces(
    name: 'Maths Lecture Hall 02',
    locationCoords: LatLng(5.939121, 80.575812),
  ),
  OutSidePlaces(
    name: 'Chemistry Department',
    locationCoords: LatLng(5.940944, 80.576713),
  ),
  OutSidePlaces(
    name: 'Physics Department',
    locationCoords: LatLng(5.940462, 80.576642),
  ),
  OutSidePlaces(
    name: 'Medical Center',
    locationCoords: LatLng(5.940433, 80.576065),
  ),
  OutSidePlaces(
    name: 'Student Common Room',
    locationCoords: LatLng(5.939709, 80.577373),
  ),
  OutSidePlaces(
    name: 'Student Reading Place',
    locationCoords: LatLng(5.93893, 80.577123),
  ),
];