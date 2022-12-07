// import 'package:ebusiness_atk_mobile/views/pages/print_preview.dart';
import 'package:flutter/material.dart';

import 'print_preview.dart';


class print_uploadPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //DO RESEARCH: BACKGROUND BACK BUTTON
        //iconTheme: IconThemeData(color: Colors.red),
        centerTitle: true,
        title: Text("Print")
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
            flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload File", 
                    style: TextStyle(fontSize: 30)
                  ) 
                ]
              )
            ),
            Expanded(
              flex: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 3, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                        //border: Border.all(color: Colors.grey.withOpacity(0.3))
                      ),
                      child: Material(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                        elevation: 3,
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("Pilih Berkas ..."),
                          ),
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                        // border: Border.all(color: Colors.grey.withOpacity(0.3))
                      ),
                      child: Material(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                        elevation: 5,
                        color: Colors.green[200],
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) {
                                  return print_previewPage();
                                }
                              )
                            );
                          },
                          splashColor: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("Upload"),
                          ),
                        ),
                      )
                    )
                  )
                ]
              ),
            ),

                // A Guidance:

                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     color: Colors.red,
                //     child: Text("this flex is 1")
                //   )
                // ),
                // Expanded(
                //   flex: 3,
                //   child: Container(
                //     color: Colors.blue,
                //     child: Text("this flex is 3")
                //   )
                // ),

          ]
        ),
      ),
    );
  }
}