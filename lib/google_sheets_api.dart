import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi{
  //create Credentials
  
static const _credentials=r'''
{
  "type": "service_account",
  "project_id": "truckpenny",
  "private_key_id": "4916aed6c899d82d18bb222ad5cf860766e98e7d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCkFA8q0cuU6xfD\naYVYA957JHKTbD430uCUFdjWoDRgRa3cNHRNeICATRkNjxx+23mJRZgIC0h6H08M\nYzHYPzkBJGlkpMVFGkn6w35DM3JYxfvZkBnvfpwLrwjwzLOkjwfedrPVCF/Km2lM\nzIF7ZL80X2kK8xWethXMRHgTHzOamrlwZ2M8L45rRvzSOnDK/hlLcHuUa+Zj5dvl\nQku24Yb6Lv0FbhB9aZ2ApMiQfo18/8XNSo59CF/M7z3xgPUirxJLbcP3kxiXnr9r\nUrzs3YSJdGUuOuLVDIr0qWp1nmERnQO2pkjEIYVaj/0XhBEJYYs+KQOL3ckFDMQL\nI3eFrqe/AgMBAAECggEACORWvMD+jG/VK4Trcg1Q9abQWBxJ9D0xvd9qj0RtXOOf\nJsuSRfndf5aDYLsRwJo6Uu3PmG1Wxy+ChC8Cri/MR2XmxEqIWlSwulif3hp1UZ72\nesrsF5DqpK4es5YUYjr8zS9CUwLk1hZoCtPGbJ6AHOF9etduTi9GAnpExkcu78Dp\nSqfJwaVxlVUET3EVg+y3dLR5fSKw+pFDtDX7MgCOmQIk7xnX5x/w+oA/wrqBxKQ+\nEZ0OJImLbu7CUot9rYBvNLFj2SbqVjAM5Iv+1bBzhoYOnKDgBP5UWATBcqdqP5qM\n75/SdhPuQ4P80zWyXJwR4CxjFOYg3PaZYK1ms+YSmQKBgQDSAx4QHX/URzK04vs7\nAoyhA6qerfL2Fgvbcs5zVGas0BzWrlduJqgq2jcFTFDRb4mqUQdUfTjppibjopJS\npUgln5YBNKRfnJ1CwbRJq66JV/luxY68MSk7m98dDFViXSpvbKmniWhFB2wbE7xL\nAJEqW17D9acovlz5TRCwOm8dOwKBgQDIAfq0fbhP3WYRdTywv7R5yaPT5P5rouk9\nJrhpN17dzLMIrJDhK37dFCPvZ3pd297PjHittxTT1/ZqskUvc9sEO1tcnFbdhFw0\nUw9xPDCA4JcD9VXTbDGipRctSFrgpYqvz36IojmAwU57Hrlpp8PHGaWpeVe6N8f2\nO/Belv7HTQKBgFJ6GvJlQ3CQzZ8wjU3tgGEz2WwcEJEIs3tpqR6uBOzVhp3hNkDy\nOZUqwfT4tbyquzwCOoi57QIF2LwJesGuW5k7BWRP0kYicbhn7nAIVrFltXYFbDsI\na5MXchYsY9QPlrzPxgkf8604bwJrS8WA4YHrBFqdPRrJOCZIV8d+C2lFAoGAXFYN\nmCYyYSylYontauwWNeORbtHZY3filgi6OlkFwwAt52NDv7CE8SvLK0tqgspvIwKG\n9CwBwYuCh9+lcTLbeiitFSRYNgxVRRLTnkNbYSROk9U/ukvI3n25JX6x9eR3EpOI\npyu9wGN+B/k3QD/jcpe0k3khtybpehRR9FlhZkECgYEAgx1J3XEcsKM3kMHhKoI6\nn3cXVI6NAPdJRplOxUUIVDDZxSsB9BFEEJuogvhGtlloxJ9W9xMekwQKiE1Mo5yt\nQZWIQZN6ZV4PdOouRTDxTmNv8O2ckDGVMs/22I771kLSFIn3QDbHI0EPhXFZ9V9Y\n3WbzuraWiEekAP6/uT44nZc=\n-----END PRIVATE KEY-----\n",
  "client_email": "truckpenny@truckpenny.iam.gserviceaccount.com",
  "client_id": "116101608863208340655",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/truckpenny%40truckpenny.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}


''';

//set up & connect to the spreadsheet
static final _speadsheetId='1P0Q5fGwcDZaYKlpQn7-v525pTddeD8wtyFTg7AcX2Qw';
static final _gsheets=GSheets(_credentials);
static Worksheet? _worksheet;

//some variables to keep trac of..
static int numberOfTransactions=0;
static List<List<dynamic>> currentTransactions=[];
static bool loading=true;

//initialize the spreadsheet
Future init()async{
  final ss=await _gsheets.spreadsheet(_speadsheetId);
  _worksheet =ss.worksheetByTitle('WorkSheet1');
  countRows();
}
  //count the number of notes
  static Future countRows()async{
    while ((await _worksheet!.values.value(column: 1, row: numberOfTransactions+1))!=''){
      numberOfTransactions++;
    }
    // now we know how many notes to load ,now let's load them!
    loadTransactions();
  }
   
     static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }



  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }

}