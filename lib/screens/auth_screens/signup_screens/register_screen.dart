import 'dart:io';

import 'package:agri_trade/controller/controllers.dart';
import 'package:agri_trade/screens/auth_screens/auth_service.dart';
import 'package:agri_trade/screens/auth_screens/signup_screens/verify_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _cnic = TextEditingController();
  final _ph = TextEditingController();
  final _address = TextEditingController();
  final _password = TextEditingController();

  bool loginAsFarmerFlag = false;
  bool agreeTo = false;
  bool showPassword = true;
  bool imageUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 62),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's create your account",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        try {
                          print('Camera Open');
                          final image = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 70,
                              maxHeight: 512,
                              maxWidth: 512);
                          imageUploading = true;
                          if (image != null) {
                            print('uploadImage called');
                            final ref = FirebaseStorage.instance
                                .ref('Users/Images/Profile/')
                                .child(image.name);
                            await ref.putFile(File(image.path));
                            final imageUrl = await ref.getDownloadURL();
                            print('$imageUrl');


                            print(
                                'Congratulations Your profile picture has been updated');
                          }
                          imageUploading = false;
                        } catch (e) {
                          print('Error: $e');
                        } finally {

                          imageUploading = false;
                        }
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.network(
                          'https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Form fields (as in previous code)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: "First Name",
                        ),
                        controller: _fname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: "Last Name",
                        ),
                        controller: _lname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Username field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "User Name",
                    prefixIcon: Icon(Iconsax.user_edit),
                  ),
                  controller: _username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                    prefixIcon: Icon(Iconsax.activity),
                  ),
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CNIC field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "CNIC Number",
                    prefixIcon: Icon(Iconsax.card),
                  ),
                  controller: _cnic,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter CNIC number';
                    }
                    if (!RegExp(r'^\d{13}$').hasMatch(value)) {
                      return 'CNIC must be exactly 13 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: Icon(Iconsax.call),
                  ),
                  controller: _ph,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return 'Phone number must be exactly 11 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Address field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Address",
                    prefixIcon: Icon(Iconsax.add),
                  ),
                  controller: _address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon:
                          Icon(showPassword ? Iconsax.eye_slash : Iconsax.eye),
                    ),
                  ),
                  obscureText: showPassword,
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Login as Farmer checkbox
                Row(
                  children: [
                    Checkbox(
                        value: loginAsFarmerFlag,
                        onChanged: (value) {
                          setState(() {
                            loginAsFarmerFlag = value!;
                          });
                        }),
                    Text(
                      "Sign Up as Farmer",
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),

                // Privacy Policy checkbox
                Row(
                  children: [
                    Checkbox(
                        value: agreeTo,
                        onChanged: (value) {
                          setState(() {
                            agreeTo = value!;
                          });
                        }),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "I Agree to ",
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            text: "Privacy Policy",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    color: Colors.green)),
                        TextSpan(
                            text: " and ",
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            text: "Condition",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.green,
                                    decoration: TextDecoration.underline))
                      ])),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // Create Account button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && agreeTo) {
                        authController.signUp(
                          email: _email.text,
                          password: _password.text,
                          name: _username.text,
                          isFarmer: loginAsFarmerFlag,
                          cnic: _cnic.text,
                          address: _address.text,
                          phone: _ph.text,
                        );
                      } else if (!agreeTo) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please agree to Privacy Policy and Conditions'),
                          ),
                        );
                      }
                    },
                    child: const Text("Create Account"),
                  ),
                ),
                const SizedBox(height: 24),

                // Divider with "Or Sign Up With" text
                // Row(
                //   children: [
                //     const Flexible(
                //       child: Divider(
                //         color: Colors.grey,
                //         thickness: 0.5,
                //         indent: 60,
                //         endIndent: 5,
                //       ),
                //     ),
                //     // Text(
                //     //   "Or Login With",
                //     //   style: Theme.of(context).textTheme.labelMedium,
                //     // ),
                //     const Flexible(
                //       child: Divider(
                //         color: Colors.grey,
                //         thickness: 0.5,
                //         indent: 5,
                //         endIndent: 60,
                //       ),
                //     )
                //   ],
                // ),
                // const SizedBox(height: 24),

                // // Social login buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(100),
                //         border: Border.all(color: Colors.grey),
                //       ),
                //       child: IconButton(
                //           onPressed: () {
                //             if (agreeTo) {
                //               authController.googleLogIn();
                //             } else if (!agreeTo) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                   content: Text(
                //                       'Please agree to Privacy Policy and Conditions'),
                //                 ),
                //               );
                //             }
                //           },
                //           icon: const Image(
                //             height: 24,
                //             width: 24,
                //             image: AssetImage(
                //                 "assets/brand_artworks/google-logo.png"),
                //           )),
                //     ),
                //     const SizedBox(width: 24),
                //     Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(100),
                //         border: Border.all(color: Colors.grey),
                //       ),
                //       child: IconButton(
                //           onPressed: () {},
                //           icon: const Image(
                //             height: 24,
                //             width: 24,
                //             image: AssetImage(
                //                 "assets/brand_artworks/facebook-logo.png"),
                //           )),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signup() async {
    if (_formKey.currentState!.validate() && agreeTo) {
      final user = await _auth.createUserWithEmailAndPassword(
          _email.text, _password.text);

      if (user != null) {
        log("User Created Successfully");
        Get.to(const VerifyScreen());
      }
    }
  }
}
