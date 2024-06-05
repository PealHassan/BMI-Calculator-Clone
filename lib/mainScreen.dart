
import 'dart:math';
import 'dart:ui';
import 'package:BmiCalculator/settings.dart';
import 'package:BmiCalculator/settings.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/rendering.dart';
class mainScreen extends StatefulWidget {
  String selectedWeight,selectedHeight,selectedClassification;
  bool adultsOnly;
  mainScreen({required this.selectedClassification, required this.selectedWeight, required this.selectedHeight,required this.adultsOnly});
  @override
  State<mainScreen> createState() => _mainScreenState(classification: selectedClassification, selectedWeight: selectedWeight, selectedHeight: selectedHeight, adultsOnly: adultsOnly);
}

class _mainScreenState extends State<mainScreen> {
  TextEditingController ageController = new TextEditingController();   
  TextEditingController heightController = new TextEditingController();   
  TextEditingController ftController = new TextEditingController();   
  TextEditingController inchController = new TextEditingController();   
  TextEditingController weightkgController = new TextEditingController();
  TextEditingController weightlbController = new TextEditingController();
  TextEditingController weightlb2Controller = new TextEditingController();
  TextEditingController weightstController = new TextEditingController();
  String category = "...", diff = "...";
  double value1 = 16.0,  value2 = 18.5, value3 = 25.0, value4 = 40.0;
  List<dynamic>whoStan = [
    [
      [13.6,13.7,19.1,19.2,21.0,21.1,38.5,53.8],
      [14.2,14.3,19.2,19.3,22.5,22.6,40.1,54.1],
      [13.7,13.8,19.3,19.4,21.5,21.6,38.7,54.4],
      [14.6,14.7,21.3,21.4,24.9,25.0,41.3,60.0],
      [14.3,14.4,21.1,21.2,22.9,23.0,40.4,59.4],
      [14.8,14.9,21.9,22.0,24.7,24.8,41.8,61.7],
      [16.2,16.3,21.6,21.7,24.4,24.5,45.8,60.9],
      [16.7,16.8,22.5,22.6,25.6,25.7,47.2,63.4],
      [17.8,17.9,23.0,23.1,25.8,25.9,50.3,64.8],
      [18.5,18.6,23.6,23.7,25.9,26.0,52.2,66.5],
      [18.6,18.7,23.6,23.7,25.7,25.8,52.5,66.5],
      [18.6,18.7,23.9,24.0,26.7,26.8,52.5,67.3],
    ],
    [
      [13.2,13.3,18.1,18.2,23.0,23.1,37.3,51.0],    
      [13.2,13.3,18.7,18.8,22.2,22.3,37.3,52.7],
      [13.7,13.8,19.7,19.8,23.3,23.4,38.7,55.5],
      [14.2,14.3,20.6,20.7,23.3,23.4,40.1,58.0],
      [14.7,14.8,20.7,20.8,22.8,22.9,41.5,58.3],
      [15.0,15.1,21.4,21.5,23.3,23.4,42.4,60.3],
      [15.6,15.7,21.9,22.0,24.3,24.4,44.1,61.7],
      [17.0,17.1,23.1,23.2,25.9,26.0,48.0,65.1],
      [17.6,17.7,23.1,23.2,27.5,27.6,49.7,65.1],
      [17.8,17.9,22.7,22.8,24.1,24.2,50.3,63.9],
      [17.8,17.9,23.3,23.4,25.6,25.7,50.3,65.6],
      [18.3,18.4,23.4,23.5,24.9,25.0,51.7,65.9],
    ],
  ];
  List<dynamic>dgeStan = [
    [19.9,20.0,24.9,25.0,29.9,30.0,34.9,35.0,39.9,40.0,20.0,25.0],
    [18.9,19.0,23.9,24.0,29.9,30.0,34.9,35.0,39.9,40.0,19.0,24.0],

  ];
  double normalWeightmn = 0.0, normalWeightmx = 0.0;
  String classification = 'WHO';
  double weight = 0, height = 0;
  Color color = Colors.black;
  List<double>whoStanAdult = [15.9,16.0,16.9,17.0,18.4,18.5,24.9,25.0,29.9,30.0,34.9,35.0,39.9,40.0,51.9,70.1];
  List<dynamic>whoCatYong = [
    'Underweight',
    'Normal',
    'Overweight',
    'Obese',  
  ];
  List<String>dgeCat = [
    'Underweight',
    'Normal',
    'Overweight',
    'Obese Class I',
    'Obese Class II',
    'Obese Class III',
  ];
  List<Color>dgeCol = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
  ];
  List<Color>whoColYong = [Colors.blue,Colors.green,Colors.red,Colors.red];
  List<Color>whoColAdult = [Colors.blue,Colors.blue,Colors.blue,Colors.green,Colors.red,Colors.red,Colors.red,Colors.red];
  List<dynamic>whoCatAdul = [
    'Very Severely Underweight',
    'Severely Underweight',
    'Underweight',
    'Normal',
    'Overweight',
    'Obese Class I',
    'Obese Class II',
    'Obese Class III',
  ];
  


  String? selectedHeight = 'cm',selectedWeight = 'kg';
  bool adultsOnly;
  _mainScreenState({required this.classification, required this.selectedWeight, required this.selectedHeight, required this.adultsOnly});
  @override
  void initState() {
    if(classification == 'WHO') {
      if(adultsOnly) ageController.text = "19";
    }
    calculateBMI();
  }
  final List<String> heightItems = [
    'cm',
    'ft',
  ];
  final List<String> weightItems = [
    'kg',
    'lb',
    'st',
  ];
  int gender = 0;
  double bmi = 0.0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Settings') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => settings(selectedClassification: classification, selectedWeight: selectedWeight!, selectedHeight: selectedHeight!, adultsOnly: adultsOnly)),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Settings'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            elevation: 2,
          ),
          
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('BMI Calculator'),
            Row(
              children: [
                IconButton(
                  onPressed: refresh, 
                  icon: Icon(Icons.restart_alt),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                classification == 'DGE'?GestureDetector(
                  onTap: () {
                    setState(() {
                      gender = 1 - gender;
                      calculateBMI();
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    padding: EdgeInsets.only(left: 10, top: 30,),
                    child: gender == 0?Image.asset('assets/male.png'):
                      Image.asset('assets/female.png'),
                    ),
                ):Visibility(
                  visible: adultsOnly?false:true,
                  child: customTextField(ageController, 'Age', 80),),
                
                selectedHeight == 'cm'?customTextField(heightController, 'Height', 160):
                Row(
                  children: [
                    customTextField(ftController, '', 75),
                    Text('\'',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )
                    ),
                    customTextField(inchController, '', 75),
                    Text('\'\'',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )
                    ),
                  ],
                ),
                
                SizedBox(width: 5,),
                dropdown(heightItems,'height'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Visibility(
                  visible: classification == "DGE"?false:adultsOnly?false:true,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        gender = 1 - gender;
                        calculateBMI();
                      });
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: EdgeInsets.only(left: 10, top: 30,),
                      child: gender == 0?Image.asset('assets/male.png'):
                        Image.asset('assets/female.png'),
                      ),
                  ),
                ),
                selectedWeight == 'kg'? customTextField(weightkgController, 'Weight', 160):
                selectedWeight == 'lb'?customTextField(weightlbController, 'Weight', 160):
                Row(
                  children: [
                    customTextField(weightstController, 'st', 75),
                    customTextField(weightlb2Controller, 'lb', 75),
                  ],
                ),
                
                SizedBox(width: 6,),
                dropdown(weightItems,'weight'),
              ],
            ),
            Container(
              child: CustomPaint(
                painter: drawBmiView(bmi: bmi,color: category == '...'?Colors.blue:color,value1: value1,value2: value2, value3: value3, value4: value4),
                size: Size(300,200),
              ),
            ),
              
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category'),
                  Text('Difference'),
                ],
              ),),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category,style: TextStyle(color: color),),
                  category == 'Normal' ?Icon(Icons.check,color: Colors.green,):Text(diff,style: TextStyle(color: color),),
                ],
              ),),
                
              Container(
                padding: EdgeInsets.only(left:20,right: 20),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                  height: 20.0, // Optional, adds vertical space above and below the divider
                )
