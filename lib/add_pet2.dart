import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddPetProfile2 extends StatefulWidget {
  const AddPetProfile2({Key? key}) : super(key: key);

  @override
  State<AddPetProfile2> createState() => _AddPetProfileState();
}

class _AddPetProfileState extends State<AddPetProfile2> {
  /*
  //text controllers
  final _petnameController = TextEditingController();
  final _petageController = TextEditingController();
  final _petbreedController = TextEditingController();
  final _petlocationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ownernameController = TextEditingController();
  final _mobilenoController = TextEditingController();
  final _emailaddressController = TextEditingController();

  @override
  void dispose() {
    _petnameController.dispose();
    _petageController.dispose();
    _petbreedController.dispose();
    _petlocationController.dispose();
    _descriptionController.dispose();
    _ownernameController.dispose();
    _mobilenoController.dispose();
    _emailaddressController.dispose();
  }

  Future addPet() async {
    await FirebaseAuth.instance.signInAnonymously();
  
                
    addPetDetails(
      _petnameController.text.trim(),
      int.parse(_petageController.text.trim()),
      _petbreedController.text.trim(),
      _petlocationController.text.trim(),
      _descriptionController.text.trim(),
      _ownernameController.text.trim(),
      int.parse(_mobilenoController.text.trim()),
      _emailaddressController.text.trim(),
    );
  }

  Future addPetDetails(
      String petName,
      int petAge,
      String petBreed,
      String petLocation,
      String description,
      String ownerName,
      int mobileNumber,
      String emailAddress) async {
    await FirebaseFirestore.instance.collection('Pets').add({
      'Name': petName,
      'Age': petAge,
      'Breed': petBreed,
      'Location': petLocation,
      'Description': description,
      'Owner name': ownerName,
      'Mobile number': mobileNumber,
      'Email address': emailAddress,
    });
  }
*/
  late String petName;
  late String petAge;
  late String emailAddress;
  late String ownerName;
  late String description;
  late String petLocation;
  late String petBreed;
  late String mobileNumber;

  void getName(String petName) {
    this.petName = petName;
    if (kDebugMode) {
      print(this.petName);
    }
  }

  void getAge(String petAge) {
    this.petAge = petAge;
    if (kDebugMode) {
      print(this.petAge);
    }
  }

  void getEmailAddress(String emailAddress) {
    this.emailAddress = emailAddress;
    if (kDebugMode) {
      print(this.emailAddress);
    }
  }

  void getMobileNumber(String mobileNumber) {
    this.mobileNumber = mobileNumber;
    if (kDebugMode) {
      print(this.mobileNumber);
    }
  }

  void getOwnerName(String ownerName) {
    this.ownerName = ownerName;
    if (kDebugMode) {
      print(this.ownerName);
    }
  }

  void getDescription(String description) {
    this.description = description;
    if (kDebugMode) {
      print(this.description);
    }
  }

  void getLocation(String petLocation) {
    this.petLocation = petLocation;
    if (kDebugMode) {
      print(this.petLocation);
    }
  }

  void getBreed(String petBreed) {
    this.petBreed = petBreed;
    if (kDebugMode) {
      print(this.petBreed);
    }
  }

  createData() {
    if (kDebugMode) {
      print("Created");
    }

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Pets").doc(petName);

    //Map
    Map<String, dynamic> myPets = {
      "Name": petName,
      "Age": petAge,
      "Breed": petBreed,
      "Location": petLocation,
      "Description": description,
      "Owner name": ownerName,
      "Mobile number": mobileNumber,
      "Email address": emailAddress,
    };

    documentReference.set(myPets).whenComplete(() {
      if (kDebugMode) {
        print("$petName created");
      }
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Pets").doc(petName);
    documentReference.get().then((datasnapshot) {
      if (kDebugMode) {
        print(datasnapshot.data());
      }
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Pets").doc(petName);

    //Map
    Map<String, dynamic> myPets = {
      "Name": petName,
      "Age": petAge,
      "Breed": petBreed,
      "Location": petLocation,
      "Description": description,
      "Owner name": ownerName,
      "Mobile number": mobileNumber,
      "Email address": emailAddress,
    };

    documentReference.set(myPets).whenComplete(() {
      if (kDebugMode) {
        print("$petName updated");
      }
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Pets").doc(petName);

    documentReference.delete().whenComplete(() {
      if (kDebugMode) {
        print("$petName deleted");
      }
    });
  }

/*
  @override
  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        var _dropdownValue = selectedValue;
      });
    }
  }
*/
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  final List<String> petType = [
    'Cat',
    'Dog',
    'Rabbit',
    'Hamster',
  ];

  //String? selectedValue;

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //var _dropdownValue;
    return Scaffold(
        backgroundColor: const Color.fromARGB(95, 248, 244, 244),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            //Pet Category
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: '  Select your pet category',
                  ),

                  //isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,

                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  items: petType
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return ' Please select type of pet';
                    }
                  },
                   onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                ),
              ),
            ),

            //Pet name TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String petName) {
                  getName(petName);
                },
                //controller: _petnameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Pet name',
                  //labelColor: Colors.deepPurple,
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Pet age TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String petAge) {
                  getAge(petAge);
                },
                // controller: _petageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Age',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Pet sex TextField
            Form(
              //key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: '  Select Pet Gender',
                  ),

                  //isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,

                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  items: genderItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select gender.';
                    }
                  },

                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  /*
                  onSaved: (value) {
                    selectedValue = value.toString();
                    Color.fromARGB(0, 221, 221, 221);
                  },*/
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Pet breed TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String petBreed) {
                  getBreed(petBreed);
                },
                //controller: _petbreedController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Breed',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Pet Location TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String petLocation) {
                  getLocation(petLocation);
                },
                //controller: _petlocationController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Location',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Pet Description TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String description) {
                  getDescription(description);
                },
                //controller: _descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'About your pet',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Owner/NGO name TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String ownerName) {
                  getOwnerName(ownerName);
                },
                //controller: _ownernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Owner/NGO name',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Mobile number TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String mobileNumber) {
                  getMobileNumber(mobileNumber);
                },
                //controller: _mobilenoController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Mobile number',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Email address TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                onChanged: (String emailAddress) {
                  getEmailAddress(emailAddress);
                },
                //controller: _emailaddressController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Email Address',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Add pet profile button
            //Create data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  createData();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      //'Add Pet Profile',
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //Update data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  updateData();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      //'Add Pet Profile',
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //Delete data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  deleteData();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      //'Add Pet Profile',
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //Read data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  readData();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      //'Add Pet Profile',
                      'Read',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ))));
  }
}
