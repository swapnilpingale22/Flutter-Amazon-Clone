import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_textfield.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/address/services/address_services.dart';
import 'package:flutter_amazon_clone/payment_configurations.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _addressFormKey = GlobalKey<FormState>();

  String adddressToBeUsed = '';

  List<PaymentItem> paymentItems = [];

  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: adddressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: adddressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
    Navigator.pop(context);
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: adddressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: adddressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
    Navigator.pop(context);
  }

  void payPressed(String addressFromProvider) {
    adddressToBeUsed = '';

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        adddressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please fill all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      adddressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error. Address is empty!');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    var applePayButton = ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(
        defaultApplePay,
      ),
      onPaymentResult: onApplePayResult,
      paymentItems: paymentItems,
      style: ApplePayButtonStyle.black,
      width: double.infinity,
      height: 50,
      type: ApplePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15),
      loadingIndicator: const Center(child: Loader()),
      onPressed: () => payPressed(address),
    );

    var googlePayButton = GooglePayButton(
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultGooglePay),
      onPaymentResult: onGooglePayResult,
      paymentItems: paymentItems,
      width: double.infinity,
      height: 50,
      type: GooglePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15),
      loadingIndicator: const Center(child: Loader()),
      onPressed: () => payPressed(address),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House No, Building',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: GlobalVariables.defaultPadding),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: GlobalVariables.defaultPadding),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: GlobalVariables.defaultPadding),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: GlobalVariables.defaultPadding),
                  ],
                ),
              ),
              if (Platform.isIOS) applePayButton else googlePayButton
            ],
          ),
        ),
      ),
    );
  }
}
