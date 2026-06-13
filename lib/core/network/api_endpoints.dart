class ApiEndpoints {
  static const String baseUrl =
      "https://officially-motel-savings-success.trycloudflare.com";
  static const String register = 'api/auth/register';
  static const String login = 'api/auth/login';
  static const String switchRole = 'api/auth/switch-role';
  static const String verifyMail = 'api/auth/verify-email';
  static const String resendOtp = 'api/auth/resend-verification-email';
  static const String loadUser = 'api/auth/me';
  static const String updateProfile = 'api/auth/update';
  static const String forgetPassword = 'api/auth/forgot-password';
  static const String verifyResetOtp = 'api/auth/verify-email';
  static const String resetPassword = 'api/auth/reset-password';
  static const String logout = 'api/auth/logout';
  static const String createAndagetJob = 'api/jobs';
  static const String setUp = 'api/set-up';
  static const String addNewGoal = 'api/set-up/add-new-goal';
  static const String addBill = 'api/set-up/add-bill';
  static const String debts = 'api/set-up/debts';
  static const String savingGoals = 'api/set-up/saving-goals';
  static const String monthlyBills = 'api/set-up/monthly-bills';
  static const String payIncomes = 'api/set-up/pay-incomes';
  static String billById(int id) => 'api/set-up/bills/$id';
  static String savingGoalById(int id) => 'api/set-up/saving-goals/$id';
  static String billForPatch(int id) => 'api/set-up/bill/$id';
  static String incomeForPatch(int id) => 'api/set-up/income/$id';
}
