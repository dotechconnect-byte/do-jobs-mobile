import '../models/transaction_model.dart';

class MockTransactions {
  static final List<TransactionModel> transactions = [
    TransactionModel(
      id: '1',
      title: 'Payment from Fashion Outlet Mall',
      date: 'Oct 28, 2025',
      amount: 148.00,
      status: 'completed',
      type: 'incoming',
      jobId: 'job_1',
    ),
    TransactionModel(
      id: '2',
      title: 'Payment from QuickShip Logistics',
      date: 'Oct 25, 2025',
      amount: 176.00,
      status: 'completed',
      type: 'incoming',
      jobId: 'job_2',
    ),
    TransactionModel(
      id: '3',
      title: 'Bank Transfer to ****4532',
      date: 'Oct 20, 2025',
      amount: 500.00,
      status: 'completed',
      type: 'withdrawal',
    ),
    TransactionModel(
      id: '4',
      title: 'Payment from City Cafe',
      date: 'Oct 18, 2025',
      amount: 128.00,
      status: 'completed',
      type: 'incoming',
      jobId: 'job_3',
    ),
    TransactionModel(
      id: '5',
      title: 'Payment from Premier Events',
      date: 'Nov 1, 2025',
      amount: 325.00,
      status: 'completed',
      type: 'incoming',
      jobId: 'job_4',
    ),
  ];
}