,
              ),
              
              
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: classification == 'DGE'? Column(
                    children: [
                      categroyView(dgeCat[0], '<=', dgeStan[gender][0], dgeStan[gender][0]),
                      SizedBox(height: 8,),
                      categroyView(dgeCat[1],"-",dgeStan[gender][1],dgeStan[gender][2]),
                      SizedBox(height: 8,),
                      categroyView(dgeCat[2], "-", dgeStan[gender][3], dgeStan[gender][4]),
                      SizedBox(height: 8,),
                      categroyView(dgeCat[3], "-", dgeStan[gender][5], dgeStan[gender][6]),
                      SizedBox(height: 8,),
                      categroyView(dgeCat[4], "-", dgeStan[gender][7], dgeStan[gender][8]),
                      SizedBox(height: 8,),
                      categroyView(dgeCat[5], ">=", dgeStan[gender][9], dgeStan[gender][9]),
                    ],
                  ):ageController.text.toString() != '' && int.parse(ageController.text.toString()) >= 7 && int.parse(ageController.text.toString()) <= 18?Column(
                    children: [
                      categroyView('Underweight',"<=",whoStan[gender][int.parse(ageController.text.toString())-7][0],whoStan[gender][int.parse(ageController.text.toString())-7][0]),
                      SizedBox(height: 20,),
                      categroyView('Normal',"-",whoStan[gender][int.parse(ageController.text.toString())-7][1],whoStan[gender][int.parse(ageController.text.toString())-7][2]),
                      SizedBox(height: 20,),
                      categroyView('Overweight',"-",whoStan[gender][int.parse(ageController.text.toString())-7][3],whoStan[gender][int.parse(ageController.text.toString())-7][4]), 
                      SizedBox(height: 20,),
                      categroyView('Obese',">=",whoStan[gender][int.parse(ageController.text.toString())-7][5],whoStan[gender][int.parse(ageController.text.toString())-7][5]),
                    ],
                  ):Column(
                    children: [
                      categroyView('Very Severely Underweight',"<=",15.9,15.9),
                      categroyView('Severely Underweight',"-",16.0,16.9),
                      categroyView('Underweight',"-",17.0,18.4),
                      categroyView('Normal', '-', 18.5, 24.9),
                      categroyView('Overweight', '-', 25.0, 29.9),
                      categroyView('Obese Class I', '-', 30, 34.9),
                      categroyView('Obese Class II', '-', 35.0, 39.9),   
                      categroyView('Obese Class III', '>=', 40.0, 40.0),
                      
                    ],
                  ),
                ),
                Container(
                padding: EdgeInsets.only(left:20,right: 20),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                  height: 20.0, 
                )
