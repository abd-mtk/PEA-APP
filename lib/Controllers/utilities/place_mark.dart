
  import 'package:geocoding/geocoding.dart';

String placeMark(Placemark palcemark) {
    return "اسم الموقع : ${palcemark.name} \n"
        "الدولة : ${palcemark.country} \n"
        "المدينة : ${palcemark.locality} \n"
        "المنطقة : ${palcemark.subLocality} \n"
        "الشارع : ${palcemark.street} \n"
        "الرمز البريدي : ${palcemark.postalCode} \n"
        "المنطقة الادارية : ${palcemark.administrativeArea} \n"
        "المنطقة الفرعية الادارية : ${palcemark.subAdministrativeArea} \n"
        "الطريق : ${palcemark.thoroughfare} \n"
        "الطريق الفرعي : ${palcemark.subThoroughfare} \n"
        "الرمز الدولي : ${palcemark.isoCountryCode} \n";
  }


  String placeMarkevent(palcemark) {
    return "اسم الموقع : ${palcemark["name"]} \n"
        "الدولة : ${palcemark["country"]} \n"
        "المدينة : ${palcemark["locality"]} \n"
        "المنطقة : ${palcemark["subLocality"]} \n"
        "الشارع : ${palcemark["street"]} \n"
        "الرمز البريدي : ${palcemark["postalCode"]} \n"
        "المنطقة الادارية : ${palcemark["administrativeArea"]} \n"
        "المنطقة الفرعية الادارية : ${palcemark["subAdministrativeArea"]} \n"
        "الطريق : ${palcemark["thoroughfare"]} \n"
        "الطريق الفرعي : ${palcemark["subThoroughfare"]} \n"
        "الرمز الدولي : ${palcemark["isoCountryCode"]} \n";
  }


