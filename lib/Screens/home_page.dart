import 'package:flutter/material.dart';
import '../Widgets/text_button.dart';
import 'package:provider/provider.dart';
import '../Models/notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? title;
  TextEditingController? date;
  initState() {
    title = TextEditingController();
    date = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    DateTime currentDate = DateTime.now();

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(2015),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != currentDate) {
        setState(() {
          currentDate = pickedDate;
          date?.text = currentDate.day.toString() +
              '-' +
              currentDate.month.toString() +
              '-' +
              currentDate.year.toString();
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Remainder"),
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Consumer<Notifier>(builder: (context, taskL, child) {
            return ListView.builder(
              itemCount: taskL.taskList.length,
              itemBuilder: (context, ind) {
                final item = taskL.taskList[ind];

                return Dismissible(
                  key: Key(item.titleFinal),
                  onDismissed: (direction) {
                    Provider.of<Notifier>(context, listen: false)
                        .deleteTask(ind);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Notification for ${item.titleFinal} Removed')));
                  },
                  background: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.red),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete),
                  ),
                  child: Container(
                    height: 100,
                    width: width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Theme.of(context).colorScheme.background,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskL.taskList[ind].titleFinal,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            Text(
                              taskL.taskList[ind].dateFinal,
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Form(
                    key: _formKey,
                    child: Container(
                      height: 250,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter title';
                              }
                              return null;
                            },
                            controller: title,
                            decoration: const InputDecoration(
                                labelText: "Title", icon: Icon(Icons.title)),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select Date';
                              }
                              return null;
                            },
                            controller: date,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: "Date",
                              icon: InkWell(
                                  onTap: () async {
                                    await selectDate(context);
                                  },
                                  child: const Icon(Icons.calendar_today)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)))),
                                child: const Text("Submit"),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    Provider.of<Notifier>(context,
                                            listen: false)
                                        .addTaskInList(title?.text, date?.text);
                                    Navigator.pop(context);
                                    setState(() {
                                      title?.text = '';
                                      date?.text = '';
                                    });
                                  }
                                },
                              ),
                              textButton('Reset', context, title, date)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        elevation: 2,
        child: const Icon(Icons.add),
        tooltip: "Add new remainder",
      ),
    );
  }
}
