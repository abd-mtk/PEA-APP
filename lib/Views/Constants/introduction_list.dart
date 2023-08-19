import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> introductionList = [
  PageViewModel(
    title: "مرحبا في تطبيق الأحداث العامة",
    body:
        "هذا التطبيق يساعدك على إنشاء وتنظيم الأحداث العامة ومشاركتها مع الآخرين",
    image: Center(
      child: Image.asset("assets/images/1.png", height: 175.0),
    ),
  ),
  PageViewModel(
    title: "الدخول الامن للتطبيق",
    body:
        "يمكنك الدخول للتطبيق بسهولة وبأمان عن طريق تسجيل الدخول بحسابك الخاص أو بإنشاء حساب جديد والتوثيق من خلال رابط التفعيل",
    image: Center(
      child: Image.asset("assets/images/2.png", height: 175.0),
    ),
  ),
  PageViewModel(
    title: "إنشاء الأحداث العامة" ,
    body:
        "إنشاء الأحداث العامة ومشاركتها مع الآخرين مع تحديد مكان الحدث بدقة من خلال خرائط Google",
    image: Center(
      child: Image.asset("assets/images/3.png", height: 175.0),
    ),
  ),
  PageViewModel(
    title: "البحث عن الأحداث العامة",
    body:
       "امكانية البحث عن الاحداث المحيطة بك عبر تحديد نطاق البحث",
    image: Center(
      child: Image.asset("assets/images/4.png", height: 175.0),
    ),
  ),
  PageViewModel(
    title: "مميزات اخرى",
    body:
         "امكانية الغاء تنشيط الحدث او تفعيله لمدة معينة بالاضافة الى الوصول المخصص للمستخدمين",
    image: Center(
      child: Image.asset("assets/images/5.png", height: 175.0),
    ),
  ),
];
