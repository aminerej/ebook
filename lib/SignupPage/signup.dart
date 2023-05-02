

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ebook/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/global_variables.dart';

class SignUp extends StatefulWidget {


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>  with TickerProviderStateMixin{

  late Animation <double> _animation;
  late AnimationController _animationController;
  final TextEditingController _fullNameController = TextEditingController(text: '');
  final TextEditingController _emailTextController = TextEditingController(text: '');
  final TextEditingController _passTextController = TextEditingController(text: '');
  final TextEditingController _phoneNumberController = TextEditingController(text: '');
  final TextEditingController _locationrController = TextEditingController(text: '');




  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _positionCPFocusNode = FocusNode();


  final _signUpFormKey = GlobalKey<FormState>();
  bool _obscureText = true ;
  File? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? imageUrl; //bch na3mlou url lel image

  @override
  void dispose() {
    _animationController.dispose();
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _phoneNumberController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _positionCPFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)

      ..addListener(() {

      })
      ..addStatusListener((animationStatus) {
        if(animationStatus == AnimationStatus.completed)
        {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
    super.initState();
  }
  void _showImageDialog() //hadha teswira 2
  {
    showDialog(
      context: context,
      builder: (context)
      {
        return AlertDialog(
          title: Text('Please choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: ()
                {
                  _getFromCamera();  //star hadha ba3ad ma tkaml l fn lkol

                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.camera, color: Colors.purple,),
                    ),
                    Text(
                        'Camera',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: ()
                {
                  _getFromGallery();

                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.image, color: Colors.purple,),
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ), //hadha 3
            ],
          ),
        );
      }
    );
  }
  void _getFromCamera()async  //HADHA 5 BCH NJIBOU TESSWIRA MEL CAMERA
  {
    XFile? pickerFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickerFile!.path);

    Navigator.pop(context);
  }
  void _getFromGallery()async  //HADHA 6 BCH NJIBOU TESSWIRA MEL gallyry
   {
    XFile? pickerFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickerFile!.path); // star hadha tzida mba3ad lfn mta3 lgasan
    Navigator.pop(context);
  }
  void _cropImage(filePath) async    //hadha7cbch nkabrou w nsaghrou f teswora
  {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath ,maxHeight: 1000, maxWidth: 1000
    );
    if (croppedImage != null) // hadha 8
    {
      setState(() {
        imageFile =  File(croppedImage.path);

      });
    }

  }
  void _submitFormOnSignUp() async //bech nakhdmou lbouton sinup
  {
    final isValid = _signUpFormKey.currentState!.validate();
    if(isValid)
    {
      if (imageFile ==null)
      {
        GlobalMethod.showErrorDialog(
          error: 'Please pick an image',
          ctx: context,
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try
      {
        await _auth.createUserWithEmailAndPassword(
          email: _emailTextController.text.trim().toLowerCase(),
          password: _passTextController.text.trim(),
        );
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        final ref = FirebaseStorage.instance.ref().child('user image').child(_uid + 'jpg');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullNameController.text,
          'email': _emailTextController.text,
          'password':_passTextController.text,
          'userImage': imageUrl,
          'phoneNumber': _phoneNumberController.text,
          'location':_locationrController.text,

          'createdAt': Timestamp.now(),
          

        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;

      }catch(error)
      {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isLoading = false;
    });

  }





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: LoginUrlImage,

            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),

          ),
          Container(
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 80),

            child: ListView(
              children: [
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: ()
                        {
                          _showImageDialog();


                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width * 0.24,
                            height: size.width*0.24,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(width: 1, color: Colors.cyanAccent),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: imageFile == null
                                ? const Icon(Icons.camera_alt_sharp , color: Colors.cyan, size: 30,)
                                : Image.file(imageFile!, fit: BoxFit.fill,),
                            ),



                            ),

                          ),
                        ),  //imagepikerawal hajja
                      const SizedBox(height: 13,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFocusNode) ,
                        keyboardType: TextInputType.name,
                        controller: _fullNameController ,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'This field is missing';
                          }
                          else
                          {
                            return null ;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.white,

                          ),

                        ),

                      ),
                      const SizedBox(height: 25,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode) ,
                        keyboardType: TextInputType.emailAddress,
                        controller:  _emailTextController ,
                        validator: (value)
                        {
                          if(value!.isEmpty || !value.contains('@'))
                          {
                            return 'This field is missing';
                          }
                          else
                          {
                            return null ;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.white,

                          ),

                        ),

                      ),
                      const SizedBox(height: 25,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(_phoneNumberFocusNode) ,
                        keyboardType: TextInputType.visiblePassword,
                        controller:   _passTextController,
                        obscureText: !_obscureText,
                        validator: (value)
                        {
                          if(value!.isEmpty || value.length < 7)
                          {
                            return 'please enter a valid password';
                          }
                          else
                          {
                            return null ;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: ()
                            {
                              setState(() {
                                _obscureText =! _obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: const Icon(Icons.lock, color: Colors.white,

                          ),

                        ),

                      ),
                      const SizedBox(height: 25,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(_positionCPFocusNode) ,
                        keyboardType: TextInputType.phone,
                        controller:   _phoneNumberController,
                        validator: (value)
                        {
                          if(value!.isEmpty || (!RegExp(r'^[0-9]+$').hasMatch(value)) )
                          {
                            return 'This field is missing';
                          }
                          else
                          {
                            return null ;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: Icon(Icons.phone, color: Colors.white,

                          ),

                        ),

                      ),
                      const SizedBox(height: 25,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode) ,
                        keyboardType: TextInputType.text,
                        controller:   _locationrController,
                        validator: (value)
                        {
                          if(value!.isEmpty )
                          {
                            return 'This field is missing';
                          }
                          else
                          {
                            return null ;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: Icon(Icons.location_on, color: Colors.white,

                          ),

                        ),

                      ),
                      const SizedBox(height: 30,),
                      _isLoading
                      ?
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          width: 30,
                          height: 0,
                          child:  const CircularProgressIndicator(),
                        ),
                      )
                      :
                      MaterialButton(
                        onPressed: ()
                        {
                          _submitFormOnSignUp();

                        },
                        color: Colors.cyan,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Padding(

                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'SignUp',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 31,),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Already have an Account?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              ),
                              const TextSpan(
                                text: '    '
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null,
                                text: 'Login',
                                style: const TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),





                    ],
                  ),
                ),
              ],
            ),


           ),

          ),
        ],

      ),

    );
  }
}