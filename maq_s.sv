module maq_s (
    input  logic maqs_clock,          // Clock de 50 MHz
    input  logic maqs_reset,          // Sinal de reset
    input  logic maqs_enable,         // Pulso de 1 Hz
    output logic [3:0] maqs_lsd,      // Unidades de segundos (BCD)
    output logic [2:0] maqs_msd,      // Dezenas de segundos (BCD)
    output logic maqs_incrementa_min // Pulso a cada minuto
);

    // Lógica do contador de segundos
    always_ff @(posedge maqs_clock or posedge maqs_reset) begin
        if (maqs_reset) begin
            maqs_lsd <= 4'd0;
            maqs_msd <= 3'd0;
            maqs_incrementa_min <= 1'b0;
        end else if (maqs_enable) begin
            if (maqs_lsd == 4'd9) begin
                maqs_lsd <= 4'd0;
                if (maqs_msd == 3'd5) begin
                    maqs_msd <= 3'd0;
                    maqs_incrementa_min <= 1'b1; // Pulso a cada minuto
                end else begin
                    maqs_msd <= maqs_msd + 3'd1;
                end
            end else begin
                maqs_lsd <= maqs_lsd + 4'd1;
                maqs_incrementa_min <= 1'b0;
            end
        end
    end

endmodule