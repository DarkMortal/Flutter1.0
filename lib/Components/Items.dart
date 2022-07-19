import 'package:flutter/material.dart';
import 'package:flutter1/ThemeProvider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

List<String> popups = ["Theme","Share","Report","Rate","About"];

TextStyle taskHeading = GoogleFonts.acme(
  textStyle: const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.white
)), miniData = GoogleFonts.acme(
      textStyle: const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white
)), subtaskHeading = GoogleFonts.acme(
  textStyle: const TextStyle(
    fontSize: 25.0,
    color: Colors.white
)), dateText = GoogleFonts.acme(
  textStyle: const TextStyle(
    fontSize: 25.0,
    //color: Colors.white
));

const Text collapsable = Text(
  "",
  style: TextStyle(
    color: Colors.transparent,
    fontSize: 0.0,
  ),
);

class AddButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            direction: SpeedDialDirection.up,
            //animatedIcon: AnimatedIcons.add_event,
            activeBackgroundColor: Colors.red,
            animationSpeed: 200,
            activeIcon: Icons.close,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.notes),
                label: "Notes",
              ),
              SpeedDialChild(
                child: const Icon(Icons.task_alt_outlined),
                label: "Task",
              )
            ],
            spaceBetweenChildren: 5.0,
            backgroundColor: Colors.orange,
          ),
          body: MainApp(),
      );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(
        child: Tasks(),
      );
}

final List<String> monthList = ["January","February","March","April","May","June","July","August","September","October","November","December"];

class Dates extends StatefulWidget{
  @override
  DateState createState() => DateState();
}

String dateString(DateTime x){
  String str = x.day.toString();
  str += ("\n"+monthList[x.month-1].substring(0,3));
  str += ("\n"+x.year.toString());
  return str;
}

class DateState extends State<Dates>{
  List<Widget> dates = <Widget>[];
  int currentSelected = 0;
  @override void initState() {
    // TODO: implement initState
    super.initState();
    int currentSelected = 2;
    for(int i=0;i<10;i++){
      DateTime x = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+i);
      dates.add(
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: (){
                  Fluttertoast.showToast(
                    msg: "DateTime",
                    fontSize: 18,
                  );
                  setState((){
                    currentSelected = 1;
                  });
                },
                child: Container(
                //key: const ValueKey(i),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (i == currentSelected)?Colors.deepPurpleAccent:Colors.blue,
                ),
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                child: Text(dateString(x),style: subtaskHeading,textAlign: TextAlign.center,),

          )))
      );
    }
  }
  @override
  Widget build(BuildContext context) =>
      Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 10.0,bottom: 0.0, right: 10.0),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children:dates)
  )
      );
}

class Tasks extends StatefulWidget{
  @override
  TaskState createState() => TaskState();
}

