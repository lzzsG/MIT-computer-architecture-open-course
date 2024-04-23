import Multiplexer::*;

// Full adder functions

function Bit#(1) fa_sum( Bit#(1) a, Bit#(1) b, Bit#(1) c_in );
    return xor1( xor1( a, b ), c_in );
endfunction

function Bit#(1) fa_carry( Bit#(1) a, Bit#(1) b, Bit#(1) c_in );
    return or1( and1( a, b ), and1( xor1( a, b ), c_in ) );
endfunction

// 4 Bit full adder

function Bit#(5) add4( Bit#(4) a, Bit#(4) b, Bit#(1) c_in );
// Ex4
// Complete the code for add4 using a for loop to properly connect all the code that uses fa_sum and fa_carry.

    Bit#(4) s = 0;
    Bit#(5) c = 0;
    c[0] = c_in;

    for (Integer i=0; i<4; i=i+1) begin
        Bit#(2) cs = {fa_carry(a[i], b[i], c[i]), fa_sum(a[i], b[i], c[i])};

        c[i+1] = cs[1];
        s[i] = cs[0];
    end

    return {c[4],s};
endfunction

// Adder interface

interface Adder8;
    method ActionValue#( Bit#(9) ) sum( Bit#(8) a, Bit#(8) b, Bit#(1) c_in );
endinterface

// Adder modules

// RC = Ripple Carry
module mkRCAdder( Adder8 );
    method ActionValue#( Bit#(9) ) sum( Bit#(8) a, Bit#(8) b, Bit#(1) c_in );
        Bit#(5) lower_result = add4( a[3:0], b[3:0], c_in );
        Bit#(5) upper_result = add4( a[7:4], b[7:4], lower_result[4] );
        return { upper_result , lower_result[3:0] };
    endmethod
endmodule

// CS = Carry Select
module mkCSAdder( Adder8 );
// Ex5
// Complete Select Carry Adder

    method ActionValue#( Bit#(9) ) sum( Bit#(8) a, Bit#(8) b, Bit#(1) c_in );
        let csL = add4(a[3:0], b[3:0], c_in);
        let csU = (csL[4] == 0) ? add4(a[7:4], b[7:4], 0) : add4(a[7:4], b[7:4], 1); 
        return {csU,csL[3:0]}; 
    endmethod
endmodule

