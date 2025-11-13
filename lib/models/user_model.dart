class UserModel {
  final String? id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? cpf;
  final String? phone;
  final String? gender;
  final String? birthDate;
  final String? country;
  final String? zipCode;
  final String? street;
  final String? streetNumber;
  final String? complement;
  final String? neighborhood;
  final String? city;
  final String? state;
  final bool isBrazilian;

  UserModel({
    this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.cpf,
    this.phone,
    this.gender,
    this.birthDate,
    this.country,
    this.zipCode,
    this.street,
    this.streetNumber,
    this.complement,
    this.neighborhood,
    this.city,
    this.state,
    this.isBrazilian = true,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'cpf': cpf,
      'phone': phone,
      'gender': gender,
      'birth_date': birthDate,
      'country': country,
      'zip_code': zipCode,
      'street': street,
      'street_number': streetNumber,
      'complement': complement,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'is_brazilian': isBrazilian,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'] ?? '',
      firstName: json['first_name'],
      lastName: json['last_name'],
      cpf: json['cpf'],
      phone: json['phone'],
      gender: json['gender'],
      birthDate: json['birth_date'],
      country: json['country'],
      zipCode: json['zip_code'],
      street: json['street'],
      streetNumber: json['street_number'],
      complement: json['complement'],
      neighborhood: json['neighborhood'],
      city: json['city'],
      state: json['state'],
      isBrazilian: json['is_brazilian'] ?? true,
    );
  }
}

