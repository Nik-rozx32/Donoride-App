class RegistrationQuestion {
  final String id;
  final String question;
  final List<String> options;

  RegistrationQuestion({
    required this.id,
    required this.question,
    required this.options,
  });
}

class RegistrationQuestions {
  static List<RegistrationQuestion> getQuestions() {
    return [
      RegistrationQuestion(
        id: 'driverRegistration',
        question: '1. Do you want to register as a driver also?',
        options: ['Yes', 'No'],
      ),
      RegistrationQuestion(
        id: 'nameInCertificate',
        question: '2. Is your name mentioned in the registration certificate as the vehicle owner',
        options: ['Yes', 'No'],
      ),
      RegistrationQuestion(
        id: 'addressInDocument',
        question: '3. Is your current local address mentioned in the Driving License or in the Aadhar Document?',
        options: ['Yes', 'No'],
      ),
    ];
  }
}