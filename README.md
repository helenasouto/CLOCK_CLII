# CLOCK_CLII
Relógio digital desenvolvido em SystemVerilog no Quartus, com contagem de horas, minutos e segundos, utilizando displays de 7 segmentos e clock de 50MHz, como projeto prático da disciplina de Circuitos Lógicos 2
# ⏰ Relógio Digital em SystemVerilog

Este projeto implementa um **relógio digital funcional** utilizando **SystemVerilog** no **Quartus**, como parte da disciplina de **Circuitos Lógicos 2**. O relógio realiza a contagem de horas, minutos e segundos com exibição em **6 displays de 7 segmentos**, sincronizado com um **clock de 50 MHz**.

## 📚 Descrição do Projeto

- Desenvolvido em **SystemVerilog**.
- Implementado no **Quartus Prime** com simulação e teste em **placa FPGA (caso aplicável)**.
- Utiliza um **clock de 50 MHz** para gerar a temporização dos segundos.
- Exibe a hora completa em **HH:MM:SS** usando **6 displays de 7 segmentos**.
- Possui **botão de reset**, que zera a contagem.
- Contagem implementada em formato **BCD** para facilitar a exibição nos displays.

## 🔧 Funcionalidades

- Contagem de:
  - **Segundos (0 a 59)**
  - **Minutos (0 a 59)**
  - **Horas (0 a 23)**
- Exibição contínua da hora em displays.
- Reset manual via entrada de controle.
- Lógica de divisão de clock para geração do pulso de 1Hz.

## 🧠 Tecnologias Utilizadas

- [SystemVerilog](https://www.systemverilog.org/)
- Quartus Prime
- Displays de 7 segmentos
- Simulação e testes com **ModelSim** (opcional)

## 🚀 Como Usar

1. Abra o Quartus Prime.
2. Crie um novo projeto ou abra o projeto existente.
3. Adicione os arquivos `.sv` ao projeto.
4. Compile o projeto.
5. (Opcional) Faça o **pin mapping** para sua placa FPGA.
6. Envie o bitstream para a placa e visualize o relógio nos displays.

## 📝 Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](./LICENSE) para mais detalhes.

## 👤 Autoria

Desenvolvido por [Seu Nome], como parte da disciplina de **Circuitos Lógicos 2**.

---

Sinta-se à vontade para estudar, modificar ou expandir esse projeto com alarmes, cronômetro e mais funcionalidades!