,
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Normal Weight'),
                  normalWeightmn == 0?Text("..."):Text(trunck(normalWeightmn) + " - " + trunck(normalWeightmx) + " kg"),
                ],
              ),),
            ],
        ),
      ),
    );
  }
  
  String trunck(double val) {
    String res = val.toStringAsFixed(5),ans = "";
    for(int i = 0; i < res.length; i++) {
      if(res[i] == '.') {
        ans += res[i];
        ans += res[i+1];
        break;  
      }
      else ans += res[i];
    }
    return ans;
  }
  categroyView(String category, String rel, double mn, double mx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Visibility(
                  visible: category == this.category?true:false,
                  child: Icon(Icons.arrow_right,color: color,
                )),
                Text(category,style: TextStyle(color: category == this.category?color:Colors.black,),
                  
                ),
          ],
        ),
        
        Container(
              width: 80,
              child: mn == mx?Center(child: Text("$rel $mn",
              style: category == this.category?TextStyle(color: color):TextStyle(color:Colors.black),
              )):Center(child: Text("$mn $rel $mx",
              style: category == this.category?TextStyle(color: color):TextStyle(color:Colors.black),
              )), 
            ),
      ],
    );
  }
  
  dropdown(List<String>items, String category) {
    return Container(
      padding: EdgeInsets.only(top: 40, right: 20),
      child: Center(
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
                            color: Color(0xff4db6ac),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                      .toList(),
                      value: category == 'height'?selectedHeight:selectedWeight,
                      onMenuStateChange: print,
                      
                      onChanged: (String? value) {
                        setState(() {
                          if(category == 'height') selectedHeight = value;
                          else selectedWeight = value;
                          calculateBMI();
                        });
                      },
                    buttonStyleData: ButtonStyleData(
                      height: 20,
                      width: 80,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_downward,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Color(0xffe1e2ec),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffe1e2ec),
                      ),
                      
                
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
    );
  }
  calculateBMI() {
    print('came');
    setState(() {
      if(classification == 'WHO') {
        if(ageController.text.toString() != '' && int.parse(ageController.text.toString()) >= 7 && int.parse(ageController.text.toString()) <= 18) {
          int age = int.parse(ageController.text.toString());
          value1 = whoStan[gender][age-7][0] - 2.6;   
          value2 = whoStan[gender][age-7][1]; 
          value3 = whoStan[gender][age-7][3]; 
          value4 = whoStan[gender][age-7][5] + 12.9;
        }
        else {
          value1 = whoStanAdult[1];
          value2 = whoStanAdult[5];
          value3 = whoStanAdult[7]; 
          value4 = whoStanAdult[13];
        }
        value1 = double.parse(trunck(value1));
        value2 = double.parse(trunck(value2));
        value3 = double.parse(trunck(value3));
        value4 = double.parse(trunck(value4));
      }
      else {
        if(gender == 0) {
          value1 = 18.0; 
          value2 = 20.0;
          value3 = 25.0;  
          value4 = 40.0;    
        }
        else {
          value1 = 16.0; 
          value2 = 19.0;   
          value3 = 24.0;  
          value4 = 39.0;
        }
        value1 = double.parse(trunck(value1));
        value2 = double.parse(trunck(value2));
        value3 = double.parse(trunck(value3));
        value4 = double.parse(trunck(value4));
      }
    });
    
    if(selectedWeight == 'kg' && weightkgController.text.toString() == '') {
      setState(() {
        category = "...";
        diff = "...";
        bmi = 0;
        normalWeightmn = 0;
        normalWeightmx = 0;   
      });
      return;
    }
    if(selectedWeight == 'lb' && weightlbController.text.toString() == '') {
      setState(() {
        category = '...';
        diff = '...';   
        bmi = 0;
        normalWeightmn = 0;
        normalWeightmx = 0;   
      });
      return;
    }
    if(selectedWeight == 'st' && weightstController.text.toString() == '' && weightlb2Controller.text.toString() == '') {
      setState(() {
        category = '...';
        diff = '...';   
        bmi = 0;
        normalWeightmn = 0;
        normalWeightmx = 0;   
      });
      return;
    } 
    if(selectedHeight == 'cm' && heightController.text.toString() == '') {
      setState(() {
        category = '...';
        diff = '...';   
        bmi = 0;
        normalWeightmn = 0;
        normalWeightmx = 0;   
      });
      return;
    }  
    if(selectedHeight == 'ft' && ftController.text.toString() == '' && inchController.text.toString() == '') {
      setState(() {
        category = '...';
        diff = '...';   
        bmi = 0;
        normalWeightmn = 0;
        normalWeightmx = 0;   
      });
      return;
    }
    double weight = 0, height = 0;
    if(selectedWeight == 'lb') weight = double.parse(weightlbController.text.toString())*0.45359237;
    else if(selectedWeight == 'st') {
      if(weightstController.text.toString() != '') weight = double.parse(weightstController.text.toString())*6.35029;
      if(weightlb2Controller.text.toString() != '') weight += (double.parse(weightlb2Controller.text.toString())*0.45359237);
    }
    else weight = double.parse(weightkgController.text.toString());
    if(selectedHeight == 'ft') {
      if(ftController.text.toString() != '') height = double.parse(ftController.text.toString())*0.3048;
      if(inchController.text.toString() != '') height += (double.parse(inchController.text.toString())*0.0254);
    }
    else height = double.parse(heightController.text.toString())*.01;
    setState(() {
      this.weight = weight;
      this.height = height;
      bmi = double.parse(((weight)/(height*height)).toStringAsFixed(1));
      if(classification == 'DGE') {
        if(weight <= 6) {
          category = "...";
          diff = "...";
          normalWeightmn = 0;
          normalWeightmx = 0;   
        }
        else {
          for(int i = 0; i <= 8; i+=2) {
            if(bmi <= dgeStan[gender][i]) {
              category = dgeCat[((i+1)/2).floor()];
              color = dgeCol[((i+1)/2).floor()];
              break;
            }
          }
          if(bmi >= dgeStan[gender][9]) {
            category = dgeCat[5];
            color = dgeCol[5];
          }
          double mn = (dgeStan[gender][1]*height*height);
          double mx = (dgeStan[gender][2]*height*height); 
          normalWeightmn = mn;
          normalWeightmx = mx;    
          if(weight < mn) diff = "-"+trunck(mn-weight)+" kg";
          else if(weight > mx) diff = "+"+trunck(weight-mx)+" kg";
          else diff = "0";
        }
      }
      else if(ageController.text.toString() == '' || int.parse(ageController.text.toString()) <= 6) {
        category = '...';
        diff = '...';      
        normalWeightmn = 0;
        normalWeightmx = 0;   
      }
      else if(weight <= 6) {
        normalWeightmn = 0;
        normalWeightmx = 0;   
        category = "...";
        diff = "..."; 
      }
      else if(int.parse(ageController.text.toString()) > 18) {
        for(int i = 0; i < 14; i+=2) {
          if(bmi <= whoStanAdult[i]) {
            category = whoCatAdul[((i+1)/2).floor()];
            color = whoColAdult[((i+1)/2).floor()];
            break;
          }
        }
        if(bmi >= whoStanAdult[13]) {
          category = whoCatAdul[7];
          color = whoColAdult[7];
        }
        double mn = (whoStanAdult[5]*height*height);
        double mx = (whoStanAdult[6]*height*height);   
        normalWeightmn = mn;
        normalWeightmx = mx;   
        if(weight < mn) diff = "-"+trunck(mn-weight)+" kg";
        else if(weight > mx) diff = "+"+trunck(weight-mx)+" kg";
        else diff = "0";
      }
      else {
        int age = int.parse(ageController.text.toString());
        print(age);
        for(int i = 0; i < 6; i+=2) {
          if(bmi <= whoStan[gender][age-7][i]) {
            category = whoCatYong[((i+1)/2).floor()];
            color = whoColYong[((i+1)/2).floor()];
            break;  
          }
        }
        if(bmi >= whoStan[gender][age-7][5]) {
          category = "Obese"; 
          color = Colors.red;
        }
        double mn = (whoStan[gender][age-7][1]*height*height);
        double mx = (whoStan[gender][age-7][2]*height*height);   
        normalWeightmn = mn;
        normalWeightmx = mx;   
        if(weight < mn) diff = "-"+trunck(mn-weight)+" kg";
        else if(weight > mx) diff = "+"+trunck(weight-mx)+" kg";
        else diff = "0";
      }
      
      print(bmi);
    });
  }
  customTextField(TextEditingController controller,String text,  double width) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.only(left: 20,top: 20),
      width: width,
      child: TextField(    
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: text,
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              fontSize: 15,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(width: 2),
            ),

          ),
          onChanged: (value) {
            calculateBMI();
          }
        ),
    
    );
  }
  refresh() {
    ageController.clear();
    ftController.clear();
    inchController.clear();     
    heightController.clear();
    weightkgController.clear();
    weightlbController.clear();
    weightstController.clear();
    weightlb2Controller.clear();
    setState(() {
      bmi = 0.0;
      category = "...";
      diff = "...";
      calculateBMI();
    });
    
  }
}
class drawBmiView extends CustomPainter {  
  double bmi = 0.0;
  Color color;
  double value1, value2, value3, value4;
  drawBmiView({required this.bmi,required this.color,required this.value1, required this.value2, required this.value3, required this.value4});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height * 4 / 5;
    final double radius = min(size.width, size.height) * 3 / 5;

