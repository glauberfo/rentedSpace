const { useState } = React;
const { createRoot } = ReactDOM;

// Utility Functions
const Validators = {
  email: (value) => {
    if (!value) return 'E-mail é obrigatório';
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) return 'E-mail inválido';
    return null;
  },
  password: (value) => {
    if (!value) return 'Senha é obrigatória';
    if (value.length < 6) return 'Senha deve ter no mínimo 6 caracteres';
    return null;
  },
  required: (value, fieldName) => {
    if (!value || value.trim() === '') return `${fieldName} é obrigatório`;
    return null;
  },
  cpf: (value) => {
    if (!value) return 'CPF é obrigatório';
    const cleaned = value.replace(/[^\d]/g, '');
    if (cleaned.length !== 11) return 'CPF deve ter 11 dígitos';
    return null;
  },
  phone: (value) => {
    if (!value) return 'Telefone é obrigatório';
    const cleaned = value.replace(/[^\d]/g, '');
    if (cleaned.length !== 10 && cleaned.length !== 11) {
      return 'Telefone inválido';
    }
    return null;
  },
  birthDate: (value) => {
    if (!value) return 'Data de nascimento é obrigatória';
    if (!/^\d{2}\/\d{2}\/\d{4}$/.test(value)) return 'Formato inválido (DD/MM/AAAA)';
    return null;
  },
  cep: (value) => {
    if (!value) return 'CEP é obrigatório';
    const cleaned = value.replace(/[^\d]/g, '');
    if (cleaned.length !== 8) return 'CEP deve ter 8 dígitos';
    return null;
  },
  number: (value) => {
    if (!value) return 'Número é obrigatório';
    if (!/^\d+$/.test(value.replace(/\D/g, ''))) return 'Apenas números são permitidos';
    return null;
  },
};

const formatMask = {
  cpf: (value) => {
    const cleaned = value.replace(/\D/g, '');
    return cleaned
      .slice(0, 11)
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d{1,2})$/, '$1-$2');
  },
  phone: (value) => {
    const cleaned = value.replace(/\D/g, '');
    return cleaned
      .slice(0, 11)
      .replace(/(\d{2})(\d)/, '($1) $2')
      .replace(/(\d{5})(\d)/, '$1-$2');
  },
  date: (value) => {
    const cleaned = value.replace(/\D/g, '');
    return cleaned
      .slice(0, 8)
      .replace(/(\d{2})(\d)/, '$1/$2')
      .replace(/(\d{2})(\d)/, '$1/$2');
  },
  cep: (value) => {
    const cleaned = value.replace(/\D/g, '');
    return cleaned.slice(0, 8).replace(/(\d{5})(\d)/, '$1-$2');
  },
};

// Components
const YellowLine = () => <div className="yellow-line"></div>;

const CompanyLogo = () => (
  <svg width="260" height="260" viewBox="0 0 260 260" fill="none" xmlns="http://www.w3.org/2000/svg">
    <circle cx="130" cy="130" r="45" stroke="#E8C872" strokeWidth="10" fill="none" />

    {/* Raios maiores */}
    <path d="M130 10 L130 55" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>
    <path d="M130 205 L130 250" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>
    <path d="M10 130 L55 130" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>
    <path d="M205 130 L250 130" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>

    {/* Raios diagonais */}
    <path d="M55 55 L85 85" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>
    <path d="M175 175 L205 205" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>
    <path d="M55 205 L85 175" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>
    <path d="M175 85 L205 55" stroke="#E8C872" strokeWidth="10" strokeLinecap="round"/>

    {/* Raios curvos orgânicos */}
    <path d="M130 15 C135 25 135 45 130 55" stroke="#E8C872" strokeWidth="6" strokeLinecap="round"/>
    <path d="M245 130 C235 135 215 135 205 130" stroke="#E8C872" strokeWidth="6" strokeLinecap="round"/>
    <path d="M130 245 C125 235 125 215 130 205" stroke="#E8C872" strokeWidth="6" strokeLinecap="round"/>
    <path d="M15 130 C25 125 45 125 55 130" stroke="#E8C872" strokeWidth="6" strokeLinecap="round"/>
  </svg>
);

