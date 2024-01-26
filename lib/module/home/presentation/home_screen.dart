import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interactive_forms_with_rive/core/theme/app_color.dart';
import 'package:rive/rive.dart';

// To use the animation of rive you must have to import the following package of the rive .
// https://pub.dev/packages/rive/install
// To must have to add the dependencies of the above package in your app .

class RiveAnimatedSignInPageDesign extends StatefulWidget {
  const RiveAnimatedSignInPageDesign({super.key});

  @override
  State<RiveAnimatedSignInPageDesign> createState() =>
      _RiveAnimatedSignInPageDesignState();
}

final formKey = GlobalKey<FormState>();

class _RiveAnimatedSignInPageDesignState
    extends State<RiveAnimatedSignInPageDesign> {
  // We have to provide the valid email and it is used to show the excited emotion of the bear of the rive animation .
  String validEmail = "mabubakarsiddique21@gmail.com";
  String validPassword = "Abub@kar786";

  /// input form controller
  ///
  // Now we have to declare the focus node and the text editing controller for both of the email and the password that are used for switch the focus and the text of both field's respectively .
  //
  FocusNode emailFocusNode = FocusNode();
  late TextEditingController emailController;

  FocusNode passwordFocusNode = FocusNode();
  late TextEditingController passwordController;

  /// rive controller and input
  StateMachineController? controller;

// Now we have to declare all of the all of the possible action's that the rive animation will be show based on the condition .

  /// SMI = StateMachineInstance
  ///
  /// This is the abstraction of an instanced input
  /// from the [StateMachine]. Whenever a [StateMachineController] is created, the
  /// list of inputs in the corresponding [StateMachine] is wrapped into a set of
  /// [SMIInput] objects that ensure inputs are initialized to design-time values.

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  // In the initial state and the dispose state of the state full widget we have to initialize the email and password focus and text editing controller respectively .

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    print("Build Called Again");
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      resizeToAvoidBottomInset: true,
      // Form is used for the validation of the text form field's .
      // If you want's more information about it kindly read it from the official documentation or you may also get some of the information from my article on text form fields .

      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Text(
                "Welcome \n ENGR . MASK",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 250,
                width: 250,
                // Rive animation . asset creates a new RiveAnimation from an asset bundle .
                // Rive animation is the state full widget in the rive animation .dart library which can automatically import or added inside the above given package .

                // So, to use Rive animation in your Flutter project you will have to use the RiveAnimation class. This is a high-level widget in the Rive library(package) that plays an animation from a Rive file. Depending upon how you are accessing the Rive file, the constructors for the RiveAnimation widget change.
                // Artboards are the foundation of your composition across both design and animate mode. They act as the root of every hierarchy and allow you to define the dimensions and background colour of a scene.
                child: RiveAnimation.asset(
                  "assets/login-teddy.riv",
                  fit: BoxFit.fitHeight,
                  // List of state machines to play; none will play if not specified
                  // Here you can provide the name of the rive animation that will be given at the .
                  // StateMachines (Add intelligence to your animations)
                  // State Machines are a visual way to connect animations together and define the logic that drives the transitions. You can set transitions between animations and define their logic.
                  stateMachines: const ["Login Machine"],
                  //  Callback fired when Riveanimation has initialized
                  onInit: (artboard) {
                    //   /// The name of the artboard to use; default artboard if not specified
                    // The controller is of the state machine controller and it is the
                    /// An AnimationController which controls a StateMachine and provides access to
                    /// the inputs of the StateMachine.
                    controller = StateMachineController.fromArtboard(
                      // Art board is the class class ( Artboard extends ArtboardBase with ShapePaintContainer ) .

                      artboard,

                      /// Instance a [StateMachineController] from an [artboard] with the given
                      /// [stateMachineName]. Returns the [StateMachineController] or null if no
                      /// [StateMachine] with [stateMachineName] is found.
                      /// from rive, you can see it in rive editor
                      "Login Machine",
                    );
                    if (controller == null) return;
                    // in the art board you have to add the state machine controller .
                    artboard.addController(controller!);
                    // Now assign the value of input to the SIM Input that are declared above .
                    isChecking = controller?.findInput("isChecking");
                    numLook = controller?.findInput("numLook");
                    isHandsUp = controller?.findInput("isHandsUp");
                    trigSuccess = controller?.findInput("trigSuccess");
                    trigFail = controller?.findInput("trigFail");
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required Field";
                          } else {
                            return null;
                          }
                        },
                        focusNode: emailFocusNode,
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "User Email",
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (value) {
                          numLook?.change(value.length.toDouble());
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextFormField(
                        focusNode: passwordFocusNode,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required Field";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                        obscureText: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () async {
                          // on the click event of the button i validate the text form field's .
                          print("clicked");
                          if (formKey.currentState!.validate()) {
                            // if the form is validated then i cancel the focus of the both of the focus node's
                            emailFocusNode.unfocus();
                            passwordFocusNode.unfocus();

                            final email = emailController.text;
                            final password = passwordController.text;

                            // Now i change the state machine instance and change the emotion's based on the condition's
                            if (email == validEmail &&
                                password == validPassword) {
                              trigSuccess?.change(true);
                            } else {
                              trigFail?.change(true);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: TextButton(
                          onPressed: () {
                            trigFail?.change(true);
                          },
                          child: const Text("Forget Password")),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: TextButton(
                          onPressed: () {
                            trigSuccess?.change(true);
                          },
                          child: const Text("New User ?? ")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// In the same way you can change the emotion's or feeling's of the bear of the rive animation whenever we want's like in our above cases of the click event of the button's .
