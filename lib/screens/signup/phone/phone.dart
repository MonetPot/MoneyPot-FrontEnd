import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_pot/const/gradient.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final TextEditingController phoneController = TextEditingController();
  late TextEditingController countryController;

  // List of countries with their flag icon paths and dial codes
  final List<Map<String, dynamic>> countries = [
    {"name": "United States", "flag": "assets/icons/us.svg", "code": "+1"},
    {"name": "Canada", "flag": "assets/icons/can.svg", "code": "+1"},
    {"name": "India", "flag": "assets/icons/ind.svg", "code": "+91"},
    // Add other countries here
  ];

  // Initially selected country
  // Map<String, dynamic> selectedCountry;
  late Map<String, dynamic> selectedCountry = countries.first;

  @override
  void initState() {
    super.initState();
    // selectedCountry = countries.first;
    countryController = TextEditingController(text: selectedCountry['code']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        decoration: const BoxDecoration(gradient: SIGNUP_BACKGROUND),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/phone.png",
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 25),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We need to register your phone to get started!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, dynamic>>(
                        value: selectedCountry,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCountry = newValue!;
                            countryController.text = selectedCountry['code'];
                          });
                        },
                        items: countries.map((country) {
                          return DropdownMenuItem(
                            value: country,
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  country['flag'],
                                  width: 32,
                                  height: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(country['code']),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'verify');
                  },
                  child: const Text("Send the code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