const CustomTextField = ({
  label,
  type = 'text',
  value,
  onChange,
  onBlur,
  error,
  isRequired = false,
  prefix = null,
  mask = null,
  showToggle = false,
  onToggleVisibility = null,
  isPasswordVisible = false,
}) => {
  const handleChange = (e) => {
    let val = e.target.value;
    if (mask === 'cpf') val = formatMask.cpf(val);
    else if (mask === 'phone') val = formatMask.phone(val);
    else if (mask === 'date') val = formatMask.date(val);
    else if (mask === 'cep') val = formatMask.cep(val);
    onChange(val);
  };

  const inputType = showToggle ? (isPasswordVisible ? 'text' : 'password') : type;

  return (
    <div className="form-group">
      <label className="label">
        {label} {isRequired && '*'}
      </label>
      {prefix ? (
        <div className="phone-prefix">
          <div className="phone-prefix-box">{prefix}</div>
          <input
            type={inputType}
            className="input-field"
            value={value}
            onChange={handleChange}
            onBlur={onBlur}
          />
        </div>
      ) : (
        <div style={{ position: 'relative', display: 'flex' }}>
          <input
            type={inputType}
            className="input-field"
            value={value}
            onChange={handleChange}
            onBlur={onBlur}
            placeholder={label}
            style={{ width: '100%' }}
          />
          {showToggle && (
            <button
              className="input-icon"
              type="button"
              onClick={onToggleVisibility}
              style={{ position: 'absolute', right: 12, top: '50%', transform: 'translateY(-50%)' }}
            >
              {isPasswordVisible ? '👁️' : '👁️‍🗨️'}
            </button>
          )}
        </div>
      )}
      {error && <div className="error-message">{error}</div>}
    </div>
  );
};

const CustomButton = ({ text, onClick, isLoading = false, disabled = false }) => {
  return (
    <button
      className="button"
      onClick={onClick}
      disabled={isLoading || disabled}
    >
      {isLoading && <span className="button-loading"></span>}
      <span>{text.toLowerCase()}</span>
    </button>
  );
};

const ProgressIndicator = ({ currentStep, stepLabels }) => {
  return (
    <div className="progress-indicator">
      <div className="progress-steps">
        {stepLabels.map((label, index) => {
          const stepNumber = index + 1;
          const isActive = stepNumber === currentStep;
          const isCompleted = stepNumber < currentStep;

          return (
            <div key={stepNumber} className="progress-step">
              {isActive && <div className="progress-step-arrow">↓</div>}
              {!isActive && <div style={{ height: 20 }}></div>}
              <div
                className={`progress-circle ${isActive || isCompleted ? 'active' : 'pending'} ${
                  isActive ? 'active' : isCompleted ? 'completed' : ''
                }`}
              >
                {stepNumber}
              </div>
              <div className={`progress-label ${isActive ? 'active' : ''}`}>{label}</div>
            </div>
          );
        })}
      </div>
      <div className="progress-bar"></div>
    </div>
  );
};

