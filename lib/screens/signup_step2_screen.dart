import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_indicator.dart';
import '../utils/validators.dart';
import 'signup_step3_screen.dart';
import '../models/user_model.dart';
import 'login_screen.dart';

class SignUpStep2Screen extends StatefulWidget {
  final UserModel? existingUserData;
  final String password;

  const SignUpStep2Screen({
    super.key,
    this.existingUserData,
    required this.password,
  });

  @override
  State<SignUpStep2Screen> createState() => _SignUpStep2ScreenState();
}

class _SignUpStep2ScreenState extends State<SignUpStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  String? _selectedGender;
  final bool _isLoading = false;

  final _phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _dateFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    if (widget.existingUserData != null) {
      _emailController.text = widget.existingUserData!.email;
      _phoneController.text = widget.existingUserData!.phone ?? '';
      _birthDateController.text = widget.existingUserData!.birthDate ?? '';
      _selectedGender = widget.existingUserData!.gender;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione o sexo')),
      );
      return;
    }

    final userData = UserModel(
      email: _emailController.text.trim(),
      firstName: widget.existingUserData?.firstName,
      lastName: widget.existingUserData?.lastName,
      cpf: widget.existingUserData?.cpf,
      phone: _phoneController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      gender: _selectedGender,
      birthDate: _birthDateController.text,
      isBrazilian: widget.existingUserData?.isBrazilian ?? true,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpStep3Screen(
          existingUserData: userData,
          password: widget.password,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Indicador de progresso
                const ProgressIndicatorWidget(
                  currentStep: 2,
                  stepLabels: [
                    'Dados básicos',
                    'Dados adicionais',
                    'Endereço',
                  ],
                ),
                const SizedBox(height: 32),
                // Título
                Text(
                  'Dados Adicionais',
                  style: AppTheme.titleStyle(context),
                ),
                AppTheme.yellowLine(),
                const SizedBox(height: 24),
                // Campo Email
                CustomTextField(
                  label: 'e-mail',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Telefone
                Row(
                  children: [
                    // Prefixo +55
                    Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryYellow,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '+55',
                          style: TextStyle(
                            color: AppTheme.darkGray,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Campo de telefone
                    Expanded(
                      child: CustomTextField(
                        label: 'número do celular',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [_phoneFormatter],
                        validator: Validators.phone,
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Campo Sexo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sexo *',
                      style: AppTheme.labelStyle(context),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _GenderButton(
                            label: 'F',
                            value: 'F',
                            selectedValue: _selectedGender,
                            onSelected: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _GenderButton(
                            label: 'M',
                            value: 'M',
                            selectedValue: _selectedGender,
                            onSelected: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _GenderButton(
                            label: '?',
                            value: '?',
                            selectedValue: _selectedGender,
                            onSelected: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (_selectedGender == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 12),
                        child: Text(
                          'Selecione o sexo',
                          style: TextStyle(
                            color: Colors.red[300],
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // Campo Data de Nascimento
                CustomTextField(
                  label: 'data de nascimento',
                  controller: _birthDateController,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [_dateFormatter],
                  validator: Validators.birthDate,
                  isRequired: true,
                ),
                const SizedBox(height: 32),
                // Botão Próximo
                CustomButton(
                  text: 'próximo',
                  onPressed: _handleNext,
                ),
                const SizedBox(height: 24),
                AppTheme.yellowLine(),
                const SizedBox(height: 16),
                // Link "já possui uma conta?"
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.mediumGray,
                        ),
                        children: [
                          const TextSpan(text: 'já possui uma conta? '),
                          TextSpan(
                            text: 'entre agora!',
                            style: AppTheme.linkHighlightStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GenderButton extends StatelessWidget {
  final String label;
  final String value;
  final String? selectedValue;
  final Function(String) onSelected;

  const _GenderButton({
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () => onSelected(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryYellow : AppTheme.fieldBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryYellow : AppTheme.borderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppTheme.darkGray : AppTheme.lightGray,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
