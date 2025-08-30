import 'package:donoridedrive/constants/App_constant.dart';
import 'package:flutter/material.dart';
import 'question_model.dart';

class RegistrationQuestionForm extends StatefulWidget {
  final List<RegistrationQuestion> questions;
  final Function(Map<String, String?>) onFormSubmit;

  const RegistrationQuestionForm({
    Key? key,
    required this.questions,
    required this.onFormSubmit,
  }) : super(key: key);

  @override
  _RegistrationQuestionFormState createState() => _RegistrationQuestionFormState();
}

class _RegistrationQuestionFormState extends State<RegistrationQuestionForm> {
  Map<String, String?> answers = {};

  @override
  void initState() {
    super.initState();
    
    for (var question in widget.questions) {
      answers[question.id] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8,),
            Text(
              'Before moving forward, please address a few questions.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            
            
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionCard(widget.questions[index]);
                },
              ),
            ),
            
            
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
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

  Widget _buildQuestionCard(RegistrationQuestion question) {
    return Container(
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
            question.question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: question.options.map((option) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: answers[question.id],
                    onChanged: (value) {
                      setState(() {
                        answers[question.id] = value;
                      });
                    },
                    activeColor: AppConstants.primaryColor,
                  ),
                  Text(option),
                  SizedBox(width: 40),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  
}