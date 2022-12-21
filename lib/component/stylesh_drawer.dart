import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class StyleshDrawer extends StatelessWidget {
  const StyleshDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.only(top: 100),
             child:Text(''),
            decoration: BoxDecoration(
                color: Colors.black,
              image:DecorationImage(
                  image: AssetImage("image/drawer_header_pic.jpg",),
                  fit: BoxFit.fill
              )
            ),
            margin: EdgeInsets.all(0.0),
          ),
          _drawerBuilder('Schedule'),
          _drawerBuilder('Presets'),
          _drawerBuilder('Settings'),
          _drawerBuilder('Rate App'),
          _drawerBuilder('Share App'),
          _drawerBuilder('Help & Feedback'),
        ],
      ),
    );
  }
  Widget _drawerBuilder(String text){
    return ListTile(
      onTap: () {
        if(text=='Help center'){
          // Navigator.push(context, MaterialPageRoute(builder: (context) =>hepls_center()));
        }
        else if(text=='Settings'){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => setting()));
        }
        else{
          // Navigator.push(context, MaterialPageRoute(builder: (context) => terms()));
        }
      },
      trailing: Icon(
       Icons.arrow_forward_ios),
      leading:
      text=='Schedule'?Icon(Icons.schedule,color: Colors.red,):
      text=='Presets'?Icon(Icons.list,color: Colors.grey):
      text=='Settings'?Icon(Icons.settings,color: Colors.lightBlueAccent):
      text=='Rate App'?Icon(Icons.star_outline,color: Colors.amber):
      text=='Share App'?Icon(Icons.share_sharp,color: Colors.redAccent):
      Icon(Icons.feedback_outlined,color: Colors.pinkAccent),
      title: Text(
        text,
        // style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black,fontFamily:"RaleWay" ),
        style: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 59, 59, 61),
          fontSize: 15,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
