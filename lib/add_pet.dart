import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_application_1/storage_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddPetProfile extends StatefulWidget {
  const AddPetProfile({Key? key}) : super(key: key);

  @override
  State<AddPetProfile> createState() => _AddPetProfileState();
}

class _AddPetProfileState extends State<AddPetProfile> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final String petCategory;
  String? petName;
  String? petAge;
  String? petGender;
  String? emailAddress;
  String? ownerName;
  String? description;
  String? petLocation;
  String? petBreed;
  String? mobileNumber;
  String? dropdownValueCategory;
  String? dropdownValueGender;

  File? petImageFile;
  String? imageURL;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Please choose an option"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _getFromCamera();
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.camera,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          "Camera",
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _getFromGallery();
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.image,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          "Gallery",
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  void getCategory(String dropdownValueCategory) {
    petCategory = dropdownValueCategory;
    if (kDebugMode) {
      print(petCategory);
    }
  }

  void getGender(String dropdownValueGender) {
    petGender = dropdownValueGender;
    if (kDebugMode) {
      print(petGender);
    }
  }

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

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        petImageFile = File(croppedImage.path);
      });
    }
  }

  createData() async {
    if (kDebugMode) {
      print("Created");
    }

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Pets").doc();

    //Map
    Map<String, dynamic> myPets = {
      "Category": dropdownValueCategory,
      "Name": petName,
      "Age": petAge,
      "Breed": petBreed,
      "Gender": dropdownValueGender,
      "Location": petLocation,
      "Description": description,
      "Owner name": ownerName,
      "Mobile number": mobileNumber,
      "Email address": emailAddress,
      //"id": ;
    };

    documentReference.set(myPets).whenComplete(() {
      if (kDebugMode) {
        print("$petName created");
      }
    });

    //   List<String> docIDs = [];

    // //get docIDs
    // Future getDocId() async{
    //   await FirebaseFirestore.instance.collection('Pets').get().then(
    //     // ignore: avoid_function_literals_in_foreach_calls
    //     (snapshot) => snapshot.docs.forEach((element) {
    //       if (kDebugMode) {
    //         print(element.reference);
    //         docIDs.add(element.reference.id);
    //       }
    //     })
    //   );
    // }
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Pets").doc(petName);
    documentReference.get().then((datasnapshot) {
      if (kDebugMode) {
        print(datasnapshot.data());
      }
    });

    FirebaseFirestore.instance.collection('Pets')
      .get().then<dynamic>((DocumentSnapshot snapshot) async
      {
        petName = snapshot.get('Name');
        
      } as FutureOr Function(QuerySnapshot<Map<String, dynamic>> value));
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Pets").doc(petName);

    //Map
    Map<String, dynamic> myPets = {
      "Category": dropdownValueCategory,
      "Name": petName,
      "Age": petAge,
      "Breed": petBreed,
      "Gender": dropdownValueGender,
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

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
        backgroundColor: const Color.fromARGB(95, 248, 244, 244),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                _showImageDialog();
              },

              //Pet Image
              child: Center(
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: petImageFile == null
                      ? const AssetImage("images/petAvatar.jpg")
                      : Image.file(petImageFile!).image,
                ),
                // ElevatedButton(
                //   onPressed: () async{
                //     final results = await FilePicker.platform.pickFiles(
                //       allowMultiple: false,
                //       type: FileType.custom,
                //       allowedExtensions: ['png', 'jpg', 'jpeg'],
                //     );

                //     if(results == null){
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('No file selected.'),),
                //       );
                //       return;
                //     }

                //     final path = results.files.single.path!;
                //     final fileName = results.files.single.name;

                //     storage
                //       .uploadFile(path, fileName)
                //       .then((value) => const Text('Done'));

                //     // if (kDebugMode) {
                //     //   print(path);
                //     // }
                //     // if (kDebugMode) {
                //     //   print(fileName);
                //     // }
                //   },
                // child: const Text('Upload your pet image'),
                // ),
              ),
            ),
            const SizedBox(height: 30),

            //Pet Category
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField2(
                focusColor: Colors.white,
                focusNode: null,

                buttonSplashColor: Colors.deepPurple,
                itemSplashColor: Colors.deepPurple,
                selectedItemHighlightColor: Colors.lightGreen,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  labelText: '  Select your pet category',
                  prefixIcon: const Icon(
                    Icons.category_rounded,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                ),

                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.deepPurple,
                ),
                iconSize: 30,
                buttonHeight: 60,

                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                value: dropdownValueCategory,

                items: <String>['Dog', 'Cat', 'Rabbit', 'Hamster']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      //style: const TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),

                // Step 5.

                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValueCategory = newValue!;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(
                    Icons.pets_rounded,
                    color: Colors.deepPurple,
                    size: 20,
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(
                    Icons.piano,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                  labelText: 'Age',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Pet gender Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField2(
                focusColor: Colors.white,
                focusNode: null,
                buttonSplashColor: Colors.deepPurple,
                itemSplashColor: Colors.deepPurple,
                selectedItemHighlightColor: Colors.lightGreen,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  labelText: '  Gender',
                  prefixIcon: const Icon(
                    Icons.category_rounded,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.deepPurple,
                ),
                iconSize: 30,
                buttonHeight: 60,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                value: dropdownValueGender,
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValueGender = newValue!;
                  });
                },
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(
                    Icons.category_rounded,
                    color: Colors.deepPurple,
                    size: 20,
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on_rounded,
                    color: Colors.deepPurple,
                    size: 20,
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(
                    Icons.description_rounded,
                    color: Colors.deepPurple,
                    size: 20,
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(
                    Icons.person_2_rounded,
                    color: Colors.deepPurple,
                    size: 20,
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
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.call,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                    color: Colors.deepPurple,
                    size: 20,
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
                onTap: () async { 
                  if(petName == null)
                  {
                    Fluttertoast.showToast(msg: "Please enter name of your pet");
                    return;
                  }
                  if(petAge == null)
                  {
                    Fluttertoast.showToast(msg: "Please enter age of your pet");
                    return;
                  }
                  if(petLocation == null)
                  {
                    Fluttertoast.showToast(msg: "Please enter location of your pet");
                    return;
                  }
                  if(petBreed == null)
                  {
                    Fluttertoast.showToast(msg: "Please enter breed of your pet");
                    return;
                  }
                  // if(petImageFile == null)
                  // {
                  //   Fluttertoast.showToast(msg: "Please add image of your pet");
                  //   return;
                  // }
                  if(dropdownValueCategory == null)
                  {
                    Fluttertoast.showToast(msg: "Please choose type of your pet");
                    return;
                  }
                  if(dropdownValueGender == null)
                  {
                    Fluttertoast.showToast(msg: "Please choose gender of your pet");
                    return;
                  }
                  try{
                    final ref = FirebaseStorage.instance.ref().child('petImages').child('${DateTime.now()}.jpg');
                    await ref.putFile(petImageFile!);
                    imageURL = await ref.getDownloadURL();
                    
                  
              
                    final  uid0 = FirebaseFirestore.instance.collection("Pets").doc();
                    //FirebaseFirestore.instance.collection("Pets").doc();
                    FirebaseFirestore.instance.collection('Pets').doc(uid0 as String?).set({
                      'id': uid0,
                      'userImage': imageURL,
                    });
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  }
                  catch(error)
                  {
                    Fluttertoast.showToast(msg: error.toString());
                  }
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

            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

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
