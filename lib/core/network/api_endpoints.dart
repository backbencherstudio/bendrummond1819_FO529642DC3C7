class ApiEndpoints {
  static const String baseUrl =
      "https://elections-tattoo-entity-surname.trycloudflare.com/api";
  //===================== auth ApiEndpoints ===========================//
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String switchRole = '/auth/switch-role';
  static const String verifyMail = '/auth/verify-email';
  static const String resendOtp = '/auth/resend-verification-email';
  static const String loadUser = '/auth/me';
  static const String updateProfile = '/auth/update';
  static const String forgetPassword = '/auth/forgot-password';
  static const String verifyResetOtp = '/auth/verify-email';
  static const String resetPassword = '/auth/reset-password';
  static const String logout = '/auth/logout';
  static const String createAndagetJob = '/jobs';

  //========================set-up ApiEndpoints=========================//
  static const String setUp = '/set-up';
  static const String addNewGoal = '/set-up/add-new-goal';
  static const String addBill = '/set-up/add-bill';
  static const String debts = '/set-up/debts';
  static const String savingGoals = '/set-up/saving-goals';
  static const String monthlyBills = '/set-up/monthly-bills';
  static const String payIncomes = '/set-up/pay-incomes';
  static String billById(String id) => '/set-up/bills/$id';
  static String savingGoalById(String id) => '/set-up/saving-goals/$id';
  static String deletSavingGoalById(String id) => '/set-up/saving-goals/$id';
  static String billForPatch(String id) => '/set-up/bill/$id';
  static String incomeForPatch(int id) => '/set-up/income/$id';
}
