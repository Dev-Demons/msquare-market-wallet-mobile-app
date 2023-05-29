class EndPoints {
  static const productionBaseUrl = "https://api.msq.market";
  static const sandboxBaseUrl = 'https://api.dev.msq.market';
  static const stgBaseUrl = 'https://api.stg.msq.market';

  // static const baseUrl = productionBaseUrl;
  static const baseUrl = sandboxBaseUrl;

  // static const baseUrl = stgBaseUrl;
  static const signUp = '$baseUrl/signup';
  static const fetchOrdersData = '$baseUrl/orders/getAllOrders';
  static const fetchUser = '$baseUrl/get_user';
  static const fetchUserToken = '$baseUrl/get_user_token';
  static const userCredential = '$baseUrl/user_creds';
  static const deleteUser = "$baseUrl/delete_user";
  static const updatePassword = "$baseUrl/update_password";
  static const announcement = "$baseUrl/announcement";

  // Orders Test API Endpoints
  static const getAllOrders = '$baseUrl/p2p-orders/getAllOrders';
  static const getMyOrders = '$baseUrl/p2p-orders/getMyOrders';
  static const buySellOrders = '$baseUrl/p2p-orders/buySellOrders';
  static const ordersCompleted = '$baseUrl/p2p-orders/orderCompleted';
  static const deleteOrder = '$baseUrl/p2p-orders/deleteOrder';
  static const validateUser = '$baseUrl/validate_user_creds';

  // Wallet API Endpoint
  static const getTransaction = "$baseUrl/wallet/get_request";
  static const sendTransaction = "$baseUrl/wallet/complete_request";
  static const establishConnection = "$baseUrl/wallet/establish_connection";

  // Transaction API Endpoint
  static const msqpToMsq = "$baseUrl/transaction/msqpToMsq";
  static const msqToMsqp = "$baseUrl/transaction/msqToMsqp";
  static const msqxToMsqxp = "$baseUrl/transaction/msqxToMsqxp";
  static const msqxpToMsqx = "$baseUrl/transaction/msqxpToMsqx";
  static const getHistory = "$baseUrl/transaction/getTransactions";

  // Added .................
  static const getPrices = "$baseUrl/get_prices";
  static const refreshBalanceRPA = "$baseUrl/refresh_balance_rpa";

  /// API Endpoints related to User Cards

  static const getCards = "$baseUrl/get_cards";
  static const addCard = "$baseUrl/register_card";
  static const getCardCompanies = "$baseUrl/get_companies";

  // super save
  static const superSaveDashboard = "$baseUrl/super-save/super_save_dashboard";
  static const reserveHistory = "$baseUrl/reserve";
  static const userBankAccounts = "$baseUrl/super-save/my_bank_accounts";
  static const addBank = "$baseUrl/super-save/add_bank_account";
  static const setMainBankAccount = "$baseUrl/super-save/set_main_bank_account";
  static const superSaveDeleteBank = "$baseUrl/super-save/delete_bank_account";
  static const withdrawalUser = "$baseUrl/withdrawal-user";
  static const getCumulativeAmount =
      "$baseUrl/super-save/get_cumulative_amount";
  static const superSaveRequest = "$baseUrl/super-save/super_save_request";
  static const superSaveTransactionRegistration =
      "$baseUrl/super-save/super_save_transaction_registration";
  static const superSaveUploadImage =
      "$baseUrl/super-save/super_save_image_upload";
  static const superSaveParticipate =
      "$baseUrl/super-save/super_save_participate";
  static const superSaveHistory = "$baseUrl/super-save/get_super_save_history";
  static const superSaveParticipationHistory =
      "$baseUrl/super-save/get_total_participation_history";
  static const superSaveParticipationDetail =
      "$baseUrl/super-save/get_super_save_details";
  static const superSaveUserMainBank =
      "$baseUrl/super-save/get_main_bank_account";
  static const superSaveGeneratePhoneToken =
      "$baseUrl/super-save/generate_phone_verification_token";
}
