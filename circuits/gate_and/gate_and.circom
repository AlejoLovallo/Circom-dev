pragma circom 2.0.0;

import "../binary_check/binary_check.circom"
import "multiplier2.circom"

template And2(){
   //Declaration of signals and components.
   signal input in1;
   signal input in2;
   signal output out;
   component mult = Multiplier2();
   component binCheck[2];

   //Statements.
   binCheck[0] = binaryCheck();
   binCheck[0].in <== in1;
   binCheck[1] = binaryCheck();
   binCheck[1].in <== in2;
   mult.in1 <== binCheck[0].out;
   mult.in2 <== binCheck[1].out;
   out <== mult.out;
}

component main = And2();