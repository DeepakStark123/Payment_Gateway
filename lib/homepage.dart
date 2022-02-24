import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Razorpay razorpay;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }
  
  @override
  void despose(){
    razorpay.clear();
    super.dispose();
  }
  
  void openCheckout(){
    var options = {
      "key" : "rzp_test_cJQLaO6cvhPZrr",
      "amount" : num.parse(textEditingController.text)*100,
      "name" : "Sample App",
      "description" : "Payment for the some random product",
      "prefill" : {
        "contact" : "9310231614",
        "email" : "deepakdeveloper@gmail.com"
      },
      "external" : {
        "wallets" : ["paytm"]
       }
    };
    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }
  void handlePaymentSuccess(){
    print('Payment Success');
  }
  void handlePaymentError(){
    print('Payment Error');
  }
  void handleExternalWallet(){
    print('External Wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Gateway integration'),),
      body: Container(
          padding: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               const Text('Enter your Amount',style: TextStyle(fontSize:25,fontWeight:FontWeight.bold),),
               const SizedBox(height: 10,),
               TextField(
                 controller: textEditingController,
                  decoration:const InputDecoration(border: OutlineInputBorder(),labelText: 'Amount'),
                ),
               const SizedBox(height: 15,),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      openCheckout();
                    },
                    child: const Text('Pay Now')),
                ),
          ],
        ),
      ),
    );
  }
}