class TaskState extends State<Tasks>{
  List<Widget> tasks = <Widget>[];
  @override void initState() {
    super.initState();
    tasks = <Widget>[
      Dates(),
      Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const DrawerMotion(),
            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(
                onDismissed: (){
                   setState((){
                     tasks.removeAt(0);
                   });
                }
            ),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
             SlidableAction(
                onPressed: (context){},
                backgroundColor: Colors.red.shade500,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(5.0),
              )
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                //flex: 2,
                onPressed: (context){},
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                borderRadius: BorderRadius.circular(5.0)
              ),
              SlidableAction(
                onPressed: (context){},
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                icon: Icons.task,
                label: 'Mark as Done',
                borderRadius: BorderRadius.circular(5.0)
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 10.0,bottom: 0.0, right: 10.0),
              child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.redAccent,
              child: ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(left: 15.0,top: 10.0,bottom: 5.0, right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "1. Some Tasks",
                      style: taskHeading,
                    ),
                    const SizedBox(height: 7.0,),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,color: Colors.white),
                        const SizedBox(width: 7.0,),
                        Text(
                          "March 18, 2022",
                          style: miniData,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.watch_later,color: Colors.white),
                        const SizedBox(width: 7.0,),
                        Text(
                          "9:00 AM to 12:00 PM",
                          style: miniData,
                        )
                      ],
                    )
                  ],
                )
              ),
              collapsed: collapsable,
              expanded: Padding(
                  padding: const EdgeInsets.only(left: 40.0,bottom: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("1. Watch Beyblade",style: subtaskHeading,textAlign: TextAlign.left),
                        Text("2. Catch Pokemon",style: subtaskHeading,textAlign: TextAlign.left),
                        Text("3. Eat Sushi",style: subtaskHeading,textAlign: TextAlign.left)
                      ],
                    ),
                  )
              )
            )
          ))
      ),
      Slidable(
          key: const ValueKey(1),
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const DrawerMotion(),
            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(
                onDismissed: (){
                  setState((){
                    tasks.removeAt(1);
                  });
                }
            ),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (context){},
                backgroundColor: Colors.red.shade500,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(5.0)
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                //flex: 2,
                onPressed: (context){},
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                borderRadius: BorderRadius.circular(5.0)
              ),
              SlidableAction(
                onPressed: (context){},
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                icon: Icons.task,
                label: 'Mark as Done',
                borderRadius: BorderRadius.circular(5.0)
              ),
            ],
          ),
          child: Padding(
    padding: const EdgeInsets.only(left: 10.0,top: 10.0,bottom: 0.0, right: 10.0),
            child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.green.shade500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,top: 5.0,bottom: 5.0,right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "2. Die",
                        style: taskHeading,
                      ),
                      const SizedBox(height: 7.0,),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,color: Colors.white),
                          const SizedBox(width: 7.0,),
                          Text(
                            "March 18, 2022",
                            style: miniData,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.watch_later,color: Colors.white),
                          const SizedBox(width: 7.0,),
                          Text(
                            "9:00 AM to 12:00 PM",
                            style: miniData,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ))
      )
    ];
  }

  @override
  Widget build(BuildContext context) =>
      SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tasks,
          )
      );
}

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                "Guest User",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
              accountEmail: const Text("",style: TextStyle(fontSize: 0.0),),
              currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      "https://w7.pngwing.com/pngs/831/88/png-transparent-user-profile-computer-icons-user-interface-mystique-miscellaneous-user-interface-design-smile-thumbnail.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              decoration: BoxDecoration(
                  color: Colors.blue.shade500
              ),
            ),
            const ListTile(
              leading: Icon(Icons.task_outlined),
              title: Text("Completed Tasks"),
            ),
            const ListTile(
              leading: Icon(Icons.pending),
              title: Text("Pending Tasks"),
            ),
            const ListTile(
              leading: Icon(Icons.notes),
              title: Text("Notes"),
            ),
          ],
        ),
      );
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
            value: popups[0],
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child : Icon(
                      (Theme.of(context).brightness == Brightness.light)?(Icons.light_mode):(Icons.dark_mode),
                    ),
                  ),
                  const Text("Theme")
                  ],
                )
            ),
            PopupMenuItem(
                value: popups[1],
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child : Icon(
                        Icons.share,
                      ),
                    ),
                    Text("Share")
                  ],
                )
            ),
            PopupMenuItem(
                value: popups[2],
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child : Icon(
                        Icons.report,
                      ),
                    ),
                    Text("Report a Bug")
                  ],
                )
            ),
            PopupMenuItem(
                value: popups[3],
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child : Icon(
                        Icons.star_rate,
                      ),
                    ),
                    Text("Rate Us"),
                  ],
                )
            ),
            PopupMenuItem(
                value: popups[4],
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child : Icon(
                        Icons.info,
                      ),
                    ),
                    Text("About")
                  ],
                )
            )
          ],
          onSelected: (value){
            if(value == "Report") {
              Fluttertoast.showToast(
                msg: "Reporting Bug...",
                fontSize: 18,
              );
            }
            if(value == "Share") {
              Fluttertoast.showToast(
                msg: "Sharing...",
                fontSize: 18,
              );
            }
            if(value == "Rate") {
              Fluttertoast.showToast(
                msg: "Rating...",
                fontSize: 18,
              );
            }
            if(value == "About") {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => About()
                  )
              );
            }
            if(value == "Theme") {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ThemeChanger()
                  )
              );
            }
          }
      );
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
              title: const Text("About"),
              centerTitle: true,
              backgroundColor: Colors.blue),
          body: const Center(
              child: Text(
                "About Page !!!\n\nNeem ka patta kadwa hai\nHar koi apna bhadwa hai",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
          )
      );
}
