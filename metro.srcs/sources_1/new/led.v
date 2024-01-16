`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.08.2023 22:52:19
// Design Name: 
// Module Name: led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led(
    input clk,
    input [15:0] sw,
    output reg [15:0] led
    
    );
    
    reg yavas_clk;
    reg sn20;
    reg [1:0] basamak2;
    reg [32:0] sayac;
    reg [19:0] sayac_2;
    reg yon; // 1 sag, 0 sol
    reg [1:0] flag;
    reg degisim;
    reg [1:0] sayac3;
   
    
    initial begin
    led = 16'b0000000000000001; // opsiyonel
    yavas_clk=0;
    yon=1; //opsiyonel
    sayac=0;
    sayac_2=0;
    flag=0;
    sayac3=0;
    end
    always @(sw[15]) begin
        if (sw[15]==0) begin
            yon=sw[14];
            if(sw[5]==1) begin
                led = 16'b1000000000000000;
                  if(sw[4]==1) begin
                   led = 16'b0001000000000000;
                    if(sw[3]==1) begin
                     led = 16'b0000001000000000;
                       if(sw[2]==1) begin
                        led = 16'b0000000001000000;
                         if(sw[1]==1) begin
                          led = 16'b0000000000001000;
                          if(sw[0]==1) begin
                            led = 16'b0000000000000001;
                           end
                         end
                       end
                     end
                  end
              end    
        end
    end
    
    always @(posedge clk) begin
    if( sw[15]==1) begin
    if(sayac==10**8/2) begin
    sayac=0;
    yavas_clk=~yavas_clk;
    end
    sayac=sayac+1;
    end
    end
   
     always @(posedge yavas_clk) begin
     if (flag==2'd0) begin
        if(sayac_2==20) begin
            sayac_2=0;
            sn20 =~ sn20;
            degisim=~degisim;
            flag=1;
            end
     sayac_2 = sayac_2 +1;
         end
         else begin
         
         if(sayac3==2) begin
         basamak2=basamak2+1;
         sayac3=0;
         degisim=~degisim;
         end
         sayac3=sayac3+1;
         
         end
      end
      
      always @(basamak2) begin
      if (basamak2==2) begin
        flag=0;
        basamak2=0;
        end
      end
        
      always @(degisim) begin
       if(led==1||led==16'b1000000000000000)
       yon=~yon; 
       if(yon==1) begin
       led=led>>1;
       end
       if (yon==0) begin
       led=led<<1;
       end
      
      end
    
endmodule
