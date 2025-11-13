import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_indicator.dart';
import '../utils/validators.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class SignUpStep3Screen extends StatefulWidget {
  final UserModel? existingUserData;
  final String password;

  const SignUpStep3Screen({
    super.key,
    this.existingUserData,
    required this.password,
  });

  @override
  State<SignUpStep3Screen> createState() => _SignUpStep3ScreenState();
}

class _SignUpStep3ScreenState extends State<SignUpStep3Screen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController(text: 'Brasil');
  final _zipCodeController = TextEditingController();
  final _streetController = TextEditingController();
  final _streetNumberController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  bool _isLoading = false;

  final _cepFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    if (widget.existingUserData != null) {
      _countryController.text = widget.existingUserData!.country ?? 'Brasil';
      _zipCodeController.text = widget.existingUserData!.zipCode ?? '';
      _streetController.text = widget.existingUserData!.street ?? '';
      _streetNumberController.text = widget.existingUserData!.streetNumber ?? '';
      _complementController.text = widget.existingUserData!.complement ?? '';
      _neighborhoodController.text = widget.existingUserData!.neighborhood ?? '';
      _cityController.text = widget.existingUserData!.city ?? '';
      _stateController.text = widget.existingUserData!.state ?? '';
    }
  }

  @override
  void dispose() {
    _countryController.dispose();
    _zipCodeController.dispose();
    _streetController.dispose();
    _streetNumberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Future<void> _handleFinish() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = AuthService();
      
      // Criar usuário no Supabase Auth
      final email = widget.existingUserData?.email ?? '';
      await authService.signUp(email, widget.password);

      // Criar modelo completo do usuário
      final userData = UserModel(
        email: email,
        firstName: widget.existingUserData?.firstName,
        lastName: widget.existingUserData?.lastName,
        cpf: widget.existingUserData?.cpf,
        phone: widget.existingUserData?.phone,
        gender: widget.existingUserData?.gender,
        birthDate: widget.existingUserData?.birthDate,
        country: _countryController.text.trim(),
        zipCode: _zipCodeController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        street: _streetController.text.trim(),
        streetNumber: _streetNumberController.text.trim(),
        complement: _complementController.text.trim(),
        neighborhood: _neighborhoodController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        isBrazilian: widget.existingUserData?.isBrazilian ?? true,
      );

      // Salvar perfil do usuário
      await authService.saveUserProfile(userData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        
        // Navegar para tela de login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao finalizar cadastro: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                ProgressIndicatorWidget(
                  currentStep: 3,
                  stepLabels: const [
                    'Dados básicos',
                    'Dados adicionais',
                    'Endereço',
                  ],
                ),
                const SizedBox(height: 32),
                // Título
                const Text(
                  'criar conta',
                  style: AppTheme.titleStyle,
                ),
                AppTheme.yellowLine(),
                const SizedBox(height: 24),
                // Campo País
                CustomTextField(
                  label: 'país',
                  controller: _countryController,
                  validator: (value) => Validators.required(value, 'País'),
                  isRequired: true,
                  suffixIcon: const Icon(
                    Icons.flag,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 16),
                // Campo CEP
                CustomTextField(
                  label: 'cep',
                  controller: _zipCodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cepFormatter],
                  validator: Validators.cep,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Rua
                CustomTextField(
                  label: 'rua',
                  controller: _streetController,
                  validator: (value) => Validators.required(value, 'Rua'),
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Número
                CustomTextField(
                  label: 'número',
                  controller: _streetNumberController,
                  keyboardType: TextInputType.number,
                  validator: Validators.number,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Complemento
                CustomTextField(
                  label: 'complemento',
                  controller: _complementController,
                  validator: (value) => Validators.required(value, 'Complemento'),
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Bairro
                CustomTextField(
                  label: 'bairro',
                  controller: _neighborhoodController,
                  validator: (value) => Validators.required(value, 'Bairro'),
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Cidade
                CustomTextField(
                  label: 'cidade',
                  controller: _cityController,
                  validator: (value) => Validators.required(value, 'Cidade'),
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Campo Estado
                CustomTextField(
                  label: 'estado',
                  controller: _stateController,
                  validator: (value) => Validators.required(value, 'Estado'),
                  isRequired: true,
                ),
                const SizedBox(height: 32),
                // Botão Concluir
                CustomButton(
                  text: 'concluir',
                  onPressed: _handleFinish,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

