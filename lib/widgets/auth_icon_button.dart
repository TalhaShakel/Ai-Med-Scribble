import 'package:flutter/material.dart';

class AuthIconButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
    final String iconPath;
  const AuthIconButton({
    Key? key,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    required this.iconPath,
    this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final screenWidth =MediaQuery.of(context).size.width;
    final screenHeight =MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child:ElevatedButton.icon(
         style: ElevatedButton.styleFrom(
                        backgroundColor:backgroundColor, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        elevation: 15.0,
                      ),
  onPressed: function,
  icon: Padding(
    padding:  EdgeInsets.symmetric(horizontal:screenWidth * 0.04 ),
    child: Image.asset(iconPath),
  ),
  label:  SizedBox(
    width: screenWidth * 0.2,
    child: Text(
                          text,
                          style: TextStyle(fontSize: 12,color: textColor),
                        ),
  ),// <-- Text
),
      
      
      
       
                  
    );
  }
}