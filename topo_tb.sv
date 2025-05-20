`timescale 1ns / 1ps

module topo_tb;

  // Sinais para instanciar o DUT (Dispositivo Sob Teste)
  logic clock;
  logic reset;
  logic [6:0] s_lsd, s_msd, m_lsd, m_msd, h_lsd, h_msd;

  // Instanciação do módulo Relogio
  topo dut (
      .reset(reset),
      .clock(clock),
      .s_lsd(s_lsd),
      .s_msd(s_msd),
      .m_lsd(m_lsd),
      .m_msd(m_msd),
      .h_lsd(h_lsd),
      .h_msd(h_msd)
  );

  // Geração do clock de 50MHz (período de 20 ns)
  initial begin
    clock = 0;
    forever #10 clock = ~clock;
  end

  // Geração do reset (assumindo reset ativo em 0)
  initial begin
    reset = 0;  // ativa o reset
    #50;        // mantém reset ativo por 50 ns
    reset = 1;  // libera o reset
  end

  // Função para converter a codificação dos 7 segmentos para o dígito correspondente
  function automatic string seven_seg_to_digit(input logic [6:0] seg);
    case (seg)
      7'b1111110: seven_seg_to_digit = "0";
      7'b0110000: seven_seg_to_digit = "1";
      7'b1101101: seven_seg_to_digit = "2";
      7'b1111001: seven_seg_to_digit = "3";
      7'b0110011: seven_seg_to_digit = "4";
      7'b1011011: seven_seg_to_digit = "5";
      7'b1011111: seven_seg_to_digit = "6";
      7'b1110000: seven_seg_to_digit = "7";
      7'b1111111: seven_seg_to_digit = "8";
      7'b1111011: seven_seg_to_digit = "9";
      default:    seven_seg_to_digit = "?"; // valor inválido
    endcase
  endfunction

  // Monitoramento periódico dos sinais convertidos
  initial begin
    // Aguarda um tempo para que os sinais se estabilizem (ajuste conforme necessário)
    #2000;
    forever begin
      $display("Tempo: %0t | Horas: %s%s  Minutos: %s%s  Segundos: %s%s", $time,
               seven_seg_to_digit(h_msd), seven_seg_to_digit(h_lsd), seven_seg_to_digit(m_msd),
               seven_seg_to_digit(m_lsd), seven_seg_to_digit(s_msd), seven_seg_to_digit(s_lsd));
      #5000;  // exibe a cada 5 us (ajuste conforme a sua simulação)
    end
  end

  // Variáveis para armazenar o valor anterior dos sinais de carry
  logic prev_incrementa_minuto;
  logic prev_incrementa_hora;

  // Inicializa os registradores para detectar bordas
  initial begin
    prev_incrementa_minuto = 0;
    prev_incrementa_hora   = 0;
  end

  // Sempre que houver uma borda de clock, verifica se houve transição de 0 para 1
  always @(posedge clock) begin
    // Detecta a borda de subida para o carry de segundos para minutos
    if (!prev_incrementa_minuto && dut.incrementa_minuto) begin
      $display("Tempo: %0t - Rising edge: Carry de segundos para minutos detectado", $time);
    end
    // Detecta a borda de subida para o carry de minutos para horas
    if (!prev_incrementa_hora && dut.incrementa_hora) begin
      $display("Tempo: %0t - Rising edge: Carry de minutos para horas detectado", $time);
    end

    // Atualiza os valores anteriores para a próxima comparação
    prev_incrementa_minuto <= dut.incrementa_minuto;
    prev_incrementa_hora   <= dut.incrementa_hora;
  end

  // Monitoramento dos sinais internos para depuração
  always @(posedge clock) begin
    if (dut.incrementa_hora == 1) begin
      $display("Debug - incrementa_hora=1: enable1hz=%b, maqs_incrementaminuto=%b, maqm_incrementahora=%b",
               dut.enable1hz, dut.incrementa_minuto, dut.incrementa_hora);
    end
  end

  // Finaliza a simulação após um tempo determinado
  initial begin
    #2000000; // simulação de 2 ms (ajuste conforme necessário)
    $finish;
  end

endmodule