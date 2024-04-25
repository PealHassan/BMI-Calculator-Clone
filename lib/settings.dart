import 'package:bmicalculator/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';

class settings extends StatefulWidget {
  String selectedClassification, selectedHeight,selectedWeight;
  bool adultsOnly;
  settings({required this.selectedClassification,required this.selectedWeight,required this.selectedHeight, required this.adultsOnly});
  @override
  State<settings> createState() => _settingsState(selectedClassification: selectedClassification, selectedWeight: selectedWeight, selectedHeight: selectedHeight, adultsOnly: adultsOnly);
}

class _settingsState extends State<settings> {
  
  bool adultsOnly = false;
  String selectedClassification = 'WHO',selectedWeight = 'kg',selectedHeight = 'cm';
  _settingsState({required this.selectedClassification,required this.selectedWeight,required this.selectedHeight,required this.adultsOnly}) ;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon:Icon(Icons.arrow_back_ios_new,size: 30,),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => mainScreen(selectedClassification: selectedClassification, selectedWeight: selectedWeight!, selectedHeight: selectedHeight!, adultsOnly: adultsOnly,)),
                );
              },
        
              
            ),
            
          ],
        ),
      ),
      
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text('Settings',style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),),
          ),
          SizedBox(height: 30,),
          dropdown(['WHO','DGE'], 'Classification', selectedClassification),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(20),
            child: Visibility(
              visible: selectedClassification == 'DGE'?false:true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Adults Only',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                      value: adultsOnly,
                      onChanged: (newValue) {
                        setState(() {
                          adultsOnly = newValue;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: selectedClassification == 'DGE'?Text(
                  '(Age independent)',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ):Text(
                  '(Age and gender independent)',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              dropdown(['kg','lb','st'], 'Weight', selectedWeight),
              dropdown(['cm','ft'], 'Height', selectedHeight),
            ],
          ),
      
        ],
      ),
    );
  }
  dropdown(List<String>items, String category, String value) {
    return Column(
    
      children: [
        Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
                category, // Legendary title
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
          ),
        Container(
                padding: EdgeInsets.only(left: 20),
                child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: value,
                  onChanged: (String? value) {
                    setState(() {
                      category == 'Classification'? selectedClassification = value!:
                      category == 'Weight'? {
                        selectedWeight = value!,
                      }:selectedHeight = value!;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: 160,
                    padding: const EdgeInsets.only(left: 20, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                    elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_downward,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color(0xffe1e2ec),
                    ),
                    // offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
                        ),
              ),
      ],
    );
  }
  
}