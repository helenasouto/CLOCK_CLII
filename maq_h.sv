module maq_h (
    input  logic maqh_clock,      // Clock de 50 MHz
    input  logic maqh_reset,      // Sinal de reset
    input  logic maqh_enable,     // Pulso de 1 Hz
    input  logic maqh_incremento_min, // Pulso a cada hora
	 input  logic maqh_incremento_sec,
	 //input logic maqh_incremento_hora,
    output logic [3:0] maqh_lsd,  // Unidades de horas (BCD)
    output logic [1:0] maqh_msd   // Dezenas de horas (BCD)
);

    // Lógica do contador de horas
    always_ff @(posedge maqh_clock or posedge maqh_reset) begin
        if (maqh_reset) begin
            maqh_lsd <= 4'd0;
            maqh_msd <= 2'd0;
        end else if (maqh_enable && maqh_incremento_min && maqh_incremento_sec) begin
            if (maqh_lsd == 4'd9) begin
                maqh_lsd <= 4'd0;
                maqh_msd <= maqh_msd + 2'd1;
            end else if (maqh_msd == 2'd2 && maqh_lsd == 4'd3) begin
                maqh_lsd <= 4'd0;
                maqh_msd <= 2'd0; // Reinicia após 23:59:59
            end else begin
                maqh_lsd <= maqh_lsd + 4'd1;
            end
        end
    end

endmodule