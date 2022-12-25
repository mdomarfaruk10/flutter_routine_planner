import 'package:daily_routine_planner/db/db_helper.dart';
import 'package:daily_routine_planner/screen/home_screen.dart';
import 'package:daily_routine_planner/services_provider/Services_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


 Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
    // return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(create: (context) => ServiceProvider()),
    //     ],
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: HomeScreen(),
    //   ),
    // );
  }
}

