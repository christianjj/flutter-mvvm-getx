import 'package:flutter/material.dart';
import 'package:flutter_restapi/presentation/forgot_password/forgotpassword_viewmodel.dart';
import 'package:flutter_restapi/presentation/resources/color_manager.dart';
import 'package:flutter_restapi/presentation/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/dependecy_injection.dart';
import '../base/common/state_renderer/state_renderer.impl.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel = instance<
      ForgotPasswordViewModel>();
  final TextEditingController _textEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _textEmailController.addListener(() {
      _viewModel.setEmail(_textEmailController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context,_getContentWidget(),
                  () {
                _viewModel.forgotPassword();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }


  Widget _getContentWidget() {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: ColorManager.primary,
      ),
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageAssets.onboarding_logo1),
            SizedBox(height: AppSize.s20),
            Padding(padding: const EdgeInsets.only(
                left: AppPadding.p20, right: AppPadding.p20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputEmailText,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _textEmailController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError
                        ),
                      );


                    },

                  ),
                ),
              )

            ),
            SizedBox(height: AppPadding.p20),
            Padding(padding: const EdgeInsets.only(
                left: AppPadding.p20, right: AppPadding.p20
            ),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputEmailValid,
              builder: (context, snapshot) {
                return SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                        _viewModel.forgotPassword();
                      }
                          : null,
                        child: const Text(AppStrings.loading)),
                );
              },
            )),



          ],
        ),
      ),
    );
  }

}