    final Paint paint1 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final Paint paint2 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final Paint paint3 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      pi, 
      pi / 3, 
      false, 
      paint1,
    );

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      pi + pi / 3, 
      pi / 3, 
      false, 
      paint2,
    );

    
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      pi + 2 * pi / 3, 
      pi / 3, 
      false,
      paint3,
    );
    drawCenterText(canvas, 'BMI', centerX, centerY-40,Colors.black);
    drawCenterText(canvas, '$bmi', centerX, centerY-15, color, 25);
    drawCenterText(canvas, '$value1', centerX-100, centerY, Colors.black, 10);
    drawCenterText(canvas, '$value2', centerX-45, centerY-90, Colors.black, 10);
    drawCenterText(canvas, '$value3', centerX+45, centerY-90, Colors.black, 10);
    drawCenterText(canvas, '$value4', centerX+100, centerY, Colors.black, 10);
    double theta = pi;
    if(bmi <= value1) theta = pi;
    else if(bmi <= value2) theta = ((2*pi)/3) + (pi/3) - (pi / 3) * ((bmi - value1) / (value2 - value1));
    else if(bmi <= value3) theta = (pi/3) +(pi/3)-(pi / 3) * ((bmi - value2) / (value3 - value2));
    else if(bmi <= value4) theta = (pi/3) - ((pi / 3) * ((bmi - value3) / (value4 - value3)));
    else theta = 0;
    final double circleX = centerX + radius * cos(theta);
    final double circleY = centerY - radius * sin(theta); 
    final Paint circlePaint = Paint()
      ..color = bmi < value2?Colors.blue:bmi<value3?Colors.green:Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(circleX, circleY), 10.0, circlePaint);  
  }
  
  void drawCenterText(Canvas canvas, String text, double centerX, double centerY,Color color,[double fontsz = 16]) {
    TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontsz),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    painter.paint(canvas, Offset(centerX - painter.width / 2, centerY - painter.height / 2));
  }

 


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



