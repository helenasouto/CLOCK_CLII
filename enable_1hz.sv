module enable_1hz (
    input  logic enable_clock,   // Sinal de clock de 50 MHz
    input  logic enable_reset,   // Sinal de reset (ativo em nível baixo)
    output logic enable_pulseout // Pulso de 1 Hz
);

    logic [25:0] contador; // Contador de 26 bits (para contar até 49.999.999)

    // Lógica do contador
    always_ff @(posedge enable_clock or negedge enable_reset) begin
        if (!enable_reset) // Reset assíncrono (ativo em nível baixo)
            contador <= 26'd0;
        else if (contador == 26'd49_999_999) // Reinicia o contador após 1 segundo
            contador <= 26'd0;
        else
            contador <= contador + 26'd1; // Incrementa o contador
    end

    // Lógica do pulso de saída
    always_comb begin
        enable_pulseout = (contador == 26'd49_999_999); // Gera pulso quando o contador atinge 49.999.999
    end

endmodule