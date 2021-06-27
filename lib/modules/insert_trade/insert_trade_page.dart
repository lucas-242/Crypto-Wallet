import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:crypto_wallet/shared/widgets/custom_dropdown_button/custom_dropdown_button.dart';
import 'package:crypto_wallet/shared/widgets/custom_text_form_field/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import 'insert_trade_bloc.dart';

class InsertTradePage extends StatefulWidget {
  const InsertTradePage({Key? key}) : super(key: key);

  @override
  _InsertTradePageState createState() => _InsertTradePageState();
}

class _InsertTradePageState extends State<InsertTradePage> {
  final amountController =
      MoneyMaskedTextController(leftSymbol: '\$', decimalSeparator: ',');
  final priceController = MoneyMaskedTextController(decimalSeparator: ',');
  final dateController = MaskedTextController(mask: '00/00/0000');

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<InsertTradeBloc>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.input),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Text(
                  'Fill all the fields of the trade',
                  style: AppTextStyles.titleBoldGrey,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Operation Type:'),
                          SizedBox(width: 35),
                          Expanded(
                            child: CustomDropdownButton(
                              value: '1',
                              items: [
                                DropdownOption('Buy', '1'),
                                DropdownOption('Sell', '2'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Crypto:'),
                          SizedBox(width: 35),
                          Expanded(
                            child: CustomDropdownButton(
                              value: '1',
                              items: [
                                DropdownOption('BTC', '1'),
                                DropdownOption('ADA', '2'),
                                DropdownOption('XRP', '3')
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        labelText: 'Amount',
                        icon: Icons.plus_one,
                        keyboardType: TextInputType.number,
                        validator: bloc.validateAmount,
                        onChanged: (value) =>
                            bloc.onChange(amount: double.parse(value)),
                      ),
                      CustomTextFormField(
                        labelText: 'Trade Price',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                        validator: bloc.validatePrice,
                        onChanged: (value) =>
                            bloc.onChange(price: double.parse(value)),
                      ),
                      CustomTextFormField(
                        labelText: 'Date',
                        icon: Icons.calendar_today,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.done,
                        validator: bloc.validateDate,
                        onChanged: (value) =>
                            bloc.onChange(date: DateTime.parse(value)),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomButtons(
        primaryLabel: 'Cancel',
        secondaryLabel: 'Save',
        secondButtonColor: AppTextStyles.buttonSecondary,
      ),
    );
  }
}
