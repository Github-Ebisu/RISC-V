`ifndef INC_PACKET_SV
`define INC_PACKET_SV

class Packet;
    rand bit[6:0] opcode;
    rand bit[4:0] rs1, rs2, rd;
    rand bit[11:0] imm;
    rand bit[2:0] funct3;
    rand bit[6:0] funct7;
    bit[31:0] instruction;

    constraint randConstraint{
        rd inside{rd != 1'b1};
        opcode inside {7'b011_0011, 7'b001_0011};
        funct7 inside {7'b000_0000, 7'b010_0000};
        imm inside{[0:1024]};
    }


    string name;    // message for debuging

    extern function new(string name = "Packet");
    extern function void display();
    extern function void generatePacket();
    extern function bit compare(Packet pkt);
endclass //Packet


function Packet::new(string name);
    this.name = name;
endfunction

function void Packet::display();
    $display("\t\t-------- PACKET ---------- ");


    $display("\n\t\t-------- END PACKET ---------- ");
endfunction

function void Packet::generatePacket();
    $display("\t\t-------- Generate PACKET ---------- ");
        if (opcode == 7'b011_0011) begin
           instruction = {funct7,rs2,rs1,funct3,rd,opcode}; 
        end
        else if (opcode == 7'b001_0011)begin
            instruction = {imm,rs1,funct3,rd,opcode};
        end

    $display("\n\t\t-------- END Generate PACKET ---------- ");
endfunction


function bit Packet::compare(Packet pkt);
    compare = 1;
    if (compare) $display( "Packets match");
endfunction : compare

`endif