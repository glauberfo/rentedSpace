class Validators {
  // Validação de email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  // Validação de senha
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  // Validação de CPF
  static String? cpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF é obrigatório';
    }
    // Remove caracteres não numéricos
    final cpfDigits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cpfDigits.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    // Validação básica de CPF (todos os dígitos iguais)
    if (RegExp(r'^(\d)\1{10}$').hasMatch(cpfDigits)) {
      return 'CPF inválido';
    }
    return null;
  }

  // Validação de telefone brasileiro
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone é obrigatório';
    }
    // Remove caracteres não numéricos
    final phoneDigits = value.replaceAll(RegExp(r'[^0-9]'), '');
    // Aceita telefone com DDD (10 ou 11 dígitos)
    if (phoneDigits.length < 10 || phoneDigits.length > 11) {
      return 'Telefone inválido';
    }
    return null;
  }

  // Validação de CEP
  static String? cep(String? value) {
    if (value == null || value.isEmpty) {
      return 'CEP é obrigatório';
    }
    // Remove caracteres não numéricos
    final cepDigits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cepDigits.length != 8) {
      return 'CEP deve ter 8 dígitos';
    }
    return null;
  }

  // Validação de campo obrigatório genérico
  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }

  // Validação de data de nascimento
  static String? birthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data de nascimento é obrigatória';
    }
    // Formato esperado: DD/MM/YYYY
    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Data inválida (use DD/MM/AAAA)';
    }
    // Validação básica de data
    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      
      if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900 || year > DateTime.now().year) {
        return 'Data inválida';
      }
    } catch (e) {
      return 'Data inválida';
    }
    return null;
  }

  // Validação de número (para endereço)
  static String? number(String? value) {
    if (value == null || value.isEmpty) {
      return 'Número é obrigatório';
    }
    return null;
  }
}