// Carousel
const Carousel = ({ onStarted }) => {
  const [currentSlide, setCurrentSlide] = useState(0);

  const slides = [
    {
      icon: 'logo',
      title: 'Bem-vindo à Iluminarte!',
      description: 'Descubra o mundo encantado da Iluminarte!\nReserve oficinas, encontre novas atividades e viva momentos de arte, aprendizado e afeto para as crianças e famílias — tudo em poucos cliques.\n✨ Toque para conhecer e se apaixonar.',
      bg: 'slide-welcome',
    },
    {
      icon: '🎨',
      title: 'Explore Aulas',
      description: 'Descubra uma variedade de aulas infantis: pintura, culinária, dança, natação e muito mais!',
      bg: 'slide-1',
    },
    {
      icon: '❤️',
      title: 'Instrutores Qualificados',
      description: 'Conheça educadores apaixonados por ensinar com arte, afeto e aprendizado.',
      bg: 'slide-2',
    },
    {
      icon: '⭐',
      title: 'Reserve com Facilidade',
      description: 'Escolha a aula perfeita, veja horários disponíveis e reserve em segundos!',
      bg: 'slide-3',
    },
  ];

  const nextSlide = () => {
    if (currentSlide < slides.length - 1) {
      setCurrentSlide(currentSlide + 1);
    }
  };

  const prevSlide = () => {
    if (currentSlide > 0) {
      setCurrentSlide(currentSlide - 1);
    }
  };

  const goToSlide = (index) => {
    setCurrentSlide(index);
  };

  const slide = slides[currentSlide];

  return (
    <div className="carousel-container">
      <div className={`carousel-slide ${slide.bg}`}>
        <div className="carousel-icon">{slide.icon === 'logo' ? <CompanyLogo /> : slide.icon}</div>
        <h1 className="carousel-title">{slide.title}</h1>
        <p className="carousel-description">{slide.description}</p>

        <div className="carousel-buttons">
          {currentSlide < slides.length - 1 ? (
            <>
              <button className="carousel-button" onClick={() => onStarted()}>
                Pular Introdução
              </button>
              <button className="carousel-button carousel-button-primary" onClick={nextSlide}>
                Próximo →
              </button>
            </>
          ) : (
            <>
              <button className="carousel-button" onClick={prevSlide}>
                ← Anterior
              </button>
              <button className="carousel-button carousel-button-primary" onClick={() => onStarted()}>
                Começar Agora
              </button>
            </>
          )}
        </div>

        <div className="carousel-dots">
          {slides.map((_, index) => (
            <div
              key={index}
              className={`carousel-dot ${currentSlide === index ? 'active' : ''}`}
              onClick={() => goToSlide(index)}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

// Screens
const LoginScreen = ({ onNavigateToSignUp }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errors, setErrors] = useState({});
  const [isLoading, setIsLoading] = useState(false);
  const [isPasswordVisible, setIsPasswordVisible] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const newErrors = {};

    const emailError = Validators.email(email);
    const passwordError = Validators.password(password);

    if (emailError) newErrors.email = emailError;
    if (passwordError) newErrors.password = passwordError;

    setErrors(newErrors);

    if (Object.keys(newErrors).length === 0) {
      setIsLoading(true);
      setTimeout(() => {
        alert('Login realizado com sucesso!');
        setIsLoading(false);
      }, 1000);
    }
  };

  return (
    <div className="container">
      <div className="content" style={{ marginTop: 20 }}>
        <h1 className="title">Bem-vindo de volta!</h1>
        <YellowLine />
        <div style={{ marginTop: 24 }}>
          <CustomTextField
            label="e-mail"
            type="email"
            value={email}
            onChange={setEmail}
            error={errors.email}
            isRequired
          />
          <div style={{ marginTop: 16 }}>
            <CustomTextField
              label="senha"
              type="password"
              value={password}
              onChange={setPassword}
              error={errors.password}
              isRequired
              showToggle
              isPasswordVisible={isPasswordVisible}
              onToggleVisibility={() => setIsPasswordVisible(!isPasswordVisible)}
            />
          </div>
          <div style={{ textAlign: 'right', marginTop: -10, marginBottom: 32 }}>
            <button
              className="link"
              onClick={() => alert('Funcionalidade em desenvolvimento')}
            >
              Esqueceu sua senha?
            </button>
          </div>
          <CustomButton
            text="entrar"
            onClick={handleSubmit}
            isLoading={isLoading}
          />
        </div>
        <div style={{ marginTop: 24 }}>
          <YellowLine />
        </div>
        <div style={{ marginTop: 16, textAlign: 'center' }}>
          <span style={{ color: '#666', fontSize: 14 }}>Sem conta? </span>
          <button
            className="link-highlight"
            onClick={onNavigateToSignUp}
          >
            Cadastre-se agora
          </button>
        </div>
      </div>
    </div>
  );
};

const SignUpStep1Screen = ({ onNext, onBackToLogin }) => {
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [cpf, setCpf] = useState('');
  const [password, setPassword] = useState('');
  const [isBrazilian, setIsBrazilian] = useState(true);
  const [errors, setErrors] = useState({});
  const [isPasswordVisible, setIsPasswordVisible] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    const newErrors = {};

    const firstNameError = Validators.required(firstName, 'Nome');
    const lastNameError = Validators.required(lastName, 'Sobrenome');
    const passwordError = Validators.password(password);
    const cpfError = isBrazilian ? Validators.cpf(cpf) : null;

    if (firstNameError) newErrors.firstName = firstNameError;
    if (lastNameError) newErrors.lastName = lastNameError;
    if (passwordError) newErrors.password = passwordError;
    if (cpfError) newErrors.cpf = cpfError;

    setErrors(newErrors);

    if (Object.keys(newErrors).length === 0) {
      onNext({
        firstName,
        lastName,
        cpf: isBrazilian ? cpf.replace(/\D/g, '') : null,
        isBrazilian,
        password,
      });
    }
  };

  return (
    <div className="container">
      <div className="content">
        <div style={{ marginTop: 20 }}>
          <ProgressIndicator
            currentStep={1}
            stepLabels={['Dados básicos', 'Dados adicionais', 'Endereço']}
          />
          <div style={{ marginTop: 24 }}>
            <h1 className="title">Criar Conta</h1>
            <YellowLine />
            <form onSubmit={handleSubmit}>
              <CustomTextField
                label="nome"
                value={firstName}
                onChange={setFirstName}
                error={errors.firstName}
                isRequired
              />
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="sobrenome"
                  value={lastName}
                  onChange={setLastName}
                  error={errors.lastName}
                  isRequired
                />
              </div>
              {isBrazilian && (
                <div style={{ marginTop: 16 }}>
                  <CustomTextField
                    label="cpf"
                    type="text"
                    value={cpf}
                    onChange={setCpf}
                    error={errors.cpf}
                    isRequired
                    mask="cpf"
                  />
                </div>
              )}
              {isBrazilian && <div style={{ marginTop: 16 }}></div>}
              <div className="checkbox-group">
                <input
                  type="checkbox"
                  className="checkbox-input"
                  checked={!isBrazilian}
                  onChange={(e) => {
                    setIsBrazilian(!e.target.checked);
                    if (e.target.checked) setCpf('');
                  }}
                />
                <label className="checkbox-label">Não sou brasileiro</label>
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="senha"
                  type="password"
                  value={password}
                  onChange={setPassword}
                  error={errors.password}
                  isRequired
                  showToggle
                  isPasswordVisible={isPasswordVisible}
                  onToggleVisibility={() => setIsPasswordVisible(!isPasswordVisible)}
                />
              </div>
              <div style={{ marginTop: 32 }}>
                <CustomButton text="próximo" onClick={handleSubmit} />
              </div>
            </form>
            <div style={{ marginTop: 16, textAlign: 'center' }}>
              <button
                className="link"
                onClick={() => alert('Funcionalidade em desenvolvimento')}
              >
                Esqueceu sua senha?
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

const SignUpStep2Screen = ({ onNext, onBackToLogin, previousData }) => {
  const [email, setEmail] = useState(previousData?.email || '');
  const [phone, setPhone] = useState(previousData?.phone || '');
  const [gender, setGender] = useState(previousData?.gender || null);
  const [birthDate, setBirthDate] = useState(previousData?.birthDate || '');
  const [errors, setErrors] = useState({});

  const handleSubmit = (e) => {
    e.preventDefault();
    const newErrors = {};

    const emailError = Validators.email(email);
    const phoneError = Validators.phone(phone);
    const birthDateError = Validators.birthDate(birthDate);

    if (emailError) newErrors.email = emailError;
    if (phoneError) newErrors.phone = phoneError;
    if (!gender) newErrors.gender = 'Selecione o sexo';
    if (birthDateError) newErrors.birthDate = birthDateError;

    setErrors(newErrors);

    if (Object.keys(newErrors).length === 0) {
      onNext({
        ...previousData,
        email,
        phone: phone.replace(/\D/g, ''),
        gender,
        birthDate,
      });
    }
  };

  return (
    <div className="container">
      <div className="content">
        <div style={{ marginTop: 20 }}>
          <ProgressIndicator
            currentStep={2}
            stepLabels={['Dados básicos', 'Dados adicionais', 'Endereço']}
          />
          <div style={{ marginTop: 24 }}>
            <h1 className="title">Dados Adicionais</h1>
            <YellowLine />
            <form onSubmit={handleSubmit}>
              <CustomTextField
                label="e-mail"
                type="email"
                value={email}
                onChange={setEmail}
                error={errors.email}
                isRequired
              />
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="número do celular"
                  type="tel"
                  value={phone}
                  onChange={setPhone}
                  error={errors.phone}
                  isRequired
                  prefix="+55"
                  mask="phone"
                />
              </div>
              <div style={{ marginTop: 16 }}>
                <label className="label">sexo *</label>
                <div className="gender-buttons">
                  <button
                    type="button"
                    className={`gender-button ${gender === 'F' ? 'selected' : ''}`}
                    onClick={() => setGender('F')}
                  >
                    Fem
                  </button>
                  <button
                    type="button"
                    className={`gender-button ${gender === 'M' ? 'selected' : ''}`}
                    onClick={() => setGender('M')}
                  >
                    Masc
                  </button>
                  <button
                    type="button"
                    className={`gender-button ${gender === '?' ? 'selected' : ''}`}
                    onClick={() => setGender('?')}
                  >
                    Outro
                  </button>
                </div>
                {errors.gender && <div className="error-message">{errors.gender}</div>}
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="data de nascimento"
                  type="text"
                  value={birthDate}
                  onChange={setBirthDate}
                  error={errors.birthDate}
                  isRequired
                  mask="date"
                  placeholder="DD/MM/AAAA"
                />
              </div>
              <div style={{ marginTop: 32 }}>
                <CustomButton text="próximo" onClick={handleSubmit} />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

const SignUpStep3Screen = ({ onFinish, previousData, onBackToLogin }) => {
  const [country, setCountry] = useState(previousData?.country || 'Brasil');
  const [zipCode, setZipCode] = useState(previousData?.zipCode || '');
  const [street, setStreet] = useState(previousData?.street || '');
  const [streetNumber, setStreetNumber] = useState(previousData?.streetNumber || '');
  const [complement, setComplement] = useState(previousData?.complement || '');
  const [neighborhood, setNeighborhood] = useState(previousData?.neighborhood || '');
  const [city, setCity] = useState(previousData?.city || '');
  const [state, setState] = useState(previousData?.state || '');
  const [errors, setErrors] = useState({});
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const newErrors = {};

    if (!country) newErrors.country = 'País é obrigatório';
    if (!zipCode) newErrors.zipCode = 'CEP é obrigatório';
    if (!street) newErrors.street = 'Rua é obrigatória';
    if (!streetNumber) newErrors.streetNumber = 'Número é obrigatório';
    if (!complement) newErrors.complement = 'Complemento é obrigatório';
    if (!neighborhood) newErrors.neighborhood = 'Bairro é obrigatório';
    if (!city) newErrors.city = 'Cidade é obrigatória';
    if (!state) newErrors.state = 'Estado é obrigatório';

    setErrors(newErrors);

    if (Object.keys(newErrors).length === 0) {
      setIsLoading(true);
      const userData = {
        ...previousData,
        country,
        zipCode: zipCode.replace(/\D/g, ''),
        street,
        streetNumber,
        complement,
        neighborhood,
        city,
        state,
      };

      setTimeout(() => {
        alert('Cadastro realizado com sucesso!');
        setIsLoading(false);
        onFinish(userData);
      }, 1000);
    }
  };

  return (
    <div className="container">
      <div className="content">
        <div style={{ marginTop: 20 }}>
          <ProgressIndicator
            currentStep={3}
            stepLabels={['Dados básicos', 'Dados adicionais', 'Endereço']}
          />
          <div style={{ marginTop: 24 }}>
            <h1 className="title">Endereço</h1>
            <YellowLine />
            <form onSubmit={handleSubmit}>
              <CustomTextField
                label="país"
                value={country}
                onChange={setCountry}
                error={errors.country}
                isRequired
              />
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="cep"
                  type="text"
                  value={zipCode}
                  onChange={setZipCode}
                  error={errors.zipCode}
                  isRequired
                  mask="cep"
                  placeholder="XXXXX-XXX"
                />
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="rua"
                  value={street}
                  onChange={setStreet}
                  error={errors.street}
                  isRequired
                />
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="número"
                  type="text"
                  value={streetNumber}
                  onChange={setStreetNumber}
                  error={errors.streetNumber}
                  isRequired
                />
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="complemento"
                  value={complement}
                  onChange={setComplement}
                  error={errors.complement}
                  isRequired
                />
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="bairro"
                  value={neighborhood}
                  onChange={setNeighborhood}
                  error={errors.neighborhood}
                  isRequired
                />
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="cidade"
                  value={city}
                  onChange={setCity}
                  error={errors.city}
                  isRequired
                />
              </div>
              <div style={{ marginTop: 16 }}>
                <CustomTextField
                  label="estado"
                  value={state}
                  onChange={setState}
                  error={errors.state}
                  isRequired
                />
              </div>
              <div style={{ marginTop: 32 }}>
                <CustomButton text="concluir" onClick={handleSubmit} isLoading={isLoading} />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

// Main App
function App() {
  const [currentScreen, setCurrentScreen] = useState('carousel');
  const [signUpData, setSignUpData] = useState({});

  const handleSignUpStep1 = (data) => {
    setSignUpData({ ...data });
    setCurrentScreen('signup2');
  };

  const handleSignUpStep2 = (data) => {
    setSignUpData(data);
    setCurrentScreen('signup3');
  };

  const handleSignUpStep3 = (data) => {
    setSignUpData(data);
    setCurrentScreen('login');
  };

  return (
    <>
      {currentScreen === 'carousel' && (
        <Carousel
          onStarted={() => {
            setSignUpData({});
            setCurrentScreen('login');
          }}
        />
      )}
      {currentScreen === 'login' && (
        <LoginScreen
          onNavigateToSignUp={() => {
            setSignUpData({});
            setCurrentScreen('signup1');
          }}
        />
      )}
      {currentScreen === 'signup1' && (
        <SignUpStep1Screen
          onNext={handleSignUpStep1}
          onBackToLogin={() => setCurrentScreen('login')}
        />
      )}
      {currentScreen === 'signup2' && (
        <SignUpStep2Screen
          onNext={handleSignUpStep2}
          onBackToLogin={() => setCurrentScreen('login')}
          previousData={signUpData}
        />
      )}
      {currentScreen === 'signup3' && (
        <SignUpStep3Screen
          onFinish={handleSignUpStep3}
          previousData={signUpData}
          onBackToLogin={() => setCurrentScreen('login')}
        />
      )}
    </>
  );
}

const root = createRoot(document.getElementById('root'));
root.render(<App />);
