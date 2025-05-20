module maq_m (
 input  logic maqm_clock,          // Clock de 50 MHz
 input  logic maqm_reset,          // Sinal de reset
 input  logic maqm_enable,         // Pulso de 1 Hz
 input  logic maqm_incremento,     // Pulso a cada minuto
 output logic [3:0] maqm_lsd,      // Unidades de minutos (BCD)
 output logic [2:0] maqm_msd,      // Dezenas de minutos (BCD)
 output logic maqm_incrementa_hora  // Pulso a cada hora
);

 // Lógica do contador de minutos
 always_ff @(posedge maqm_clock or posedge maqm_reset) begin
	  if (maqm_reset) begin
			maqm_lsd <= 4'd0;
			maqm_msd <= 3'd0;
			maqm_incrementa_hora <= 1'b0;
	  end else if (maqm_enable && maqm_incremento) begin
			if (maqm_lsd == 4'd9) begin
				 maqm_lsd <= 4'd0;
				 if (maqm_msd == 3'd5) begin
					  maqm_msd <= 3'd0;
					  maqm_incrementa_hora <= 1'b1; // Pulso a cada hora
				 end else begin
					  maqm_msd <= maqm_msd + 3'd1;
				 end
			end else begin
				 maqm_lsd <= maqm_lsd + 4'd1;
				 maqm_incrementa_hora <= 1'b0;
			end
	  end
 end

endmodule