function Bit#(1) and1(Bit#(1) a, Bit#(1) b);
    return a & b;
endfunction

function Bit#(1) or1(Bit#(1) a, Bit#(1) b);
    return a | b;
endfunction

function Bit#(1) xor1( Bit#(1) a, Bit#(1) b );
    return a ^ b;
endfunction

function Bit#(1) not1(Bit#(1) a);
    return ~ a;
endfunction

function Bit#(1) multiplexer1(Bit#(1) sel, Bit#(1) a, Bit#(1) b);
// Ex1
// Reimplement functions using AND gates, OR gates, and NOT Gates
// Use the functions `and1`, `or1` and `not1`, provided in this code.

    //return or1(and1(not1(sel), a), and1(sel, b));

    let chosenOne = or1(and1(not1(sel), a), and1(sel, b));
    return chosenOne;

    //return (sel == 0)? a : b;
endfunction

function Bit#(5) multiplexer5(Bit#(1) sel, Bit#(5) a, Bit#(5) b);
// Ex2
// Complete this function using a `for` loop and `multiplexer1`

    // Bit#(5) chosenOne5;
    // for(Integer i = 0; i < 5; i = i + 1) begin
    //     chosenOne5[i] = multiplexer1(sel, a[i], b[i]);
    // end
    // return chosenOne5;

    return multiplexer_n(sel, a, b);

    //return (sel == 0)? a : b;
endfunction

typedef 5 N;
function Bit#(N) multiplexerN(Bit#(1) sel, Bit#(N) a, Bit#(N) b);
// Code from multiplexer5, replace 5 with N (or valueOf(N))

    Bit#(N) chosenOneN5;
    for(Integer i = 0; i < valueOf(N); i = i + 1) begin
        chosenOneN5[i] = multiplexer1(sel, a[i], b[i]);
    end
    return chosenOneN5;

    //return (sel == 0)? a : b;
endfunction

//typedef 32 N; // Not needed
function Bit#(n) multiplexer_n(Bit#(1) sel, Bit#(n) a, Bit#(n) b);
// Ex3
// Complete this function. Verify that this function is correct by changing the original definition of `multiplexer5` to only: `return multiplexer_n(sel, a, b);`.

    Bit#(n) chosenOne_n;
    for(Integer i = 0; i < valueOf(n); i = i + 1) begin
        chosenOne_n[i] = multiplexer1(sel, a[i], b[i]);
    end
    return chosenOne_n;

    //return (sel == 0)? a : b;
endfunction
