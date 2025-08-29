import 'package:donoridedrive/constants/App_constant.dart';
import 'package:flutter/material.dart';

class RegistrationQuestionForm extends StatefulWidget {
  @override
  _RegistrationQuestionFormState createState() => _RegistrationQuestionFormState();
}

class _RegistrationQuestionFormState extends State<RegistrationQuestionForm> {
  String? driverRegistration;
  String? nameInCertificate;
  String? addressInDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black54),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'Before moving forward, please address a few questions.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            
            
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Do you want to register as a driver also?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: driverRegistration,
                        onChanged: (value) {
                          setState(() {
                            driverRegistration = value;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                      ),
                      Text('Yes'),
                      SizedBox(width: 40),
                      Radio<String>(
                        value: 'No',
                        groupValue: driverRegistration,
                        onChanged: (value) {
                          setState(() {
                            driverRegistration = value;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                      ),
                      Text('No'),
                    ],
                  ),
                ],
              ),
            ),
            
            
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. Is your name mentioned in the registration certificate as the vehicle owner',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: nameInCertificate,
                        onChanged: (value) {
                          setState(() {
                            nameInCertificate = value;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                      ),
                      Text('Yes'),
                      SizedBox(width: 40),
                      Radio<String>(
                        value: 'No',
                        groupValue: nameInCertificate,
                        onChanged: (value) {
                          setState(() {
                            nameInCertificate = value;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                      ),
                      Text('No'),
                    ],
                  ),
                ],
              ),
            ),
            
            
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. Is your current local address mentioned in the Driving License or in the Aadhar Document?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: addressInDocument,
                        onChanged: (value) {
                          setState(() {
                            addressInDocument = value;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                      ),
                      Text('Yes'),
                      SizedBox(width: 40),
                      Radio<String>(
                        value: 'No',
                        groupValue: addressInDocument,
                        onChanged: (value) {
                          setState(() {
                            addressInDocument = value;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                      ),
                      Text('No'),
                    ],
                  ),
                ],
              ),
            ),
            
            Spacer(),
            
            
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  
                  _handleFormSubmission();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save & Proceed',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _handleFormSubmission() {
    
    Map<String, String?> formData = {
      'driverRegistration': driverRegistration,
      'nameInCertificate': nameInCertificate,
      'addressInDocument': addressInDocument,
    };
    
    
    print('Form Data: $formData');
    
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Submitted'),
          content: Text('Your responses have been saved successfully!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

