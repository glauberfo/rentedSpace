import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_indicator.dart';
import '../utils/validators.dart';
import 'signup_step2_screen.dart';
import '../models/user_model.dart';

class SignUpStep1Screen extends StatefulWidget {
  final UserModel? existingUserData;

  const SignUpStep1Screen({super.key, this.existingUserData});

  @override
  State<SignUpStep1Screen> createState() => _SignUpStep1ScreenState();
}

class _SignUpStep1ScreenState extends State<SignUpStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isBrazilian = true;
  bool _obscurePassword = true;

  final _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    if (widget.existingUserData != null) {
      _firstNameController.text = widget.existingUserData!.firstName ?? '';
      _lastNameController.text = widget.existingUserData!.lastName ?? '';
      _cpfController.text = widget.existingUserData!.cpf ?? '';
      _isBrazilian = widget.existingUserData!.isBrazilian;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final userData = UserModel(
      email: widget.existingUserData?.email ?? '',
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      cpf: _isBrazilian
          ? _cpfController.text.replaceAll(RegExp(r'[^0-9]'), '')
          : null,
      isBrazilian: _isBrazilian,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpStep2Screen(
          existingUserData: userData,
          password: _passwordController.text,
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
                  currentStep: 1,
                  stepLabels: [
                    'Dados básicos',
                    'Dados adicionais',
                    'Endereço',
                  ],
                ),
                const SizedBox(height: 32),
                // Título
                Text(
                  'Criar Conta',
                  style: AppTheme.titleStyle(context),
                ),
                AppTheme.yellowLine(),
                const SizedBox(height: 24),
                // Campo Nome
                CustomTextField(
                  label: 'nome',
                  controller: _firstNameController,
                  validator: (value) => Validators.required(value, 'Nome'),
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Sobrenome
                CustomTextField(
                  label: 'sobrenome',
                  controller: _lastNameController,
                  validator: (value) => Validators.required(value, 'Sobrenome'),
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo CPF
                if (_isBrazilian)
                  CustomTextField(
                    label: 'cpf',
                    controller: _cpfController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [_cpfFormatter],
                    validator: Validators.cpf,
                    isRequired: true,
                  ),
                if (_isBrazilian) const SizedBox(height: 16),
                // Checkbox "I'm not brazilian"
                Row(
                  children: [
                    Checkbox(
                      value: !_isBrazilian,
                      onChanged: (value) {
                        setState(() {
                          _isBrazilian = !(value ?? false);
                          if (!_isBrazilian) {
                            _cpfController.clear();
                          }
                        });
                      },
                      activeColor: AppTheme.primaryYellow,
                    ),
                    Text(
                      "Não sou brasileiro",
                      style: AppTheme.labelStyle(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Campo Senha
                CustomTextField(
                  label: 'senha',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: Validators.password,
                  isRequired: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.mediumGray,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
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
                // Link "esqueceu sua senha?"
                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implementar recuperação de senha
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Funcionalidade em desenvolvimento'),
                        ),
                      );
                    },
                    child: Text(
                      'esqueceu sua senha?',
                      style: AppTheme.linkStyle(context),
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
