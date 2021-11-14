import 'package:flutter/material.dart';
import 'package:gst_search/model/gst_profile.dart';
import 'package:gst_search/presenter/profile_presenter.dart';
import 'package:gst_search/view/widgets/profile_info.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with InputValidationMixin {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  GSTProfile? profile;

  bool isLoading = false;

  displayDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Okay!"),
          ),
        ],
      ),
    );
  }

  onSubmit() async {
    if (!_key.currentState!.validate()) {
      return;
    }
    _key.currentState!.save();
    setState(() {
      isLoading = true;
    });
    profile = await Provider.of<ProfilePresenter>(context, listen: false)
        .getProfile(_searchController.text.toUpperCase());
    if (profile == null) {
      displayDialog("GSTIn Not Found.");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("GST Search"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('watermark.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
          ),
        ),
        child: Column(
          children: [
            Form(
              key: _key,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 26, bottom: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "GSTIN Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        onSubmit();
                      },
                    ),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  controller: _searchController,
                  validator: (value) {
                    if (isGSTINValid(value!.toUpperCase())) {
                      return null;
                    } else {
                      return 'Enter a valid GSTIN number';
                    }
                  },
                  onFieldSubmitted: (value) {
                    onSubmit();
                  },
                ),
              ),
            ),
            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            if (!isLoading && profile != null) ProfileInfo(profile: profile)
          ],
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isGSTINValid(String number) {
    RegExp regex =
        RegExp(r'\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}');
    return regex.hasMatch(number);
  }
}
