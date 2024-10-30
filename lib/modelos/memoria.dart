class Memoria {
  static const operacoes = ['/', '*', '-', '+', '=', '^', '!'];

  String _valor = '0';
  String _expressao = ''; // Armazena a expressão completa sem o resultado
  List<dynamic> _buffer = [0.0, '', 0.0];
  bool _ehPrimeiroNumero = true;
  bool _limparVisor = false;
  String _ultimoComando = '';

  void tratarDigito(String comando) {
    if (_estaSubstituindoOperacao(comando)) {
      _buffer[1] = comando;
      _atualizarExpressao(comando);
      return;
    }
    if (comando == 'C') {
      _limpar();
    } else if (operacoes.contains(comando)) {
      if (comando == '!') {
        _calcularFatorial(); // Calcula o fatorial diretamente
      } else if (comando == '=') {
        _calcularResultado(); // Calcula ao pressionar "="
      } else {
        _setOperacao(comando);
      }
    } else {
      adicionarDigito(comando);
    }
    _ultimoComando = comando;
  }

  bool _estaSubstituindoOperacao(String comando) {
    return operacoes.contains(comando) &&
        _ultimoComando != '=' &&
        operacoes.contains(_ultimoComando);
  }

  void _setOperacao(String operacao) {
    if (_ehPrimeiroNumero) {
      _buffer[0] = double.tryParse(_valor) ?? 0.0;
      _buffer[1] = operacao;
      _ehPrimeiroNumero = false;
    } else {
      _buffer[2] = double.tryParse(_valor) ?? 0.0;
      _valor = computa().toString();
      _buffer[0] = double.tryParse(_valor) ?? 0.0;
      _buffer[1] = operacao;
      _buffer[2] = 0.0;
    }
    _atualizarExpressao(operacao); // Atualiza a expressão com a operação
    _limparVisor = true;
  }

  void _calcularResultado() {
    if (_buffer[1] != '!') {
      _buffer[2] = double.tryParse(_valor) ?? 0.0;
      _valor = computa().toString();
    }
    _expressao = ''; // Limpa a expressão ao exibir o resultado
    _ehPrimeiroNumero = true;
    _limparVisor = true;
  }

  void _calcularFatorial() {
    final numero = double.tryParse(_valor) ?? 0.0;
    _valor = computaFatorial().toString();
    _expressao = ''; // Limpa a expressão para exibir apenas o resultado
    _ehPrimeiroNumero = true;
    _limparVisor = true;
  }

  void adicionarDigito(String digito) {
    final ehPonto = digito == '.';
    final deveLimparValor = (_valor == '0' && !ehPonto) || _limparVisor;

    if (ehPonto && _valor.contains('.') && !deveLimparValor) {
      return;
    }

    final valorVazio = ehPonto ? '0' : '';
    final valorAtual = deveLimparValor ? valorVazio : _valor;
    _valor = valorAtual + digito;
    _limparVisor = false;
    _buffer[_ehPrimeiroNumero ? 0 : 2] = double.tryParse(_valor) ?? 0;
    _atualizarExpressao(digito); // Atualiza a expressão com o dígito
  }

  void _atualizarExpressao(String parte) {
    // Atualiza a expressão concatenando a nova parte (número ou operação)
    _expressao += parte;
  }

  double computa() {
    final primeiroNumero = _buffer[0] as double;
    final segundoNumero = _buffer[2] as double;

    switch (_buffer[1]) {
      case '/':
        return segundoNumero != 0 ? primeiroNumero / segundoNumero : double.nan;
      case '*':
        return primeiroNumero * segundoNumero;
      case '-':
        return primeiroNumero - segundoNumero;
      case '+':
        return primeiroNumero + segundoNumero;
      case '^':
        return potencia(primeiroNumero, segundoNumero);
      default:
        return primeiroNumero;
    }
  }

  double computaFatorial() {
    final numero = double.tryParse(_valor) ?? 0.0;
    if (numero >= 0 && numero == numero.toInt()) {
      return fatorial(numero.toInt());
    } else {
      return double.nan;
    }
  }

  double potencia(double base, double expoente) {
    if (expoente == 0) return 1;
    double resultado = 1.0;
    for (int i = 0; i < expoente; i++) {
      resultado *= base;
    }
    return resultado;
  }

  double fatorial(int n) {
    if (n < 0) return double.nan;
    if (n == 0 || n == 1) return 1;
    double resultado = 1;
    for (int i = 2; i <= n; i++) {
      resultado *= i;
    }
    return resultado;
  }

  void _limpar() {
    _valor = '0';
    _expressao = ''; // Reseta a expressão ao limpar
    _buffer = [0.0, '', 0.0];
    _ehPrimeiroNumero = true;
    _limparVisor = false;
    _ultimoComando = '';
  }

  String get valor {
    return _expressao.isNotEmpty ? _expressao : _valor;
  }
}
